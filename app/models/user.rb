class User < ApplicationRecord
    # before save lowercase the email self references each obj in the User class
    before_save { self.email = email.downcase }
    has_many :articles
    # validates that there is a username and that there isnt a match in the database regardless of casing, as well as min and max characther limits
    validates :username, presence: true, uniqueness: { case_sensitive: false}, length: { minimum: 3, maximum: 25}
    
    # constant to store regex
    VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
      # validates that there is an email and there isn't a match regardless of case and a maximum length & correct email format with regex
    validates :email, presence: true, 
                        uniqueness: { case_sensitive: false}, 
                        length: { maximum: 105 }, 
                        format: { with: VALID_EMAIL_REGEX }

end