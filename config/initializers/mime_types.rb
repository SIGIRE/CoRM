# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register_alias "text/html", :iphone
if Mime::Type.lookup('pdf').nil?
  Mime::Type.register "application/pdf", :pdf
end
