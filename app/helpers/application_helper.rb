module ApplicationHelper
  def locale_link_to(text = nil, suffix: nil, identifiers: [], **html_options)
    identifiers = Array(identifiers)
    path = if @locale.default?
             public_send "#{suffix}_path", *identifiers
           else
             public_send "locale_#{suffix}_path",
                           *([@locale.to_s] + identifiers)
           end
    link_to(text, path, html_options)
  end
end
