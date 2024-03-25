class WordsController < ApplicationController
  before_action :set_wordbook
  before_action :set_word, only: [:show, :edit, :update, :destroy]


  def index
    @wordbook = Wordbook.find(params[:wordbook_id])
    @words = @wordbook.words.order(created_at: :asc)
  end

  def new
    @wordbook = Wordbook.find(params[:wordbook_id])
    @word = @wordbook.words.build
  end

  def create
    @wordbook = Wordbook.find(params[:wordbook_id])
    @word = @wordbook.words.new(word_params)
    if @word.save
      redirect_to wordbook_words_path(@wordbook), notice: '単語が保存されました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @word.update(word_params)
      redirect_to wordbook_words_path(@wordbook), notice: '単語が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @word = @wordbook.words.find(params[:id])
    @word.destroy
    redirect_to wordbook_words_path(@wordbook), notice: '単語が削除されました。'
  end

  private

  def set_wordbook
    @wordbook = Wordbook.find(params[:wordbook_id])
  end

  def set_word
    @word = @wordbook.words.find_by(id: params[:id])
    if @word.nil?
      redirect_to wordbook_words_path(@wordbook), alert: '指定された単語が見つかりません。'
    end
  end

  def word_params
    params.require(:word).permit(:term, :definition)
  end

end
