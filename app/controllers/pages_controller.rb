class PagesController < ApplicationController
  before_action :set_notebook, only: [:new, :create, :show, :save_content, :upload_image]

  def new
    @page = @notebook.pages.new
  end

  def create
    @page = @notebook.pages.new(page_params)
    if @page.save
      redirect_to notebook_path(@notebook), notice: 'ページが作成されました。'
    else
      render :new
    end
  end

  def show
    @page = @notebook.pages.first
  end

  def save_content
    @page = @notebook.pages.first
    if @page.update(page_content: params[:page][:content])
      render json: { status: 'success' }, status: :ok
    else
      render json: { errors: @page.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def upload_image
    @page = @notebook.pages.find(params[:page_id])
    if @page.images.attach(params[:image])
      render json: { url: url_for(@page.images.last) }, status: :ok
    else
      render json: { error: '画像のアップロードに失敗しました。' }, status: :unprocessable_entity
    end
  end

  private

  def set_notebook
    @notebook = current_user.notebooks.find(params[:notebook_id])
  end

  def page_params
    params.require(:page).permit(:page_content)
  end
end