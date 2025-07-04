class BlogPost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_one_attached :video

  validates :title, presence: true
  validates :description, presence: true

	scope :draft, -> {where(published_at: nil)}
	scope :published, -> { where("published_at <= ?", Time.current ) }
	scope :scheduled, -> { where("published_at > ?", Time.current ) }

	def draft?
		published_at.nil?
	end

	def published?
		published_at? && published_at <= Time.current
	end

  def schedule?
    published_at? && published_at > Time.current
  end

  def likes_count
    votes.where(value: 1).count
  end

  def dislikes_count
    votes.where(value: -1).count
  end
end
