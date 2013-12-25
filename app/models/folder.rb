class Folder < ActiveRecord::Base

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :description, :user

  validates :user, presence: true
  validates :name, presence: true

  belongs_to :user
  has_many :units, -> {order 'updated_at DESC'}

  def is_mine?(a_user)
    a_user == user
  end
end
