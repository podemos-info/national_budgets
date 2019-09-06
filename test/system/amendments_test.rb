require "application_system_test_case"

class AmendmentsTest < ApplicationSystemTestCase
  setup do
    @amendment = amendments(:one)
  end

  test "visiting the index" do
    visit amendments_url
    assert_selector "h1", text: "Amendments"
  end

  test "creating a Amendment" do
    visit amendments_url
    click_on "New Amendment"

    fill_in "Budget", with: @amendment.budget_id
    fill_in "Explanation", with: @amendment.explanation
    fill_in "Number", with: @amendment.number
    fill_in "Type", with: @amendment.type
    fill_in "User", with: @amendment.user_id
    click_on "Create Amendment"

    assert_text "Amendment was successfully created"
    click_on "Back"
  end

  test "updating a Amendment" do
    visit amendments_url
    click_on "Edit", match: :first

    fill_in "Budget", with: @amendment.budget_id
    fill_in "Explanation", with: @amendment.explanation
    fill_in "Number", with: @amendment.number
    fill_in "Type", with: @amendment.type
    fill_in "User", with: @amendment.user_id
    click_on "Update Amendment"

    assert_text "Amendment was successfully updated"
    click_on "Back"
  end

  test "destroying a Amendment" do
    visit amendments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Amendment was successfully destroyed"
  end
end
