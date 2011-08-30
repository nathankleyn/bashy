module Bashy
  class CommandNotPassedError < StandardError; end
  class CommandNotFoundError < StandardError; end
  
  class CommandAlreadyExists < StandardError; end
  class GistCouldNotBeCloned < StandardError; end
  
  class InvalidGistResponseError < StandardError; end
end
