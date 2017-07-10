class AddConfirmationsToUser < ActiveRecord::Migration[5.1]
  def change
      add_column :users, :password_confirmation, :string
      add_column :users, :email_confirmation, :string
  end
end


# < ======= User Table: password_confirmation, email_confirmation ======= >
