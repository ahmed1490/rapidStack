class AccessController < ApplicationController
  
  before_filter :confirm_logged_in, :except => [:login, :attempt_login, :logout]


  def login
  	redirect_to "/" unless session[:user_id].nil?
  end

  def attempt_login
  	authorized_user = User.authenticate( params[:email], params[:password] )
  	if authorized_user
  		session[:user_id] = authorized_user.id
  		session[:name] = authorized_user.name
  		session[:usertype] = case authorized_user.usertype
	  							when 0 then "admin"
	  							when 1 then "user"
	  						 end
  		flash[:notice] = "You are logged in now!"
  		redirect_to "/upload"
  	else
  		flash[:alert] = "Invalid username/password!"
  		redirect_to :action => :login
  	end
  end

  def logout
  	session[:user_id] = nil
  	session[:name] = nil
  	session[:usertype] = nil
  	flash[:notice] = "You have been logged out successfully!"
  	redirect_to "/login"
  end

end
