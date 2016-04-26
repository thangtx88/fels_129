class Answer < ActiveRecord::Base
  belongs_to :word
  has_many :results
  has_many :lessons
end
