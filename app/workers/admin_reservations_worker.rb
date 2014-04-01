class AdminReservationsWorker
  @queue = :notifiers

  def self.perform
    Resque.enqueue(MailerWorker, 'AdminMailer', :yesterdays_reservations, Time.now)
  end
end
