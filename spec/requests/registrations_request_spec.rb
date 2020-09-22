require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  let!(:user) {FactoryBot.create :user, role: :trainer}
  before {login user}

  describe "GET #edit" do
    it "should show edit template" do
      get :edit
      expect(response).to render_template :edit
    end
  end

  describe "PUT #update" do
    context "when valid params" do
      it "should change success password" do
        put :update, params: {user: {password: "1234567", password_confirmation: "1234567", current_password: "123456"}}
        user.reload
        expect(user.valid_password? "1234567").to eq true
      end
    end

    context "when invalid params" do
      it "should change success password" do
        put :update, params: {user: {password: "1", password_confirmation: "1234", current_password: "123456"}}
        user.reload
        expect(subject.current_user.valid_password? "1").to eq false
      end
    end
  end
end
