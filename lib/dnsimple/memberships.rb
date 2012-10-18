module DNSimple

  # Represents a single membership
  class Membership < Base
    # Membership ID in DNSimple
    attr_accessor :id

    # User ID in DNSimple
    attr_accessor :user_id

    # The domain ID in DNSimple
    attr_accessor :domain_id

    # User permissions
    attr_accessor :permission

    # When the domain was created in DNSimple
    attr_accessor :created_at

    # When the domain was last update in DNSimple
    attr_accessor :updated_at

    # List memberships for domain
    def self.list_membership(name, options={})
      response = DNSimple::Client.get("domains/#{name}/memberships", options)

      case response.code
      when 200    
          response.map { |r| new(r["membership"]) }
      else
        raise RequestError, "Error listing memberships", response
      end      
    end

  end
end
