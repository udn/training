class Comment < ActiveRecord::Base
  belongs_to :article

  scope :latest_comments, -> { order(created_at: :desc).limit(5) }
end
