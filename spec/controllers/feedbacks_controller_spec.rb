require "rails_helper"

RSpec.describe FeedbacksController, type: :controller do

  describe "GET #new" do

    it do
      get :new
      expect(response).to have_http_status(:ok)
    end

  end

  describe "POST #create" do

    let(:action) { -> { post :create, params: { feedback: feedback_attributes } } }

    context "with valid attributes" do
      let(:feedback_attributes) { attributes_for(:feedback) }

      it do
        action.call
        expect(response).to redirect_to(root_path)
      end

      it "creates feedback in db" do
        expect { action.call }.to change(Feedback, :count).by(1)
      end
    end

    context "with invalid attributes" do
      let(:feedback_attributes) { attributes_for(:feedback, :invalid) }

      it do
        action.call
        expect(response).to have_http_status(:ok)
      end

      it("does not create feedback in db") {
        expect { action.call }.not_to change(Feedback, :count)
      }
    end

  end

end