class Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
end


private

def sign_up_params
  params.permit(:name, :email, :password, :password_confirmation)
end