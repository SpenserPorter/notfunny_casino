class UsersController < ApplicationController

  def new #New user signup page
  	@user = User.new
  end

  def create #Process user signup
  	@user = User.new(user_params)
  		if @user.save
        Balance.create(user_id: @user.id, balance: 1000)
        sign_in @user
  			flash[:success] = "Now you can give us all your money!"
  			redirect_to @user
  		else
  			render 'new' #kickback to form if save fails
  		end
  end
 
	def show #User Profile page
  	@user = User.find(params[:id])
  end


	private

 	def user_params #set which params are required, which are permitted for safety
 		params.require(:user).permit( :name, :email, :password, :password_confirmation )
 	end 

end
