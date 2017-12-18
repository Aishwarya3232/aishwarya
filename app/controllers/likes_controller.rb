class LikesController < ApplicationController

	def add_like
		@article = Article.find(params[:id])
		if(@article.likes?(current_user))
			@article.becomeneutral(current_user)
		else
			if(@article.dislikes?(current_user))
				@article.becomeneutral(current_user)
			end
			@article.addlike(current_user)
		end
		respond_to do |format|
			format.html
			format.js { render partial: 'articles/likes' }
		end
	end

	def add_dislike
		@article = Article.find(params[:id])
		if(@article.dislikes?(current_user))
			@article.becomeneutral(current_user)
		else
			if(@article.likes?(current_user))
				@article.becomeneutral(current_user)
			end
			@article.adddislike(current_user)
		end
		respond_to do |format|
			format.html
			format.js { render partial: 'articles/likes' }
		end
	end

end