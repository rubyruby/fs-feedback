require "rails_helper"

RSpec.describe Admin::FeedbacksController, type: :controller do

  describe "GET #index" do

    before(:each) { 10.times.map { create(:feedback) } }

    context "when user is authorized" do
      before(:each) { sign_in(create(:user, :admin)) }

      it do
        get :index
        expect(response).to have_http_status(:ok)
      end
    end

    context "when user is non-authorized" do
      before(:each) { sign_in(create(:user)) }

      it do
        get :index
        is_expected.to redirect_to(root_path)
      end
    end

    context "when user is visitor" do
      it do
        get :index
        is_expected.to redirect_to(root_path)
      end
    end
  end

end