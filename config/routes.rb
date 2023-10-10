# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :administrators

  authenticate :administrator do
    mount Avo::Engine, at: Avo.configuration.root_path
  end
end
