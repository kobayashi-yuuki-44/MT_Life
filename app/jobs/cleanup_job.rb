class CleanupJob < ApplicationJob
  queue_as :default

  def perform
    system('bash script/cleanup.sh')
  end
end