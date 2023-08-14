module Ok2explore
  module Errors
    class TooManyResults < RuntimeError; end
    class NoResults < RuntimeError; end
    class OutsideRange < RuntimeError; end
    class InvalidParams < StandardError; end
  end
end
