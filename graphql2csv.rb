require 'net/http'
require 'uri'
require 'json'
require 'pp'

if not ENV.has_key?('TOKEN')
    puts "Please set the env: TOKEN"
    exit
end

query = { 
    "query": "query {
        user(login: \"drazisil\") {
        createdAt
        repositories(first: 100) {
          nodes {
            name
            url
            createdAt
          }
        }
      }
    }"
}.to_json

res = Net::HTTP.post URI('https://api.github.com/graphql'),
               query,
               "Content-Type" => "application/json",
               "Authorization" => "bearer " + ENV['TOKEN']

               puts ("Something went wrong fetching JSON, returned: " + res) if not res.is_a?(Net::HTTPSuccess)

        responseJSON = JSON.parse(res.body)['data']

               
puts JSON.pretty_generate(responseJSON) 