module Exceptions
  class UserInputError < StandardError; end
  class UserNotAuthorized < StandardError; end
  class UserFileUploadError < StandardError; end
  
  class Duplicate < StandardError; end
end 
