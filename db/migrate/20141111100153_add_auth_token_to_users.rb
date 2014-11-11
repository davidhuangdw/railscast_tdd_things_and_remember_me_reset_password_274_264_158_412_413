class AddAuthTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :auth_token, :string

    User.all.each {|u| u.generate_token(:auth_token); u.save!;}
  end
end
