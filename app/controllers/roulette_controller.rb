class RouletteController < ApplicationController

	before_action :signed_in_user

	def index
		@user = current_user
	end

	def get

	end

	def create
	 @user = current_user

	 	if params[:wager].to_i <= @user.balance.balance && params[:bet].to_i != 0

			spin = rand(2) + 1

			if params[:bet].to_i == spin
				flash[:success] = "You win #{params[:wager]}"
				newbalance =  @user.balance.balance + params[:wager].to_i
				@user.balance.update_attribute(:balance, newbalance)
			else
				flash[:error] = "You lose #{params[:wager]}"
				newbalance = @user.balance.balance - params[:wager].to_i
				@user.balance.update_attribute(:balance, newbalance)
			end
			redirect_to :back
		else
			flash[:error] = "Invalid wager!!!"
			redirect_to :back
		end
	end

private
	def signed_in_user
		redirect_to signin_url, notice: "Please sign in." unless signed_in?
	end
	
	
end


