class PagesController < ApplicationController
  before_action :set_notebook, only: [:create, :save_content]

  def new
    @page = @notebook.pages.new
  end

  def create
    page = @notebook.pages.find_by(page_number: page_params[:page_number])

    if page.present?
      render json: { id: page.id, notebook_id: @notebook.id, page_number: page.page_number }, status: :ok
    else
      last_page_number = @notebook.pages.maximum(:page_number) || 0
      return render json: { error: 'ページの上限に達しました。' }, status: :forbidden if last_page_number >= 10

      @page = @notebook.pages.new(page_params)

      if @page.save
        render json: { id: @page.id, notebook_id: @notebook.id, page_number: @page.page_number }, status: :created
      else
        render json: @page.errors, status: :unprocessable_entity
      end
    end
  end

  def show
    @notebook = current_user.notebooks.find(params[:notebook_id])
    @page = @notebook.pages.find_by(page_number: params[:page_number])

    unless @page
      flash[:alert] = "ページが見つかりません。"
      respond_to do |format|
        format.html { redirect_to notebook_path(@notebook) }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "page_content",
            partial: "path/to/an_error_partial",
            locals: { notebook: @notebook }
          )
        end
      end
    end
  end

  def save_content
    @page = @notebook.pages.find_by(id: params[:id])
    if @page && @page.update(page_content: params[:page][:content])
      render json: { status: 'success' }, status: :ok
    else
      render json: { errors: @page.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_notebook
    @notebook = current_user.notebooks.find(params[:notebook_id])
  end

  def page_params
    params.require(:page).permit(:page_content, :page_number)
  end
end