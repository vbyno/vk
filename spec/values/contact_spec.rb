require 'spec_helper'

describe Contact do
  describe 'initialize' do
    let(:contact) { Contact.instance }

    it 'saves phones' do
      expect(contact.phones.length).to eq 2
      expect(contact.phones).to eq [phone(:kyivstar), phone(:life)]
    end
  end

private
  def phones_hash
    SiteInfo.fetch(:contact)[:phones]
  end

  def phone(operator)
    Phone.new(phones_hash[operator.to_sym][:human_number])
  end
end

