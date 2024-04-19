class MemosController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @memo = @question.memos.where(user: current_user).first_or_initialize
    @memo.assign_attributes(memo_params)
    @memo.user = current_user

    if @memo.save
      flash[:notice] = "メモを保存しました。"
      setup_session_for_next_question(@question)
      redirect_to question_path(@question, next_question_id: calculate_next_question_id(@question))
    else
      flash.now[:alert] = "メモの保存に失敗しました。"
      render 'questions/show', status: :unprocessable_entity
    end
  end
  
  def update
    @question = Question.find(params[:question_id])
    @memo = @question.memo
    
    if @memo.update(memo_params)
      render json: { status: 'success', content: @memo.content }
    else
      render json: { status: 'error', message: @memo.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end  

  private

  def memo_params
    params.require(:memo).permit(:content).tap do |whitelisted|
      whitelisted[:content] = sanitize_content(whitelisted[:content])
    end
  end

  def sanitize_content(content)
    content.gsub(/\s+/, ' ').strip
  end

  def calculate_next_question_id(current_question)
    questions_list = session[:questions_list] || []
    current_index = questions_list.find_index(current_question.id)
    if current_index && current_index + 1 < questions_list.size
      questions_list[current_index + 1]
    end
  end

  def setup_session_for_next_question(current_question)
    # ここで`questions_list`を適切に設定するロジックを追加します。
    # 例えば、次のように設定できます:
    session[:questions_list] ||= Question.pluck(:id) # これは一例です
  end
end