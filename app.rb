require 'grape'
require 'grape-entity'
require 'active_record'

module App

  module Model
    class User < ActiveRecord::Base

    end
    class Client < ActiveRecord::Base

    end
  end

  module View
    class User < Grape::Entity
      expose :os
      expose :token
    end
  end

  class API < Grape::API
    version 'v1', using: :path
    format :json

    http_digest({ realm: 'App', opaque: '41689dd0d1dbbf3e7a5d514c0b044493' }) do |username|
      Model::Client.find_by_client_name(username).key
    end

    resource :users do

      get do
        users = Model::User.all
        present users, :with => View::User
      end

      params do
        requires :udid, type: String
        requires :os, type: String
        requires :token, type: String
      end
      post do
        user = Model::User.find_by(udid: params[:udid].to_s)
        if user.nil?
          user = Model::User.new(udid: params[:udid], os: params[:os], token: params[:token])
          user.save
        else
          error!('422 Unprocessable Entity', 422)
        end
      end

    end
  end

end
