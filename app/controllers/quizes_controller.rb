class QuizesController < ApplicationController
	before_filter :authenticate_user!

	def builder
		@no_left_bar = true
		@quiz = current_account.quizzes.find(params[:id])
	end
end
