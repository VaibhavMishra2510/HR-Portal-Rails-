class SessionsController < ApplicationController
  def omniauth
    auth = request.env['omniauth.auth']
    user = User.find_or_create_by(email: auth.info.email) do |u|
      u.name = auth.info.name
      u.image = auth.info.image
      u.password = SecureRandom.hex(10)
    end

    if user.persisted?
      session[:user_id] = user.id
      redirect_to root_path, notice: "Successfully signed in with #{auth.provider.capitalize}!"
    else
      redirect_to root_path, alert: 'Something went wrong. Please try again.'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Signed out successfully.'
  end
end
