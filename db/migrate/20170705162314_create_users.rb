class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end

# < ======= fname, lname, email, username, password ======= >
