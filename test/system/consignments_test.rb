require "application_system_test_case"

class ConsignmentsTest < ApplicationSystemTestCase
  setup do
    @consignment = consignments(:one)
  end

  test "visiting the index" do
    visit consignments_url
    assert_selector "h1", text: "Consignments"
  end

  test "creating a Consignment" do
    visit consignments_url
    click_on "New Consignment"

    fill_in "Bundles", with: @consignment.bundles
    fill_in "Company code", with: @consignment.company_code
    fill_in "Pallets", with: @consignment.pallets
    fill_in "Parcels", with: @consignment.parcels
    fill_in "Reference", with: @consignment.reference
    click_on "Create Consignment"

    assert_text "Consignment was successfully created"
    click_on "Back"
  end

  test "updating a Consignment" do
    visit consignments_url
    click_on "Edit", match: :first

    fill_in "Bundles", with: @consignment.bundles
    fill_in "Company code", with: @consignment.company_code
    fill_in "Pallets", with: @consignment.pallets
    fill_in "Parcels", with: @consignment.parcels
    fill_in "Reference", with: @consignment.reference
    click_on "Update Consignment"

    assert_text "Consignment was successfully updated"
    click_on "Back"
  end

  test "destroying a Consignment" do
    visit consignments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Consignment was successfully destroyed"
  end
end
