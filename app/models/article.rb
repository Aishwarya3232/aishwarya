class Article < ApplicationRecord
	belongs_to :user
	has_many :article_categories
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
	has_many :categories, through: :article_categories
	validates :title, presence: true, length: {minimum: 3, maximum: 30}
	validates :description, presence: true, length: {minimum: 10, maximum: 300}
	validates :user_id, presence: true

	 def addlike(user)
    	likes << Like.new(user_id: user.id, status: true)
  	end

  	def adddislike(user)
    	likes << Like.new(user_id: user.id, status: false)
  	end

  	def becomeneutral(user)
  		likes.where(user_id: user.id).first.destroy
  	end

    def likes?(user)
      likes.where(user_id: user.id, status: true).count > 0
    end

    def dislikes?(user)
      likes.where(user_id: user.id, status: false).count > 0
    end

    def num_likes
      likes.where(status: true).count
    end
    
     def num_dislikes
      likes.where(status: false).count
    end
end