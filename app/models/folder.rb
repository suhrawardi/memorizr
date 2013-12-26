class Folder < ActiveRecord::Base

  validates :user, presence: true
  validates :name, presence: true

  belongs_to :user
  has_many :units, -> {order 'updated_at DESC'}

  def mine?(a_user)
    a_user == user
  end
end
