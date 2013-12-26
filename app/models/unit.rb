class Unit < ActiveRecord::Base

  mount_uploader :attachment, AttachmentUploader

  validates :user, presence: true

  has_many :comments
  belongs_to :user
  belongs_to :folder

  default_scope -> {order 'updated_at DESC'}

  def is_editable?(a_user)
    is_mine?(a_user)
  end

  def is_mine?(a_user)
    user == a_user
  end
end
