# frozen_string_literal: true

class Visit < ApplicationRecord
  has_many :checking_accounta, dependent: :nullify

  enum status: { requested: 0, done: 1 }
end
