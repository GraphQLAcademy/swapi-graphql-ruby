# Need to move this to a series of rake tasks

require 'starwars'

def to_planet_fixture(planet)
  planet = planet.to_h.slice(
    :name, :diameter, :rotation_period, :orbital_period,
    :gravity, :population, :climate, :terrain, :surface_water,
    :created, :edited,
  )

  planet[:population] = planet[:population].to_f / 1000000 if planet[:population] && planet[:population] != 'unknown'

  to_fixture(planet)
end

def to_person_fixture(person)
  person = person.to_h.slice(
    :name, :birth_year, :eye_color, :gender, :hair_color,
    :height, :mass, :skin_color, :homeworld, :starships, :vehicles, :species,
    :created, :edited,
  )

  starships = person.delete(:starships)
  if starships.present?
    person[:starships] = starships.map{ |starship_url| slug(Starships[starship_url].name) }
  end

  vehicles = person.delete(:vehicles)
  if vehicles.present?
    person[:vehicles] = vehicles.map{ |vehicle_url| slug(Vehicles[vehicle_url].name) }
  end

  homeworld = Planets[person.delete(:homeworld)]
  person[:homeworld] = slug(homeworld.name) if homeworld

  species = person.delete(:species)
  if species.present?
    person[:species] = slug(Species[species.first].name)
  end

  to_fixture(person)
end

def to_starship_fixture(starship)
  starship = starship.to_h.slice(
    :name, :model, :manufacturer, :cost_in_credits, :length,
    :max_atmosphering_speed, :crew, :passengers, :cargo_capacity, :consumables,
    :hyperdrive_rating, :MGLT, :starship_class, :pilots,
    :created, :edited,
  )

  pilots = starship.delete(:pilots)
  if pilots.present?
    starship[:pilots] = pilots.map{ |person_url| slug(People[person_url].name) }
  end

  to_fixture(starship)
end

def to_vehicle_fixture(vehicle)
  vehicle = vehicle.to_h.slice(
    :name, :model, :manufacturer, :cost_in_credits, :length, :vehicle_class,
    :max_atmosphering_speed, :crew, :passengers, :cargo_capacity, :consumables, :pilots,
    :created, :edited,
  )

  pilots = vehicle.delete(:pilots)
  if pilots.present?
    vehicle[:pilots] = pilots.map{ |person_url| slug(People[person_url].name) }
  end

  to_fixture(vehicle)
end

def to_species_fixture(species)
  species = species.to_h.slice(
    :name, :classification, :designation, :average_height, :average_lifespan,
    :eye_colors, :hair_colors, :skin_colors, :language, :homeworld,
    :created, :edited,
  )

  species.delete(:eye_colors) if species[:eye_colors] == 'none'
  species.delete(:hair_colors) if species[:hair_colors] == 'none'
  species.delete(:skin_colors) if species[:skin_colors] == 'none'

  homeworld = Planets[species.delete(:homeworld)]
  species[:homeworld] = slug(homeworld.name) if homeworld

  to_fixture(species)
end

def to_film_fixture(film)
  film = film.to_h.slice(
    :title, :episode_id, :opening_crawl, :director, :producer, :release_date,
    :species, :starships, :vehicles, :characters, :planets,
    :created, :edited,
  )

  species = film.delete(:species)
  if species.present?
    film[:species] = species.map{ |species_url| slug(Species[species_url].name) }
  end

  starships = film.delete(:starships)
  if starships.present?
    film[:starships] = starships.map{ |starship_url| slug(Starships[starship_url].name) }
  end

  planets = film.delete(:planets)
  if planets.present?
    film[:planets] = planets.map{ |planet_url| slug(Planets[planet_url].name) }
  end

  characters = film.delete(:characters)
  if characters.present?
    film[:characters] = characters.map{ |person_url| slug(People[person_url].name) }
  end

  vehicles = film.delete(:vehicles)
  if vehicles.present?
    film[:vehicles] = vehicles.map{ |vehicle_url| slug(Vehicles[vehicle_url].name) }
  end

  to_fixture(film, slug(film[:title]))
end

def slug(string)
  ActiveSupport::Inflector.parameterize(string)
end

def to_fixture(object, fixture_name = nil)
  fixture_name ||= slug(object[:name])

  object[:created_at] = object.delete(:created) if object.key?(:created)
  object[:updated_at] = object.delete(:edited) if object.key?(:edited)

  {
    "#{fixture_name}" => object.reject{|_, value| value == 'unknown'}.transform_keys{ |key| key.to_s.downcase }
  }
end

def to_fixture_yaml(yaml_string)
  yaml_string.to_yaml
    .gsub(/^---\n/, '')
    .gsub(/^\s{4}/, '  ')
    .gsub(/^\-\s/, "\n")
    .lstrip
end

def load_all(resource_class)
  resources = []

  page_response = resource_class.fetch_all

  while page_response
    resources.push(*page_response.items)
    page_response = page_response.next_page
  end

  resources
end

Planets = Hash[load_all(Starwars::Planet).reject{|planet| planet.name == 'unknown'}.map{|planet| [planet.url, planet]}]
People = Hash[load_all(Starwars::Person).map{|person| [person.url, person]}]
Starships = Hash[load_all(Starwars::Starship).map{|starship| [starship.url, starship]}]
Vehicles = Hash[load_all(Starwars::Vehicle).map{|vehicle| [vehicle.url, vehicle]}]
Species = Hash[load_all(Starwars::Specie).map{|species| [species.url, species]}]
Film = Hash[load_all(Starwars::Film).map{|film| [film.url, film]}]

#puts to_fixture_yaml(People.map{|_, person| to_person_fixture(person)})
#puts to_fixture_yaml(Planets.map{|_, planet| to_planet_fixture(planet)})
#puts to_fixture_yaml(Starships.map{|_, starship| to_starship_fixture(starship)})
#puts to_fixture_yaml(Vehicles.map{|_, vehicle| to_vehicle_fixture(vehicle)})
#puts to_fixture_yaml(Species.map{|_, species| to_species_fixture(species)})
puts to_fixture_yaml(Film.map{|_, film| to_film_fixture(film)})

#Starships.each do |_, starship|
#  fixture = to_people_starships_fixture(starship)
#
#  if fixture
#    fixture.each do |k,v|
#      puts to_fixture_yaml({k => v})
#      puts "\n"
#    end
#  end
#end

#puts planets
#puts planets.flatten.map{|planet| to_planet_fixture(planet)}.to_yaml
exit

require 'json'
require 'net/http'
require 'uri'

uri = URI.parse('http://swapi.co/api/planets/')
http = Net::HTTP.new(uri.host)
response = http.get(uri.path, {"Accept" => "application/json"})

case response
when Net::HTTPOK
  parsed_body = JSON.parse(response.body)

  p parsed_body['next']
else

end
