class Word < ActiveRecord::Base

  belongs_to :category
  has_many :results
  has_many :answers, dependent: :destroy
  has_many :lessons, through: :results

  validates :content, presence: true

  accepts_nested_attributes_for :answers,
    reject_if: proc {|attributes| attributes[:content].blank?},
    allow_destroy: true

  private
  def only_one_correct_answer
    errors.add :many_answer, I18n.t("models.word.many_answer") unless
      answers.select{|answer| answer.is_correct}.size == 1
  end
end
