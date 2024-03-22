class NotionService
  include HTTParty
  base_uri 'https://api.notion.com/v1'

  def initialize
    @headers = {
      "Authorization" => "Bearer #{ENV['NOTION_INTEGRATION_TOKEN']}",
      "Content-Type" => "application/json",
      "Notion-Version" => "2022-02-22"
    }
  end

  def create_page(page_properties)
    database_id = ENV['NOTION_DATABASE_ID']
    self.class.post("/pages", {
      headers: @headers,
      body: {
        parent: { database_id: database_id },
        properties: page_properties
      }.to_json
    })
  end
end