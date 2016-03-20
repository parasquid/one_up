$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'one_up'

require "rspec-given"
require "pry"

RSpec.configure do |config|
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end

# taken from http://stackoverflow.com/a/29863372
def Struct.keyed(*attribute_names)
  Struct.new(*attribute_names) do
    define_method(:initialize) do |**kwargs|
      attr_values = attribute_names.map{|a| kwargs.fetch(a) }
      super(*attr_values)
    end
  end
end
