module Message 
  class Success 
    def logout 
      %q(Logout successfully)
    end  

    def empty 
      %q(Collection is empty)
    end 

    def deleted 
      %q(Deleted successfully')
    end 
  end 

  class Error 
    def login 
      %q(Invalid user name or password!)
    end 

    def invalid 
      ["is invalid"]
    end 

    def password 
      ["is too short (minimum is 7 characters)"]
    end 

    def blank 
      ["can't be blank"]
    end 

    def not_found(model, id)
      "Couldn't find #{model} with 'id'=#{id}"
    end

    def denial 
      %q('Unauthorized access')
    end 
  end 
end 
