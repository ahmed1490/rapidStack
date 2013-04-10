class UsersController < ApplicationController

	before_filter :confirm_logged_in, :except => [:create, :signup, :signup_success]
	#respond_to :html, :json

	def index	#/users
		@users = User.all	
	end

	def new	#users/new
		@user = User.new( :name => 'default' )
		render :signup
	end

	def create #users - post
		@user = User.new( params[:user] )

		if @user.save
			redirect_to "/signup_success"
		else
			render :new
		end
	end

	def show
		@users = [ User.find_by_id(params[:id]) ]
		render :index
	end

	def edit
		#@edit = true
		@user = User.find_by_id(params[:id])
	end

	def update
		@user = User.find( session[:user_id] )

		@user.name = params[:user][:name]
		@user.email = params[:user][:email]
		@user.password = params[:user][:password]

		if @user.save

			#redirect_to "/account" 

			 respond_to do |format|
			 	 if @user.save
		      format.html { 
		      	flash[:notice] = "Update Success!"
		      	redirect_to "/account" 
		      }
		      format.js { flash[:notice] = "Update Success!" }
		    else
		      format.html { 
		      	flash[:error] = "Update Failed!"
		      	redirect_to "/account" 
		      }
		      format.js json => @user.errors
		    end

		   end
		end
	end

	def signup
	end

	def signup_success
	end 

	def account
		params[:id] = session[:user_id]
		edit
	end

end
