class GraphQLControllerTest < ActionDispatch::IntegrationTest
  test "should execute graphql queries" do
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
          "id" => "242320449",
          "mass" => 77,
          "name" => "Luke Skywalker",
          "skinColor" => "fair",
        },
        "film" => {
          "director" => "George Lucas",
          "episodeID" => 4,
          "id" => "846649883",
          "producers" => ["GaryKurtz", "RickMcCallum"],
          "releaseDate" => "1977-05-25",
          "title" => "A New Hope"
        },
        "planet" => {
          "climate" => "temperate",
          "diameter" => 12500,
          "gravity" => "1 standard",
          "id" => "688730903",
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
          "id" => "299344798",
          "language" => "Huttese",
          "name" => "Hutt",
          "skinColors" => ["green", "brown", "tan"],
        },
        "starship" => {
          "id" => "113504200",
          "name" => "Millennium Falcon",
          "model" => "YT-1300 light freighter",
          "MGLT" => 75,
          "cargoCapacity" => 100000.0,
          "consumables" => "2 months",
          "costInCredits" => 100000.0,
          "created_at" => "2014-12-10 16:59:45 UTC",
          "crew" => "4",
          "hyperdriveRating" => 0.5,
          "length" => 34.37,
          "manufacturer" => "Corellian Engineering Corporation",
          "maxAtmospheringSpeed" => 1050,
          "passengers" => "6",
          "pilots" => [
            { "name" => "Chewbacca" },
            { "name" => "Han Solo" },
            { "name" => "Lando Calrissian" },
            { "name" => "Nien Nunb" },
            { "name" => "Chewbacca" },
            { "name" => "Han Solo" },
            { "name" => "Lando Calrissian" },
            { "name" => "Nien Nunb" }
          ],
          "starshipClass" => "Light freighter"
        }
      }
    }

    assert_equal expected, JSON.parse(response.body)
  end

  private

  def full_graphql_query
    "
      query Full($personID: ID, $filmID: ID, $planetID: ID, $starshipID: ID, $speciesID: ID) {
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
          created_at
          crew
          hyperdriveRating
          length
          manufacturer
          maxAtmospheringSpeed
          passengers
          pilots { name }
          starshipClass
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

    {
      "starshipID" => starship.id,
      "personID" => person.id,
      "filmID" => film.id,
      "planetID" => planet.id,
      "speciesID" => species.id
    }
  end
end
