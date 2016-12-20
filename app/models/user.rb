class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :affiliations, dependent: :destroy
  has_many :groups, through: :affiliations
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :invitations


  # paperclip configuration
  has_attached_file :image, default_url: "images/:style/missing.png", styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment :image, content_type: { content_type: ["image/jpeg",
                                                              "image/gif",
                                                              "image/png"] }


  def full_name
    "#{first_name} #{last_name}"
  end

  def list_roles
    roles.map { |role| role.name }.join(', ')
  end
end
