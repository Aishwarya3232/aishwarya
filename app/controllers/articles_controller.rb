class ArticlesController < ApplicationController
	before_action :set_article, only: [:edit, :update, :destroy, :add_comment, :add_like, :delete_comment, :add_dislike]
	before_action :require_user, except: [:index, :show, :add_comment]
	before_action :require_same_user, only: [:edit, :update, :destroy]
	def show
		@article = Article.includes(:comments).find(params[:id])
	end
	def new
		@article = Article.new
	end
	def index
		@article = Article.includes(:categories, :user).paginate(page: params[:page], per_page: 5)
	end
	def create
		@article = Article.new(article_params)
		@article.user = current_user
		if @article.save
			flash[:success] = "Article was created successfully"
			redirect_to article_path(@article)
		else	
			render 'new'
		end
	end
	def edit
	end
	def update
		if @article.update(article_params)
			flash[:success] = "Article was updated successfully"
			redirect_to article_path(@article)
		else	
			render 'edit'
		end
	end
	def destroy
		@article.destroy
		flash[:danger] = "Article was deleted"
		redirect_to articles_path
	end
	def add_like
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

	def add_comment
		if logged_in? 
    		@article.comments << Comment.new(user_id: current_user.id, user_name: current_user.username, description: params[:comment])
		else
    		@article.comments << Comment.new(user_name: "Anonymous", description: params[:comment])
		end
		respond_to do |format|
			format.html
			format.js { render partial: 'articles/comments' }
		end
	end

	def delete_comment
		@article.comments.where(id: params[:comment]).first.destroy
		respond_to do |format|
			format.html
			format.js { render partial: 'articles/comments' }
		end
	end

	private
	def set_article
		@article = Article.find(params[:id])
	end
	def article_params
		params.require(:article).permit(:title, :description, category_ids: [])
	end
	def require_same_user
		if current_user != @article.user && !current_user.admin?
			flash[:danger] = "You can edit or delete only your own articles"
			redirect_to root_path
		end
	end
end
