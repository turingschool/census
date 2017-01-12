class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  before_validation :twitter, :sanitize_inputs
  validates :twitter,
    length: { maximum: 15 },
    format: {
      with: /\A[a-zA-Z0-9_]+\z/,
      message: "accepts only alphanumeric and underscore characters"
    },
    allow_blank: true
  validates :linked_in,
    length: { in: 5..30 },
    format: {
      with: /\A[a-zA-Z0-9]+\z/,
      message: "accepts only alphanumeric characters"
    },
    allow_blank: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :affiliations, dependent: :destroy
  has_many :groups, through: :affiliations
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :invitations

  has_many :oauth_applications, class_name: 'Doorkeeper::Application', as: :owner

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

  def admin?
    roles.where(name: 'admin').exists?
  end

  def self.search_by_name(term)
    User.where(
      "upper(first_name) LIKE ? OR
      upper(last_name) LIKE ?",
      "%#{term.upcase}%",
      "%#{term.upcase}%"
    )
  end

  def sanitize_inputs
    # Remove any "@" symbols from the begining of the string.
    twitter.sub!(/\A@+/,"") if twitter
  end

  def change_role(new_role_name)
    new_role = Role.find_by(name: new_role_name)

    if new_role.name.in?(['graduated', 'exited', 'removed'])
      student = roles.find_by(name: 'active student')
      roles.delete(student) if student
      roles << new_role
    end

    if new_role.name == 'active student'
      applicant = roles.find_by(name: 'applicant')
      roles.delete(applicant) if applicant
      roles << new_role
    end
  end
end
