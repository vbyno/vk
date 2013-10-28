module ControllerMacros
  def login_user
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = create(:user)
      user.stub(:admin?).and_return true
      sign_in user
      @ability = Ability.new(user)
      controller.stub(:current_ability) { @ability }
    end
  end
end