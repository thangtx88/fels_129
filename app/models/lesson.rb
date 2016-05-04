class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  before_create :question_quantity
  has_many :results
  has_many :activities
  has_many :words, through: :results
  has_many :answers, through: :results

  accepts_nested_attributes_for :results,
    reject_if: proc {|attributes| attributes[:word_id].blank?},
    reject_if: proc {|attributes| attributes[:answer_id].blank?},
    allow_destroy: true


  def question_quantity
    if category.words.size >=5
      self.words = category.words.limit(5)
    else
      self.words = category.words
    end
  end
end
