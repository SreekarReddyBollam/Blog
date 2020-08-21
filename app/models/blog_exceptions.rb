# frozen_string_literal: true

module BlogExceptions
  class BlogAccessErrors < RuntimeError
    attr_reader :message, :status_code

    def initialize(message, status_code)
      @message = message
      @status_code = status_code
    end
  end

  class AuthenticationError < BlogAccessErrors
    def initialize
      super('User is not logged in invalid username or password', 401)
    end
  end

  class BadRequestError < BlogAccessErrors
    def initialize
      super('cannot perform this action check details', 400)
    end
  end

  class UnAuthorizedError < BlogAccessErrors
    def initialize
      super('user not allowed to perform this action', 401)
    end
  end

  class PageNotFoundError < BlogAccessErrors
    def initialize
      super('Page not found', 404)
    end
  end
end
