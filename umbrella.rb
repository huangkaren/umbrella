require "http"
require "json"


pp "Will you need an umbrella today? Where are you?"
user_location = gets.chomp



gmaps_key = ENV.fetch("GMAPS_KEY")
gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{gmaps_key}"

raw_gmaps_data = HTTP.get(gmaps_url)
parsed_gmaps_data = JSON.parse(raw_gmaps_data)
results_array = parsed_gmaps_data.fetch("results")
first_result = results_array.at(0)
geometry = first_result.fetch("geometry")
location = geometry.fetch("location")
latitude = location.fetch("lat")
longitude = location.fetch("lng")

puts "Your location is #{latitude}, #{longitude}"



pirate_weather_key = ENV.fetch("PIRATE_WEATHER_KEY")

pirate_weather_url = "https://api.pirateweather.net/forecast/#{pirate_weather_key}/#{latitude},#{longitude}"


raw_pirate_weather_data = HTTP.get(pirate_weather_url)

parsed_pirate_weather_data = JSON.parse(raw_pirate_weather_data)

currently_hash = parsed_pirate_weather_data.fetch("currently")

current_temp = currently_hash.fetch("temperature")

puts "It is currently #{current_temp}°F."
