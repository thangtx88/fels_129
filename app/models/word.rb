class Word < ActiveRecord::Base
  belongs_to :category
  has_many :results
  has_many :answers, dependent: :destroy
  has_many :lessons, dependent: :destroy
  validates :content, presence: true
end
