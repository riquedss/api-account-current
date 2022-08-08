# frozen_string_literal: true

class ApplicationController < ActionController::API
  def current_user
    payload = decoded_payload
    return nil if !token || !payload

    User.find_by(id: payload[0]['user_id'])
  end

  def verify_authenticated(role = nil)
    @user = current_user
    return @user if @user && (@user.role == role || role_user(role, @user))

    render(json: { message: "You aren't authenticated." }, status: :unauthorized)
  end

  def current_checking_account
    payload = decoded_payload
    return nil if !token || !payload

    CheckingAccount.find_by(id: payload[0]['checking_account_id'])
  end

  def verify_authenticated_checking_account
    @checking_account = current_checking_account
    return @checking_account if @checking_account

    render(json: { message: "You aren't authenticated." }, status: :unauthorized)
  end

  def token
    request.headers['token']
  end

  def decoded_payload
    JsonWebToken::Base.decode(token)
  end

  private

  def role_user(role, user)
    return true if role == 'user' && (user.comum? || user.vip? || user.manager?)
  end
end
