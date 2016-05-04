class Answer < ActiveRecord::Base

  querry = "id in (select results.answer_id
    from lessons join results on lessons.id = results.lesson_id
    where lessons.id = ?) and is_correct = '1'"

  belongs_to :word
  has_many :results
  has_many :lessons, through: :results

  validates :content, presence: true

  scope :is_correct_answers, ->lesson_id{where querry, lesson_id}
end
