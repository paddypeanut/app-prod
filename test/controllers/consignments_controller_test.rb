require 'test_helper'

class ConsignmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @consignment = consignments(:one)
  end

  test "should get index" do
    get consignments_url
    assert_response :success
  end

  test "should get new" do
    get new_consignment_url
    assert_response :success
  end

  test "should create consignment" do
    assert_difference('Consignment.count') do
      post consignments_url, params: { consignment: { bundles: @consignment.bundles, company_code: @consignment.company_code, pallets: @consignment.pallets, parcels: @consignment.parcels, reference: @consignment.reference } }
    end

    assert_redirected_to consignment_url(Consignment.last)
  end

  test "should show consignment" do
    get consignment_url(@consignment)
    assert_response :success
  end

  test "should get edit" do
    get edit_consignment_url(@consignment)
    assert_response :success
  end

  test "should update consignment" do
    patch consignment_url(@consignment), params: { consignment: { bundles: @consignment.bundles, company_code: @consignment.company_code, pallets: @consignment.pallets, parcels: @consignment.parcels, reference: @consignment.reference } }
    assert_redirected_to consignment_url(@consignment)
  end

  test "should destroy consignment" do
    assert_difference('Consignment.count', -1) do
      delete consignment_url(@consignment)
    end

    assert_redirected_to consignments_url
  end
end
