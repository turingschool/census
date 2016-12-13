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


  def full_name
    "#{first_name} #{last_name}"
  end
end
