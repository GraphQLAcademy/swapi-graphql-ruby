class GraphQLControllerTest < ActionDispatch::IntegrationTest
  test "#execute executes graphql queries" do
    post graphql_url, params: { query: full_graphql_query, variables: default_variables }

    expected = {
      "data" => {
        "person" => {
          "birthYear" => "19BBY",
          "eyeColor" => "blue",
          "gender" => "MALE",
          "hairColor" => "blond",
          "height" => 172,
          "homeworld" => {
            "name" => "Tatooine"
          },
          "id" => "gid://swapi/Person/242320449",
          "mass" => 77,
          "name" => "Luke Skywalker",
          "skinColor" => "fair",
        },
        "film" => {
          "director" => "George Lucas",
          "episodeID" => 4,
          "id" => "gid://swapi/Film/846649883",
          "producers" => ["Gary Kurtz", "Rick McCallum"],
          "releaseDate" => "1977-05-25",
          "title" => "A New Hope"
        },
        "planet" => {
          "climate" => "temperate",
          "diameter" => 12500,
          "gravity" => "1 standard",
          "id" => "gid://swapi/Planet/688730903",
          "name" => "Alderaan",
          "orbitalPeriod" => 364,
          "population" => 2000.0,
          "rotationPeriod" => 24,
          "surfaceWater" => 40.0,
          "terrain" => "grasslands, mountains",
        },
        "species" => {
          "averageHeight" => 300.0,
          "averageLifespan" => 1000,
          "classification" => "gastropod",
          "designation" => "sentient",
          "eyeColors" => ["yellow", "red"],
          "hairColors" => ["n/a"],
          "homeworld" => { "name" => "Nal Hutta" },
          "id" => "gid://swapi/Species/299344798",
          "language" => "Huttese",
          "name" => "Hutt",
          "skinColors" => ["green", "brown", "tan"],
        },
        "starship" => {
          "id" => "gid://swapi/Starship/113504200",
          "name" => "Millennium Falcon",
          "model" => "YT-1300 light freighter",
          "MGLT" => 75,
          "cargoCapacity" => 100000.0,
          "consumables" => "2 months",
          "costInCredits" => 100000.0,
          "createdAt" => "2014-12-10 16:59:45 UTC",
          "crew" => "4",
          "hyperdriveRating" => 0.5,
          "length" => 34.37,
          "manufacturer" => "Corellian Engineering Corporation",
          "maxAtmospheringSpeed" => 1050,
          "passengers" => "6",
          "starshipClass" => "Light freighter"
        },
        "vehicle" => {
          "id" => "gid://swapi/Vehicle/82948950",
          "name" => "Snowspeeder",
          "model" => "t-47 airspeeder",
          "cargoCapacity" => 10.0,
          "consumables" => "none",
          "costInCredits" => nil,
          "createdAt" => "2014-12-15 12:22:12 UTC",
          "crew" => "2",
          "length" => 4.5,
          "manufacturer" => "Incom corporation",
          "maxAtmospheringSpeed" => 650,
          "passengers" => "0",
          "vehicleClass"=>"airspeeder"
        }
      }
    }

    assert_equal expected, JSON.parse(response.body)
  end

  test '#execute can execute node queries' do
    starship = starships(:"millennium-falcon")

    query = "
      query {
        node(id: \"#{starship.to_global_id.to_s}\") {
           ... on Starship {
             name
           }
        }
      }
    "

    expected = { "data" => { "node" => { "name" => "Millennium Falcon" } } }

    post graphql_url, params: { query: query }

    assert_equal expected, JSON.parse(response.body)
  end

  test "#execute allows authentication via basic auth" do
    query = """
    {
      viewer {
        username
      }
    }
"""

    expected = {
      "data" => {
        "viewer" => {
          "username" => "xuorig"
        }
      }
    }

    post graphql_url, params: { query: query }, headers: {
      "Authorization" => ActionController::HttpAuthentication::Basic.encode_credentials("xuorig", "averysecurepassword"),
    }

    assert_equal expected, JSON.parse(response.body)
  end

  test "#execute authentication is not required" do
    query = """
    {
      viewer {
        username
      }
    }
"""

    expected = {
      "data" => {
        "viewer" => nil
      }
    }

    post graphql_url, params: { query: query }

    assert_equal expected, JSON.parse(response.body)
  end

  private

  def full_graphql_query
    "
      query Full($personID: ID!, $filmID: ID!, $planetID: ID!, $starshipID: ID!, $speciesID: ID!, $vehicleID: ID!) {
        person(id: $personID) {
          birthYear
          eyeColor
          gender
          hairColor
          height
          homeworld { name }
          id
          mass
          name
          skinColor
        }
        film(id: $filmID) {
          director
          episodeID
          id
          producers
          releaseDate
          title
        }
        planet(id: $planetID) {
          climate
          diameter
          gravity
          id
          name
          orbitalPeriod
          population
          rotationPeriod
          surfaceWater
          terrain
        }
        species(id: $speciesID) {
          averageHeight
          averageLifespan
          classification
          designation
          eyeColors
          hairColors
          homeworld { name }
          id
          language
          name
          skinColors
        }
        starship(id: $starshipID) {
          id
          name
          model
          MGLT
          cargoCapacity
          consumables
          costInCredits
          createdAt
          crew
          hyperdriveRating
          length
          manufacturer
          maxAtmospheringSpeed
          passengers
          starshipClass
        }
        vehicle(id: $vehicleID) {
          id
          name
          model
          cargoCapacity
          consumables
          costInCredits
          createdAt
          crew
          length
          manufacturer
          maxAtmospheringSpeed
          passengers
          vehicleClass
        }
      }
    "
  end

  def default_variables
    starship = starships(:"millennium-falcon")
    person = people(:"luke-skywalker")
    film = films(:"a-new-hope")
    planet = planets(:alderaan)
    species = species(:hutt)
    vehicle = vehicles(:snowspeeder)

    {
      "starshipID" => starship.to_global_id,
      "personID" => person.to_global_id,
      "filmID" => film.to_global_id,
      "planetID" => planet.to_global_id,
      "speciesID" => species.to_global_id,
      "vehicleID" => vehicle.to_global_id,
    }
  end
end
