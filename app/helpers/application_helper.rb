module ApplicationHelper
  def locale_link_to(text = nil, path, identifiers: [], **html_options, &block)
    identifiers = Array(identifiers)
    path = if @locale.default?
             public_send path, *identifiers
           else
             public_send "locale_#{path}", *([@locale.to_s] + identifiers)
           end
    link_to_unless_current(text, path, html_options, &block)
  end
end
