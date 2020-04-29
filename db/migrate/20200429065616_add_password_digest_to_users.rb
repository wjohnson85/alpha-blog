class AddPasswordDigestToUsers < ActiveRecord::Migration[6.0]
  def change
    # add password to user model
    add_column :users, :password_digest, :string
  end
end
