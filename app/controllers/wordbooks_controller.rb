class WordbooksController < ApplicationController
  before_action :set_wordbook, only: [:show, :edit, :update, :exercise]

  def index
    @wordbooks = Wordbook.all
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
      redirect_to @wordbook, notice: '単語帳が更新されました。'
    else
      render :edit
    end
  end

  def show
    @wordbook = Wordbook.find(params[:id])
    @words = @wordbook.words
  end

  def exercise
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
