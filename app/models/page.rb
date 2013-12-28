class Page < ActiveRecord::Base

  validates :title, :body, presence: true

  before_save :make_parameter

private

  def make_parameter
    self.parameter = self.title.parameterize
  end
end
