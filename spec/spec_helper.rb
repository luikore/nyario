require_relative '../ext/nyario'

require 'rspec'
require 'rspec/autorun'
require 'pry'

RSpec.configure do |config|
  if ENV['STRESS']
    puts "Enabling GC.stress mode"

    config.before :each do
      GC.stress = true
    end

    config.after :each do
      GC.stress = false
    end
  end
end
