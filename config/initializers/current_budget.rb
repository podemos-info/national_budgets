# frozen_string_literal: true

Rails.application.config.middleware.insert_before Warden::Manager, CurrentBudget
