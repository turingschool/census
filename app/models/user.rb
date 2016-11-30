class User < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email

  def self.start_to_create(user_params)
    new(  first_name: user_params["first_name"],
          last_name:  user_params["last_name"],
          email:      user_params["email"],
          token:      token(user_params["email"]))
  end

  private

    def self.token(text)
      Digest::SHA256.hexdigest(text)
    end

end
