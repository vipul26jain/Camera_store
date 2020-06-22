module Api
  module V1
    class RegistrationsController < Api::V1::ApiController
      include AuthTokenConcern
      skip_before_action :authenticate_user!

      # Method to create user
      def create
        begin
          ActiveRecord::Base.transaction do
            if params[:user][:password].present?
              if params[:user][:password] == params[:user][:password_confirmation]
                @user = User.new(user_params)
                if @user.save!
                  auth_hash = { user_id: @user.id, platform: params['platform'], device_type: params['device_type'], device_udid_number: params['device_udid_number']}
                  _ = generate_token(auth_hash)
                  render_success_response({
                    user: single_serializer.new(@user, serializer: set_serializer(@user))
                  }, "User created successfully")
                else
                  render_failure_response(error: e.message)
                end
              else
                render_failure_response(error: 'Password does not match')
              end
            else
              render_failure_response(error: 'Enter complete details to continue')
            end  
          end
        rescue => e
         render_failure_response(error: e.message)
       end
     end

      private

      
      def set_serializer(user)
          return UsersSerializer
      end

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
    end  
  end
end
