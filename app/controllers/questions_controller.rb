class QuestionsController < ApplicationController
  def index
  end

  def show
    @question = Question.includes(:options).find(params[:id])
    @answer = Answer.new
  end

  def subject
    @subjects = SUBJECTS
  end

  def show_subject
    @subject = params[:subject]
    unless SUBJECTS.include?(@subject)
      redirect_to(root_path, alert: '無効な分野が指定されました。') and return
    end
    @questions = Question.where(subject: @subject)
  end

  def year
  end

  def random
  end
end
