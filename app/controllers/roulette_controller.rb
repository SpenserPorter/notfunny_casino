class RouletteController < ApplicationController

before_action :signed_in_user


	def index
		@user = current_user
	end

	def get

	end

	def create
	 @user = current_user

		 if params[:bets].nil? == false && params[:wager].to_i != 0 && params[:wager].to_i * params[:bets].count <= @user.balance.balance
		 #debt the balance the total wager, 
		 #which is the number in the wager box times the number of unique wagers

		 debtwager = @user.balance.balance - (params[:wager].to_i * params[:bets].count)
		 @user.balance.update_attribute(:balance, debtwager)


		 #parse :bets param array into array of numbers according to roulette table layout
		 allbets = []
		 @payout = 0
		 spin = rand(36)+1

		 params[:bets].each do |f|

		 	if f == "red"
		 		allbets = [1,3,5,7,9,12,14,16,18,19,21,23,25,27,30,32,34,36]

		 	elsif f == "black"
		 		allbets = [2,4,6,8,10,11,13,15,17,20,22,24,26,28,29,31,33,35]

		 	elsif f == "even"
		 		allbets = [2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36]

		 	elsif f == "odd"
		 		allbets = [1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35]

		 	elsif f == "1st_12"
		 		allbets = [1,2,3,4,5,6,7,8,9,10,11,12]

		 	elsif f == "2nd_12"
		 		allbets = [13,14,15,16,17,18,19,20,21,22,23,24]

		 	elsif f == "3rd_12"
		 		allbets = [25,26,27,28,29,30,31,32,33,34,35,36]

		 	else
		 		allbets = [f.to_i]
		 	end

		 	@payout += allbets.select{|x| x == spin}.count  *  params[:wager].to_i * 36 / allbets.count.to_f

		 end


		 	
		 		#determine outcome, calculate amount won
				

				
				addwinnings = @user.balance.balance + @payout
				@user.balance.update_attribute(:balance, addwinnings)

				flash[:success] = "Result:#{spin} You wagered #{params[:wager].to_i * params[:bets].count}, and won #{@payout.to_i}. "
				redirect_to :back

		else
			flash[:success] = "That is not a valid bet!!"
			redirect_to :back
		end



			#if allbets.select(spin) == spin
			#	flash[:success] = "You win #{params[:wager]}"
			#	newbalance =  @user.balance.balance + params[:wager].to_i
			#	@user.balance.update_attribute(:balance, newbalance)
			#else
			#	flash[:error] = "You lose #{params[:wager]}"
			#	newbalance = @user.balance.balance - params[:wager].to_i
			#	@user.balance.update_attribute(:balance, newbalance)
			#end
			#
	end

	def signed_in_user
		redirect_to signin_url, notice: "You must be signed in to use that!" unless signed_in?
	end
end


