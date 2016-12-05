class User < ActiveRecord::Base
  has_and_belongs_to_many :groups
  has_many :decks
  
    def self.create_user!(parameters)
        hash = parameters["user"]
        hash[:session_token] =SecureRandom.base64
        
        if User.exists?(:email => parameters["user"]["email"])
             
            return "user exists"
        elsif
            user = create!(parameters.require(:user).permit(:email, :password, :session_token))
        
            return user.email
        end
    end
    
    def is_in_group(group_id)
        self.groups.map { |g| g.id }.include? group_id
    end
  
end
