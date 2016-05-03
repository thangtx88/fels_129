class Word < ActiveRecord::Base
  belongs_to :category
  has_many :results
  has_many :answers, dependent: :destroy
  has_many :lessons, through: :results

  validates :content, presence: true

  accepts_nested_attributes_for :answers,
    reject_if: proc {|attributes| attributes[:content].blank?},
    allow_destroy: true

end
