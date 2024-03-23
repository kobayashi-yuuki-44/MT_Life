class NotebooksController < ApplicationController
  
  def create
    notion_service = NotionService.new
    page_properties = {
      "Name" => {
        "title" => [
          {
            "text" => {
              "content" => "新しいページのタイトル"
            }
          }
        ]
      }
    }

    notion_response = notion_service.create_page(page_properties)

    if notion_response.code == 200 # HTTP ステータスコードが 200 (OK) の場合
      page_id = JSON.parse(notion_response.body)["id"]
      redirect_to notion_page_url(page_id), allow_other_host: true
    else
      flash[:alert] = "ノートの作成に失敗しました。エラー: #{notion_response.body}"
      redirect_to home_path # エラーが発生した場合は、適切なページにリダイレクトします。
    end
  end

  private

  def notion_page_url(page_id)
    "https://www.notion.so/#{page_id}"
  end
end
