class WordsController < ApplicationController
  before_action :set_wordbook
  before_action :set_word, only: [:show, :edit, :update]

  def index
    @wordbook = Wordbook.find(params[:wordbook_id])
    @words = @wordbook.words
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

  private

  def set_wordbook
    @wordbook = Wordbook.find(params[:wordbook_id])
  end

  def set_word
    @word = @wordbook.words.find(params[:id])
  end

  def word_params
    params.require(:word).permit(:term, :definition)
  end
end
