class QuestionsController < ApplicationController
  def index
  end

  def show
    @question = Question.includes(:options).find(params[:id])
    @image_questions = ImageQuestion.where(question_id: @question.id)
    @answer = Answer.new
    @memo = @question.memo
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

  def answer
    @question = Question.find(params[:id])
    selected_option_ids = params[:answer].try(:[], :selected_option_ids) || []
    selected_options = selected_option_ids.map(&:to_i)
    
    if selected_options.empty?
      flash[:alert] = "選択肢を選んでください。"
      redirect_to question_path(@question) and return
    end

    is_correct = @question.correct_answer?(selected_options)
    if is_correct
      flash[:notice] = "正解です！"
    else
      flash[:alert] = "不正解です。"
    end
    redirect_to question_path(@question)
  end

  def year
    @years = YEARS
  end

  def show_year
    @year = params[:year]
    unless YEARS.include?(@year)
      redirect_to(root_path, alert: '無効な分野が指定されました。') and return
    end
    @questions = Question.where(year: @year)
  end

  def random
    if session[:last_random_question_id]
      @question = Question.find(session[:last_random_question_id])
    else
      @question = Question.order(Arel.sql('RANDOM()')).first
      session[:last_random_question_id] = @question.id
    end
    @image_questions = ImageQuestion.where(question_id: @question.id)
  end

  def next_random
    session[:last_random_question_id] = nil
    redirect_to action: :random
  end
end
