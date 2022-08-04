class ApplicationController < ActionController::API
    def current_user     
        return nil if !token || !decoded_payload
        User.find_by(id: decoded_payload[0]["user_id"])
    end

    def verify_authenticated_user
        if !current_user
            render(json: { message: "You aren't authenticated." }, status: 401)
        end
    end

    def verify_authenticated_adm
        @user = current_user
        if !@user|| !@user.manager?
            render(json: { message: "You aren't authenticated." }, status: 401)
        end
    end

    def current_checking_account
        return nil if !token || !decoded_payload
        Checking_account.find_by(id: decoded_payload[0]["checking_account_id"])
    end

    def verify_authenticated_checking_account
        if !current_checking_account
            render(json: { message: "You aren't authenticated." }, status: 401)
        end
    end

    def token
        request.headers["token"]
    end

    def decoded_payload
        JsonWebToken::Base.decode(token)
    end
end
