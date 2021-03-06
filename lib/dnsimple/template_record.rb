module DNSimple

  # A single record in a template.
  class TemplateRecord < Base

    # The id of the template record
    attr_accessor :id

    # The template the record belongs to
    attr_accessor :template

    # The name the record points to. This may be blank.
    attr_accessor :name

    # The content for the record.
    attr_accessor :content

    # The record type
    attr_accessor :record_type

    # The time-to-live
    attr_accessor :ttl

    # The priority (only for MX records)
    attr_accessor :prio

    def delete(options={})
      DNSimple::Client.delete("templates/#{template.id}/template_records/#{id}", options)
    end
    alias :destroy :delete

    def self.create(short_name, name, record_type, content, options={})
      template = DNSimple::Template.find(short_name)

      record_hash = {:name => name, :record_type => record_type, :content => content}
      record_hash[:ttl] = options.delete(:ttl) || 3600
      record_hash[:prio] = options.delete(:prio) || ''

      options.merge!({:query => {:dns_template_record => record_hash}})

      response = DNSimple::Client.post("templates/#{template.id}/template_records", options)

      case response.code
      when 201
        new({:template => template}.merge(response["dns_template_record"]))
      else
        raise RequestError, "Error creating template record", response
      end
    end

    def self.find(short_name, id, options={})
      template = DNSimple::Template.find(short_name)
      response = DNSimple::Client.get("templates/#{template.id}/template_records/#{id}", options)

      case response.code
      when 200
        new({:template => template}.merge(response["dns_template_record"]))
      when 404
        raise RecordNotFound, "Could not find template record #{id} for template #{template.id}"
      else
        raise RequestError, "Error finding template record", response
      end
    end

    # Get all of the template records for the template with the
    # given short name.
    def self.all(short_name, options={})
      template = DNSimple::Template.find(short_name)
      response = DNSimple::Client.get("templates/#{template.id}/template_records", options)

      case response.code
      when 200
        response.map { |r| new({:template => template}.merge(r["dns_template_record"])) }
      else
        raise RequestError, "Error listing template records", response
      end
    end

  end
end
