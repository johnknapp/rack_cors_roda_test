# frozen_string_literal: true

require './rack_cors_roda'
run RackCorsRoda.freeze.app
