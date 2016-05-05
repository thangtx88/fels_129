class Word < ActiveRecord::Base

  belongs_to :category
  has_many :results
  has_many :answers, dependent: :destroy
  has_many :lessons, through: :results

  validates :content, presence: true
  validate :only_one_correct_answer

  accepts_nested_attributes_for :answers,
    reject_if: proc {|attributes| attributes[:content].blank?},
    allow_destroy: true

  filter_byword_learned = "id in (select results.word_id from lessons
    join results on lessons.id = results.lesson_id
    where lessons.user_id = ? and lessons.category_id
    in (?) and results.word_id is not null)"

  filter_byword_unlearned = "id not in (select results.word_id from lessons
    join results on lessons.id = results.lesson_id
    where lessons.user_id = ? and results.word_id is not null)
    and category_id in (?)"

  filter_by_word_all = "id in (select id from words
    where words.category_id in (?))"

  scope :by_learned,-> (user_id, category_id) do
    where filter_byword_learned,user_id, category_id
  end

  scope :by_unlearned, ->(user_id, category_id) do
    where filter_byword_unlearned, user_id, category_id
  end

  scope :by_all, ->(user_id, category_id) do
    where filter_by_word_all, category_id
  end
  private
  def only_one_correct_answer
    errors.add :many_answer, I18n.t("models.word.many_answer") unless
      answers.select{|answer| answer.is_correct}.size == 1
  end
end

