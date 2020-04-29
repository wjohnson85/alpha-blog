class AddUserIdToArticles < ActiveRecord::Migration[6.0]
  def change
    # add_column takes the name of the table, the column you want to add, and the type
    add_column :articles, :user_id, :int
  end
end
