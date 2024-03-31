class WordbooksController < ApplicationController
  before_action :set_wordbook, only: [:show, :edit, :update, :destroy, :card]

  def index
    @wordbooks = Wordbook.all.order(created_at: :asc)
  end

  def new
    @wordbook = Wordbook.new
  end

  def create
    @wordbook = current_user.wordbooks.build(wordbook_params)
    if @wordbook.save
      redirect_to wordbooks_path, notice: '単語帳が作成されました。'
    else
      flash.now[:alert] = '単語帳にタイトルをつけましょう'
      render :new
    end
  end

  def edit
  end

  def update
    if @wordbook.update(wordbook_params)
      redirect_to wordbooks_path, notice: '単語帳が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @wordbook.destroy
    redirect_to wordbooks_path, notice: '単語帳が削除されました。'
  end

  def card
    @words = @wordbook.words
  end

  private

  def set_wordbook
    @wordbook = Wordbook.find_by(id: params[:id])
    if @wordbook.nil?
      redirect_to wordbooks_path, alert: '指定された単語帳が見つかりません。'
    end
  end

  def wordbook_params
    params.require(:wordbook).permit(:collection)
  end
end
