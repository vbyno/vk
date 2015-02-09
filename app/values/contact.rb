class Contact
  include Singleton

  attr_reader :phones, :email

  def initialize
    @phones = PhonesFactory.build(contact_hash[:phones])
    @email = contact_hash[:email]
  end

private
  def contact_hash
    @contact_hash ||= SiteInfo.fetch(:contact)
  end
end
