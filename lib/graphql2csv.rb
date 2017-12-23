#!/usr/bin/env ruby

require 'net/http'
require 'uri'
require 'json'
require 'pp'

def read_config
  
  if not File.readable?("config.json")
    return nil
  end

  return JSON.parse(File.read("config.json"))
end

def read_query
  
  if not File.readable?("query.gql")
    return nil
  end

  return File.read("query.gql").to_s
end

class GraphQL2CSV

  config = read_config()
  queryBody = read_query()


  config['token'] = ENV['TOKEN'] if ENV.has_key?('TOKEN')

  if config.nil? and not ENV.has_key?('TOKEN')
    puts "Please set the env: TOKEN"
    exit(1)
  end

  query = { 
      query: queryBody
  }.to_json

  res = Net::HTTP.post URI('https://api.github.com/graphql'),
                query,
                "Content-Type" => "application/json",
                "Authorization" => "bearer " + config['token']

                # Check if not authorized
                if res.is_a?(Net::HTTPUnauthorized)                
                  puts "ERROR: Invaild token, please check."
                  exit(1)
                end

                responseJSON = JSON.parse(res.body)

                # Check if there was an error
                if responseJSON['errors']
                  puts ("Something went wrong fetching JSON, returned: " + responseJSON['errors'].join)
                  exit(1)
                end

          data = responseJSON['data']

                
  puts JSON.pretty_generate(data) 
  
end
