module ApplicationHelper
  def locale_link_to(text = nil, path, identifiers: [], locale: @locale,
                     **html_options, &block)
    identifiers = Array(identifiers)
    path = if locale.default?
             public_send path, *identifiers
           else
             public_send "locale_#{path}", *([locale.to_s] + identifiers)
           end
    link_to_unless_current(text, path, html_options, &block)
  end

  def human_attribute(resource, attribute)
    (resource.is_a?(Class) ? resource : resource.class).
      human_attribute_name(attribute)
  end

  def human_attributes(resource, *attributes, &block)
    if block_given?
      attributes.each { |attr| yield human_attribute(resource, attr) }
    else
      attributes.map { |attr| human_attribute(resource, attr) }
    end
  end

  def new_admin_picture_url_params(resource)
    return {} if resource.new_record?
    # TODO: put it to basic model
    resource_type = if resource.respond_to?(:param_key)
                      resource.param_key.to_s.camelize
                    else
                      resource.class.to_s
                    end
    {
      :'new-admin-picture-url' =>
        new_admin_picture_url(imageable_id: resource.id,
                              imageable_type: resource_type)
    }
  end
end
