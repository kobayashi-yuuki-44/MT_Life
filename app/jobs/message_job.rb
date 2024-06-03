class MessageJob < ApplicationJob
  queue_as :default

  def perform
    message = "学習の成果が出るまで時間がかかりますよね🌱\n成長を実感できるまでは特にモチベーションの維持が大変ですが、今まで行った学習は必ず力になっています😊✨\n誘惑に負けずに今日も一緒に頑張りましょう🔥🔥🔥"
    authentications = Authentication.where(provider: 'line')

    authentications.each do |auth|
        LineMessagingService.new.push_message(auth.uid, message)
    end
  end
end