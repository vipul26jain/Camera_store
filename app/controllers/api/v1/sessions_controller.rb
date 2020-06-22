module Api
  module V1
    class SessionsController < Api::V1::ApiController
      include AuthTokenConcern
      skip_before_action :authenticate_user!, only: [:login]
      before_action :verify_auth_token, only: [:logout]
      before_action :get_user_details, only: [:login]


      # Method to create user session
      def login
        if @user.present? 
          render_success_response({
            user: single_serializer.new(@user, serializer: set_serializer(@user))
          },"user logged in successfully!!")
        else
          render_failure_response(error: 'Invalid credentials')
        end
      end

      # Method to destroy a session
      def logout
        if @auth_token
          @auth_token.destroy
          render_success_response({},"User logout successfully!!")
        else
          render_failure_response(error: 'Auth token is not valid')
        end
      end

      private


      def set_serializer(user)
        return UsersSerializer
      end

      def get_user_details
        begin
          if user_params[:email].present? && user_params[:password].present? 
            user = if user_params[:email].present?  
              User.find_by(email: user_params[:email])
            end           
            if user.present? 
              auth_hash = { user_id: user.id, platform: params['platform'], device_type: params['device_type'], device_udid_number: params['device_udid_number']}
              auth_token = generate_token(auth_hash)
              if auth_token
                @user = user
              end
            end  
          end
        rescue => e
          render_failure_response(error: e.message)
        end
      end

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
    end
  end
end
