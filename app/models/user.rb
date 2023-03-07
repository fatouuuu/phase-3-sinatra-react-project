class User < ActiveRecord::Base
    has_many :pets
    has_secure_password
    
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true

    # table consists of password_digest as a column to store password hashes in DB
    include BCrypt

    # retrieve password from hash
    def password
        @password ||= Password.new(password_digest)
    end

    # create the password hash
    def password=(new_pass)
        @password = Password.create(new_pass)
        self.password_digest = @password
    end
end
  