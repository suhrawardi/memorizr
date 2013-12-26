class Comment < ActiveRecord::Base

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
