shared_examples 'presence validator' do |attributes|
  attributes.each do |attribute|
    it { expect(subject).to validate_presence_of attribute }
  end
end
