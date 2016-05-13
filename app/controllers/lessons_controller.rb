class LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :load_lesson, only: [:update, :show]


  def create
    lesson = current_user.lessons.build category_id: params[:category_id]
    lesson.save
    redirect_to lesson
  end

  def update
    begin
      Lesson.transaction do
        params[:lesson][:result] = true
        @lesson.update_attributes lesson_params
      end
    rescue Exception => e
      ActiveRecord::Rollback
    end
    redirect_to :back
  end

  def show
    if @lesson.result.nil?
      @words = @lesson.category.words.shuffle
    else
      @words = @lesson.words
      @is_correct_answers = Answer.send :is_correct_answers, @lesson.id
      UserResultMailer.delay(run_at: 8.hours.from_now).send_result(@lesson.user_id)
    end
  end

  private
  def lesson_params
    params.require(:lesson).permit :user_id, :category_id, :result,
      results_attributes: [:id, :word_id, :answer_id]
  end

  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
  end
end
