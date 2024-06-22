class QuestionsController < ApplicationController
  def index
  end

  def show
    @question = Question.includes(:options).find(params[:id])
    @image_questions = ImageQuestion.where(question_id: @question.id)
    @answer = Answer.new
    @memo = Memo.where(user_id: current_user.id, question_id: @question.id).first
    @is_random_question = session[:last_random_question_id] == @question.id
    
    if params[:retain_selection] == "true"
      @selected_option_ids = session[:selected_option_ids] || []
    else
      session.delete(:selected_option_ids)
      @selected_option_ids = []
    end

    questions_list = session[:questions_list] || []
    current_index = questions_list.find_index(@question.id)
  
    if current_index && current_index + 1 < questions_list.size
      @next_question_id = questions_list[current_index + 1]
    else
      @next_question_id = nil
    end

    session[:last_random_question_id] = @question.id if params[:from] == 'random'
  end

  def subject
    @subjects = SUBJECTS
  end

  def show_subject
    @subject = params[:subject]
    unless SUBJECTS.include?(@subject)
      redirect_to(root_path, alert: '無効な分野が指定されました。') and return
    end
    @questions = Question.where(subject: @subject).order(year: :desc, id: :asc)
    session[:questions_list] = @questions.map(&:id)
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
    flash[is_correct ? :notice : :alert] = is_correct ? "正解です！" : "不正解です。"
    session[:selected_option_ids] = selected_option_ids
    
    redirect_params = { retain_selection: "true" }
    redirect_params[:from] = 'random' if session[:last_random_question_id] == @question.id
    redirect_to question_path(@question, redirect_params)
  end

  def year
    @years = YEARS
  end

  def show_year
    @year = params[:year]
    unless YEARS.include?(@year)
      redirect_to(root_path, alert: '無効な分野が指定されました。') and return
    end
    @questions = Question.where(year: @year).order(:id)
    session[:questions_list] = @questions.map(&:id)
  end

  def random
    @question = Question.order(Arel.sql('RANDOM()')).first
    session[:last_random_question_id] = @question.id
    @image_questions = ImageQuestion.where(question_id: @question.id)
  end

  def next_random
    session[:last_random_question_id] = nil
    session.delete(:selected_option_ids) 
    redirect_to action: :random
  end
end
