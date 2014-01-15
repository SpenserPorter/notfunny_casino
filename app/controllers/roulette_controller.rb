class RouletteController < ApplicationController

	def index
		@user = current_user
		@balance = current_balance
	end

	def get

	end

	def create
	 @balance = current_balance
	 @user = current_user

	 	if params[:wager].to_i <= @balance.balance

			spin = rand(2)

			if params[:bet].to_i == spin
				flash[:success] = "You win #{params[:wager]}"
				newbalance =  @balance.balance + params[:wager].to_i
				@balance.update_attribute(:balance, newbalance)
			else
				flash[:error] = "You lose #{params[:wager]}"
				newbalance = @balance.balance - params[:wager].to_i
				@balance.update_attribute(:balance, newbalance)
			end
			redirect_to :back
		else
			flash[:error] = "Invalid wager!!!"
			redirect_to :back
		end
	end

	
end


