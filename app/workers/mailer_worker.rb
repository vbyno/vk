class MailerWorker
  @queue = :mailer

  def self.perform(class_name, method, *args)
    approved_classes = %w[AdminMailer UserMailer]

    if class_name.in? approved_classes
      class_name.constantize.public_send(method, *args).deliver
    else
      Rails.logger.error("Unauthorized class (#{class_name}) was queued up to perform a method.")
    end
  end
end
