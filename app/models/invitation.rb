class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :role
  validates_uniqueness_of :email
  validates_presence_of :email
  validates_format_of :email, :with => /@/
  validates_presence_of :status

  enum status: [:queued, :mailed, :accepted, :rescinded]

  def send!
    InvitationMailer.invite(self).deliver_now
    self.mailed!
  end

  def create_invitation_code
    self.invitation_code = Digest::SHA256.hexdigest part_1 + part_2
    save
    invitation_code
  end

  def generate_url
    url + "?invite_code=#{create_invitation_code}"
  end

  private

    def url
      host = ENV["RAILS_ENV"] == "production" ? "https://census-app-staging.herokuapp.com" : "localhost:3000"
      Rails.application.routes.url_helpers.new_user_registration_url(host: host)
    end

    def part_1
      "#{email} #{created_at} "
    end

    def part_2
      ENV["SALT"]
    end
end
