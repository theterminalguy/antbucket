module Message
  class Success
    def logout
      'Logout successfully'
    end

    def empty
      'Collection is empty'
    end

    def deleted
      "Deleted successfully'"
    end
  end

  class Error
    def login
      'Invalid user name or password!'
    end

    def invalid
      ['is invalid']
    end

    def password
      ['is too short (minimum is 7 characters)']
    end

    def blank
      ["can't be blank"]
    end

    def not_found(model, id)
      "Couldn't find #{model} with 'id'=#{id}"
    end

    def denial
      "'Unauthorized access'"
    end
  end
end
