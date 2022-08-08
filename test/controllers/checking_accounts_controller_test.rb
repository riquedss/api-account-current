# frozen_string_literal: true

require 'test_helper'

class CheckingAccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @checking_account = checking_accounts(:one)
  end

  test 'should get index' do
    get checking_accounts_url, as: :json
    assert_response :success
  end

  test 'should create checking_account' do
    assert_difference('CheckingAccount.count') do
      post checking_accounts_url,
           params: { checking_account: { account: @checking_account.account, balance: @checking_account.balance, password_digest: @checking_account.password_digest, status: @checking_account.status } }, as: :json
    end

    assert_response :created
  end

  test 'should show checking_account' do
    get checking_account_url(@checking_account), as: :json
    assert_response :success
  end

  test 'should update checking_account' do
    patch checking_account_url(@checking_account),
          params: { checking_account: { account: @checking_account.account, balance: @checking_account.balance, password_digest: @checking_account.password_digest, status: @checking_account.status } }, as: :json
    assert_response :success
  end

  test 'should destroy checking_account' do
    assert_difference('CheckingAccount.count', -1) do
      delete checking_account_url(@checking_account), as: :json
    end

    assert_response :no_content
  end
end
