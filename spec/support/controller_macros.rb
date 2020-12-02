# frozen_string_literal: false

module ControllerMacros
  def login_admin
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in(FactoryBot.create(:admin)) # Using factory bot as an example
    end
  end

  def login_user
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      # user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in(user)
    end
  end

  def complete_account
    account = create(:account)
    account.save()
    movement1 = create(:movement)
    movement1.account = account
    movement1.amount = -20
    movement1.save()
    movement2 = create(:movement)
    movement2.account = account
    movement2.save()
    [account, movement1, movement2]
  end
end
