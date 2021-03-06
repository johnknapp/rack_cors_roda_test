# frozen_string_literal: true

require 'roda'
require 'rack/cors'

class RackCorsRoda < Roda

  use Rack::Cors, debug: true, logger: Logger.new(STDOUT) do
    allowed_methods = %i[get post put delete options head]
    allow do
      origins 'https://my-frontend-app.netlify.com'
      resource '*', headers: :any, methods: allowed_methods
    end
  end
  
  plugin :default_headers,
    'Strict-Transport-Security'=>'max-age=16070400;',
    'X-Content-Type-Options'=>'nosniff',
    'X-Frame-Options'=>'deny', 
    'X-XSS-Protection'=>'1; mode=block'
  plugin :halt
  plugin :hash_routes
  plugin :head
  plugin :request_headers
  plugin :json, content_type: 'text/plain'
  plugin :json_parser

  route do |r|

    r.root do
      'hello rack-cors + roda app'
    end

    r.hash_routes

  end

  hash_branch('pizza') do |r|
    r.post do

      # POST /pizza/toppings
      # { "topping": "cheese" }
      r.is 'toppings' do
        params = JSON.parse(r.body.read)

        r.halt(400, error: 'no params!') unless params
        topping = params['topping']
        
        r.halt(400, error: 'no topping!') unless params['topping']
        { your_topping: topping }

      end
    end
  end
end
