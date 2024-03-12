class MemosController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @memo = @question.memos.build(memo_params)
    @memo.user = current_user
    if @memo.save
      redirect_to question_path(@question), notice: 'メモを保存しました。'
    else
      redirect_to question_path(@question), alert: 'メモの保存に失敗しました。'
    end
  end

  def update
  end

  private

  def memo_params
    params.require(:memo).permit(:content)
  end
end