require "application_system_test_case"

class CustomersTest < ApplicationSystemTestCase
  setup do
    @customer = customers(:one)
  end

  test "visiting the index" do
    visit customers_url
    assert_selector "h1", text: "Customers"
  end

  test "creating a Customer" do
    visit customers_url
    click_on "New Customer"

    fill_in "Address1", with: @customer.address1
    fill_in "Address2", with: @customer.address2
    fill_in "Address3", with: @customer.address3
    fill_in "Company name", with: @customer.company_name
    fill_in "Consignment", with: @customer.consignment_id
    fill_in "Consignments count", with: @customer.consignments_count
    fill_in "Country", with: @customer.country
    fill_in "Customer code", with: @customer.customer_code
    fill_in "Eircode", with: @customer.eircode
    fill_in "User", with: @customer.user_id
    click_on "Create Customer"

    assert_text "Customer was successfully created"
    click_on "Back"
  end

  test "updating a Customer" do
    visit customers_url
    click_on "Edit", match: :first

    fill_in "Address1", with: @customer.address1
    fill_in "Address2", with: @customer.address2
    fill_in "Address3", with: @customer.address3
    fill_in "Company name", with: @customer.company_name
    fill_in "Consignment", with: @customer.consignment_id
    fill_in "Consignments count", with: @customer.consignments_count
    fill_in "Country", with: @customer.country
    fill_in "Customer code", with: @customer.customer_code
    fill_in "Eircode", with: @customer.eircode
    fill_in "User", with: @customer.user_id
    click_on "Update Customer"

    assert_text "Customer was successfully updated"
    click_on "Back"
  end

  test "destroying a Customer" do
    visit customers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Customer was successfully destroyed"
  end
end
