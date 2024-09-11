require 'rails_helper'

RSpec.describe "Users", type: :request do
  before(:all) do
    create_list(:user, 8)
  end

  describe "GET /users" do
    it "shows all users" do
      get '/api/users'
      expect(response_json["users"].length).to eq User.count
      expect(response_json["total_pages"]).to eq 1 
      expect(response.status).to eq 200
    end
  end

  describe "POST /users" do
    context "completed data with address" do
      it "creates a new user" do
        post '/api/users', params: {
          user: {
            name: "Santiago",
            last_name: "Mendoza",
            email: "santi@mail.com",
            phone: "498999",
            gender: "male",
            address: "Str 45. 2100"
          }
        }
        expect(response.body).to include "Usuario creado con éxito !"
        expect(User.last.email).to include "santi@mail.com"
        expect(User.count).to eq 9
        expect(response.status).to eq 201
      end
    end

    context "completed data without address" do
      it "creates a new user" do
        post '/api/users', params: {
          user: {
            name: "Laura",
            last_name: "Ospina",
            email: "laura@mail.com",
            phone: "598999",
            gender: "female"
          }
        }
        expect(response.body).to include "Usuario creado con éxito !"
        expect(User.last.email).to include "laura@mail.com"
        expect(User.count).to eq 10
        expect(response.status).to eq 201
      end
    end

    context "empty fields" do
      it "does not create the user and returns error" do
        post '/api/users', params: {
          user: {
            name: "",
            last_name: "",
            email: "",
            phone: "",
            gender: ""
          }
        }
        expect(response_json["name"]).to include "can't be blank"
        expect(response_json["last_name"]).to include "can't be blank"
        expect(response_json["email"]).to include "can't be blank"
        expect(response_json["phone"]).to include "can't be blank"
        expect(response_json["gender"]).to include "can't be blank"
        expect(User.count).to eq 10
        expect(response.status).to eq 422
      end
    end

    context "existing email" do
      it "does not create the user and returns error" do
        post '/api/users', params: {
          user: {
            name: "Santiago",
            last_name: "Rodriguez",
            email: "santi@mail.com",
            phone: "567889",
            gender: "male"
          }
        }
        expect(response_json["email"]).to include "has already been taken"
        expect(response.status).to eq 422
        expect(User.count).to eq 10
      end
    end
  end

  describe "PUT /users" do
    context "completed data with address" do
      it "updates user" do
        existing_user = User.find_by email: "santi@mail.com"

        put "/api/users/#{existing_user.id}", params: {
          user: {
            name: "Santiago",
            last_name: "Mendoza Ruiz",
            email: "santi12@mail.com",
            phone: "990990",
            gender: "male",
            address: "Str 45. 2100"
          }
        }
        expect(response.body).to include "Usuario editado con éxito !"
        expect(User.find(existing_user.id).last_name).to eq "Mendoza Ruiz"
        expect(User.find(existing_user.id).email).to include "santi12@mail.com"
        expect(response.status).to eq 200
        expect(User.count).to eq 10
      end
    end

    context "only editing email and phone" do
      it "updates user" do
        existing_user = User.find_by email: "laura@mail.com"

        put "/api/users/#{existing_user.id}", params: {
          user: {
            email: "laura12@mail.com",
            phone: "898990",
          }
        }
        expect(response.body).to include "Usuario editado con éxito !"
        expect(User.find(existing_user.id).email).to include "laura12@mail.com"
        expect(User.find(existing_user.id).phone).to include "898990"
        expect(User.count).to eq 10
        expect(response.status).to eq 200
      end
    end

    context "empty fields" do
      it "does not update the user and returns error" do
        put "/api/users/#{User.last.id}", params: {
          user: {
            email: "",
            phone: "",
          }
        }
        expect(response_json["email"]).to include "can't be blank"
        expect(response_json["phone"]).to include "can't be blank"
        expect(User.count).to eq 10
        expect(response.status).to eq 422
      end
    end

    context "existing email" do
      it "does not create the user and returns error" do
        put "/api/users/#{User.last.id}", params: {
          user: {
            email: "santi12@mail.com"
          }
        }
        expect(response_json["email"]).to include "has already been taken"
        expect(response.status).to eq 422
        expect(User.count).to eq 10
      end
    end
  end

  describe "DELETE /users/:id" do
    context "existing user" do
      it "deletes user" do
        last_user_id = User.last.id
        delete "/api/users/#{last_user_id}"
        expect(response.body).to include "Usario eliminado con éxito !"
        expect(User.count).to eq 9
        expect(response.status).to eq 200
      end
    end

    context "not existing user" do
      it "does not delete user" do
        delete "/api/users/400"
        expect(response.body).to include "No pudo ser encontrado usuario con ID -> 400"
        expect(User.count).to eq 9
        expect(response.status).to eq 404
      end
    end
  end
end
