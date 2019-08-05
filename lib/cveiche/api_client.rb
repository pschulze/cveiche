# frozen_string_literal: true

require 'net/hippie'

module Cveiche
  # Class for making API calls against cve.circl.lu
  class ApiClient
    BASE_URI = 'https://cve.circl.lu/api'

    def initialize
      @client = Net::Hippie::Client.new
    end

    def list_vendors
      uri = URI.parse(BASE_URI + '/browse')
      response = @client.get(uri)
      json = JSON.parse(response.body)
      json['vendor']
    end

    def products_for_vendor(vendor)
      uri = URI.parse(BASE_URI + '/browse' + "/#{vendor}")
      response = @client.get(uri)
      json = JSON.parse(response.body)
      json.empty? ? nil : json['product']
    end

    def cves_for_vendor_product(vendor, product)
      uri = URI.parse(BASE_URI + '/search' + "/#{vendor}" + "/#{product}")
      response = @client.get(uri)
      json = JSON.parse(response.body)
      cves = []
      json.each { |item| cves << item['id'] }
      json.empty? ? nil : cves
    end

    def cve_for_id(cve_id)
      uri = URI.parse(BASE_URI + '/cve' + "/#{cve_id}")
      response = @client.get(uri)
      JSON.parse(response.body)
    end
  end
end
