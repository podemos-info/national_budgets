# frozen_string_literal: true

require 'test_helper'

class AmendmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @amendment = amendments(:one)
  end

  test 'should get index' do
    get amendments_url
    assert_response :success
  end

  test 'should get new' do
    get new_amendment_url
    assert_response :success
  end

  test 'should create amendment' do
    assert_difference('Amendment.count') do
      post amendments_url, params: { amendment: { budget_id: @amendment.budget_id,
                                                  explanation: @amendment.explanation,
                                                  number: @amendment.number,
                                                  type: @amendment.type,
                                                  user_id: @amendment.user_id } }
    end

    assert_redirected_to amendment_url(Amendment.last)
  end

  test 'should show amendment' do
    get amendment_url(@amendment)
    assert_response :success
  end

  test 'should get edit' do
    get edit_amendment_url(@amendment)
    assert_response :success
  end

  test 'should update amendment' do
    patch amendment_url(@amendment), params: { amendment: { budget_id: @amendment.budget_id,
                                                            explanation: @amendment.explanation,
                                                            number: @amendment.number,
                                                            type: @amendment.type,
                                                            user_id: @amendment.user_id } }
    assert_redirected_to amendment_url(@amendment)
  end

  test 'should destroy amendment' do
    assert_difference('Amendment.count', -1) do
      delete amendment_url(@amendment)
    end

    assert_redirected_to amendments_url
  end
end
