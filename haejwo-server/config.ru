require_relative 'config/environment'

run Rails.application

if defined?(PhusionPassenger)
  PhusionPassenger.advertised_concurrency_level = 0
end
