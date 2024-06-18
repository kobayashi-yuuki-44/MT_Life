class SavePageContentJob < ApplicationJob
  queue_as :default

  def perform(page_id, content)
    page = Page.find(page_id)
    page.update!(page_content: content)
  end
end