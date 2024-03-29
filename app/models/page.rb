class Page < ApplicationRecord
  before_save :sanitize_content
  
  belongs_to :notebook

  validates :page_number, presence: true

  def next_page
    notebook.pages.where("page_number > ?", page_number).order(:page_number).first
  end

  private
  
  def sanitize_content
    self.page_content = ActionController::Base.helpers.sanitize(self.page_content)
  end
end
