class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable, :invitable

  # Setup accessible (or protected) attributes for your model
#  attr_accessible :name, :email, :password, :password_confirmation,
#                  :remember_me, :invitation_token

  has_many :units
  has_many :notes
  has_many :quotes
  has_many :folders, -> {order :name}

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: {minimum: 4, maximum: 32}
  validates :name, format: {with: /\A[A-Za-z0-9]+\z/}

  before_create :generate_submit_token

private

  def generate_submit_token
    self.submit_token = Digest::SHA1.hexdigest Time.now.to_s << self.email
  end
end
