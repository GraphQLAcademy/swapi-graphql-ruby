require 'test_helper'

class Graph::Mutations::FilmRateTest < ActiveSupport::TestCase
  def setup
    @context = {
      user: @user = User.first
    }

    @query_string = "
      mutation ($input: FilmRateInput!) {
        filmRate(input: $input) {
          film {
            title
          }
          rating {
            rating
          }
          errors {
            field
            message
          }
        }
      }
    "

    @film = Film.first

    @variables = {
      "input" => {
        "filmId" => @film.to_global_id.to_s,
        "rating" => 5,
      }
    }
  end

  test "raises an execution error when user is not logged in" do
    expected = {
      "data" => { "filmRate" => nil},
      "errors" => [{
        "message" => "Authentication required to use: Mutation.filmRate",
        "locations" => [{ "line" => 3, "column" => 9}],
        "path" => ["filmRate"]}
      ]
    }

    result = Graph::Schema.execute(@query_string, variables: @variables, context: {})
    assert_equal expected, result
  end

  test "raises an execution error when filmId is invalid" do
    @variables['input']['filmId'] = 'invalid'
    expected = {
      "data" => { "filmRate" => nil},
      "errors" => [{
        "message" => "Invalid filmId.",
        "locations" => [{ "line" => 3, "column" => 9}],
        "path" => ["filmRate"]}
      ]
    }

    result = Graph::Schema.execute(@query_string, variables: @variables, context: @context)
    assert_equal expected, result
  end

  test "returns error when an invalid rating is inputted" do
    @variables['input']['rating'] = 100
    expected = {
      "data" => {
        "filmRate" => {
          "film" => {
            "title" => @film.title
          },
          "rating" => nil,
          "errors" => [
            { "field" => "rating", "message" => "must be less than or equal to 5" }
          ]
        }
      }
    }

    result = Graph::Schema.execute(@query_string, variables: @variables, context: @context)
    assert_equal expected, result
  end

  test "creates a new rating on success" do
    expected = {
      "data" => {
        "filmRate" => {
          "film" => {
            "title" => @film.title
          },
          "rating" => {
            "rating" => 5
          },
          "errors" => [],
        }
      }
    }

    assert_difference "Rating.count", 1 do
      result = Graph::Schema.execute(@query_string, variables: @variables, context: @context)
      assert_equal expected, result
    end

    rating = Rating.last
    assert_equal @film, rating.film
    assert_equal @variables['input']['rating'], rating.rating
    assert_equal @user, rating.user
  end

  test "updates existing rating if user already rated film" do
    expected = {
      "data" => {
        "filmRate" => {
          "film" => {
            "title" => @film.title
          },
          "rating" => {
            "rating" => 5
          },
          "errors" => [],
        }
      }
    }

    rating = @user.ratings.create(film: @film, rating: 1)

    assert_difference "Rating.count", 0 do
      result = Graph::Schema.execute(@query_string, variables: @variables, context: @context)
      assert_equal expected, result
    end

    rating.reload
    assert_equal @variables['input']['rating'], rating.rating
  end
end
