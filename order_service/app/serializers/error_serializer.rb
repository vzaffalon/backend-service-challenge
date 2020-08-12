module ErrorSerializer

    @error_codes = %w(missing missing_field invalid already_exists)
  
    # Error codes and their descriptions:
    #
    # missing: This means a resource does not exist.
    #
    # missing_field: This means a required field on a resource has not been set.
    #
    # invalid: This means the formatting of a field is invalid. The documentation for that resource should be able to
    # give you more specific information.
    #
    # already_exists: This means another resource has the same value as this field. This can happen in resources that
    # must have some unique key (such as Label names).
  
    def ErrorSerializer.serialize(resource, message='Validation Failed')
      errors = resource.errors
      return if errors.nil?
  
      json = {message: message}
  
      new_hash = errors.to_hash(true).map do |field, messages|
        messages.map do |msg|
            if @error_codes.include?(msg)
              {resource: resource.class.to_s, field: field, code: msg}
            else
              {resource: resource.class.to_s, field: field, code: 'custom', message: msg, documentation_url: ''}
            end
          # end
  
        end
      end.flatten
  
      json[:errors] = new_hash
      json
    end
  
end