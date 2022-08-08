# frozen_string_literal: true

require 'test_helper'

class AuthAccountsControllerTest < ActionDispatch::IntegrationTest
  test 'should get signup' do
    get auth_accounts_signup_url
    assert_response :success
  end

  test 'should get login' do
    get auth_accounts_login_url
    assert_response :success
  end
end
