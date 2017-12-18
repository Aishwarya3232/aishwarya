class Article < ApplicationRecord
	belongs_to :user
	has_many :article_categories
	has_many :categories, through: :article_categories
	validates :title, presence: true, length: {minimum: 3, maximum: 30}
	validates :description, presence: true, length: {minimum: 10, maximum: 300}
	validates :user_id, presence: true

	def like(user)
    	article_likes << ArticleLike.new(user_id: user)
  	end

  	def dislike(user)
    	article_likes << ArticleLike.new(user_id: user.id)
  	end

  	def neutral(user)
  		article_likes.where(user_id: user.id).first.destroy
  	end
end