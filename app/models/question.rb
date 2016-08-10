class Question < ApplicationRecord
  validates :title, presence: true, uniqueness: {message: "must be unique"} # custom message or just use true
  validates :body , presence: true, length: {minimum: 5}



  # This validatse that the title/body combination is unique which means that
  # title doesn't have to be unique by itself, body doesn't have to be unique
  # by itself but the combination of the two must be unique.
  # validates :body, uniqueness: {scope: :title}

  # VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
# validates :email, format: VALID_EMAIL_REGEX

  validate :no_monkey

  after_initialize :set_defaults
  before_validation :capitalize_title

  def titleized_title
     title.titleize
  end

 # scope :recent_ten, lambda { order(created_at: :desc).limit(10) }
  def self.recent_ten
    order(created_at: :desc).limit(10)
  end

  def self.search(keyword)
    where(["title ILIKE ? OR body ILIKE ?", "%#{keyword}%", "%#{keyword}%"])
  end


  private

  def capitalize_title
    self.title.capitalize! if title
  end

  def no_monkey
      if title && title.downcase.include?("monkey")
        errors.add(:title, "No monkey please!")
      end
    end
  end

  def set_defaults
    self.view_count ||= 0
  end