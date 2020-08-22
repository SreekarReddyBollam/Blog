# frozen_string_literal: true

module BlogExceptions
  class AuthenticationError < StandardError
    def initialize(msg = 'User is not logged in invalid username or password')
      super
    end
  end

  class BadRequestError < StandardError
    def initialize(msg = 'Cannot perform this action check details')
      super
    end
  end

  class UnAuthorizedError < StandardError
    def initialize(msg = 'User not allowed to perform this action')
      super
    end
  end

  class PageNotFoundError < StandardError
    def initialize(msg = 'Page not found')
      super
    end
  end
end
