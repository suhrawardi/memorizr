class Comment < ActiveRecord::Base

  # Setup accessible (or protected) attributes for your model
  attr_accessible :body, :user, :unit, :unit_id

  validates :body, presence: true
  validates :user, presence: true
  validates :unit, presence: true

  belongs_to :user
  belongs_to :unit

  after_create :touch_unit

protected

  def touch_unit
    unit.touch
  end
end
