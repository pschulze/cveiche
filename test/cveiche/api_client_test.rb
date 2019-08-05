# frozen_string_literal: true

require 'test_helper'

class ApiClientTest < Minitest::Test
  def setup
    @api_client = Cveiche::ApiClient.new
    @vendor = 'tesla'
    @product = 'gateway_ecu'
    @cve_id = 'CVE-2016-9337'
  end

  def test_list_vendors
    VCR.use_cassette('list_vendors') do
      vendors = @api_client.list_vendors
      refute_nil vendors
      assert_equal 6818, vendors.count
    end
  end

  def test_products_for_vendor
    VCR.use_cassette('products_for_vendor_valid') do
      products = @api_client.products_for_vendor(@vendor)
      refute_nil products
      assert_equal 1, products.count
    end
  end

  def test_products_for_vendor_reutrns_nil_for_invalid_vendor
    VCR.use_cassette('products_for_vendor_invalid') do
      products = @api_client.products_for_vendor('not_a_real_vendor')
      assert_nil products
    end
  end

  def test_cves_for_vendor_product
    VCR.use_cassette('cves_for_vendor_product_valid') do
      cves = @api_client.cves_for_vendor_product(@vendor, @product)
      refute_nil cves
      assert_equal 1, cves.count
    end
  end

  def test_cves_for_vendor_product_returns_nil_for_invalid_product
    VCR.use_cassette('cves_for_vendor_product_invalid_product') do
      cves = @api_client.cves_for_vendor_product(@vendor, 'not_a_real_product')
      assert_nil cves
    end
  end

  def test_cves_for_vendor_product_returns_nil_for_invalid_vendor
    VCR.use_cassette('cves_for_vendor_product_invalid_vendor') do
      cves = @api_client.cves_for_vendor_product('not_a_real_vendor', @product)
      assert_nil cves
    end
  end

  def test_cve_for_id
    VCR.use_cassette('cve_for_id') do
      cve = @api_client.cve_for_id(@cve_id)
      refute_nil cve
      assert_equal @cve_id, cve['id']
    end
  end

  def test_cve_for_id_returns_nil_for_invalid_cve_id
    VCR.use_cassette('cve_for_id_invalid') do
      cve = @api_client.cve_for_id('not_a_real_id')
      assert_nil cve
    end
  end
end
