class User < ApplicationRecord
    has_one :address, dependent: :destroy
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy

    validates :username, :uniqueness => true, :presence => { :message => "Username cannot be blank" }
    validates :password, :presence => { :message => "Please enter a password that contains at least 10 letters including at least one number and a special character" }, :confirmation => true
    validates :email, :presence => { :message => "Please enter a valid email" }, :confirmation => true

end
