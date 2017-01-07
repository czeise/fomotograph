require 'HTTParty'
require 'json'

# Product model
class Product
  attr_reader :id, :title, :location, :summary, :url, :price

  url = 'https://fomotograph-api.udacity.com/products.json'
  DATA = HTTParty.get(url)['photos']
  LOCATIONS = %w(canada england france ireland mexico scotland taiwan us).freeze

  def initialize(product_data = {})
    @id = product_data['id']
    @title = product_data['title']
    @location = product_data['location']
    @summary = product_data['summary']
    @url = product_data['url']
    @price = product_data['price']
  end

  def self.all
    DATA.map { |product| new(product) }
  end

  def self.sample_locations
    products = []
    LOCATIONS.each do |location|
      products << all.select { |product| product.location == location }.sample
    end
    products
  end

  def self.find_by_location(location)
    all.select { |product| product.location == location }
  end

  def self.find(id)
    all.select { |product| product.id == id.to_i }.first
  end

  def self.find_deals(price)
    all.select { |product| product.price < price }
  end
end
