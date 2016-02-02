require_relative 'boot'
require 'ostruct'

Bundler.require
Dir['app/models/**/*'].each { |file| require "./#{file}" }

class Application

  include ActiveSupport::Configurable

  config.data_path = File.expand_path('../../data/contractsearch.csv', __FILE__)

  def self.run options = {}
    ContractSearch.configure!

    # First array element is a duration, the second - is the contract sum
    data   = ContractSearch.prepared_data
    kmeans = KMeans.new(data, :centroids => 3)
  end

end
