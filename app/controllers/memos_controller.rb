class MemosController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @memo = @question.memo || @question.build_memo(memo_params)
    @memo.user = current_user
    if @memo.save
      redirect_to question_path(@question), notice: 'メモを保存しました。'
    else
      redirect_to question_path(@question), alert: 'メモの保存に失敗しました。'
    end
  end
  
  def update
    @question = Question.find(params[:question_id])
    @memo = @question.memo
    if @memo.update(memo_params)
      redirect_to question_path(@question), notice: 'メモを更新しました。'
    else
      redirect_to question_path(@question), alert: 'メモの更新に失敗しました。'
    end
  end

  private

  def memo_params
    params.require(:memo).permit(:content)
  end
end