class Note < Unit

  # Setup accessible (or protected) attributes for your model
  attr_accessible :body, :user

  validates :body, :presence => true

end
