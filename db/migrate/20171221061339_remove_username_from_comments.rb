class RemoveUsernameFromComments < ActiveRecord::Migration[5.1]
  def change
  	remove_column :comments, :username
  end
end
