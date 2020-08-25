# frozen_string_literal: true

class Token < ApplicationRecord
  belongs_to :auth_user

  validates :name, presence: true
  validates :token, presence: true

  scope :active, -> { where('deleted = false') }

  scope :deleted, -> { where('deleted = true') }

  def make_token
    self.token = JsonToken.encode({ user_id: user_id })
    self
  end

  def to_s
    name
  end
end
