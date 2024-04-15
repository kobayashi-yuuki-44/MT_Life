class MemosController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @memo = @question.memos.where(user: current_user).first_or_initialize
    @memo.assign_attributes(memo_params)
    @memo.user = current_user

    if @memo.save
      flash[:notice] = "メモを保存しました。"
      redirect_to question_path(@question)
    else
      flash[:alert] = "メモの保存に失敗しました。"
      redirect_to question_path(@question)
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
end