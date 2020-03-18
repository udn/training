class Article < ActiveRecord::Base
  searchkick

  scope :sort_by_created_at, -> { order(id: :asc) }

  has_many :comments, dependent: :destroy
  belongs_to :category

  def search_data
    {
      title: title,
      description: description,
      comments_count: self.comments.size,
      latest_comments: self.comments.latest_comments.map(&:comment)
    }
  end
end
