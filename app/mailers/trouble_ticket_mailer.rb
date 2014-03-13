class LabTicketMailer < ActionMailer::Base
  default from: "pookydaemon@tech.cba.ua.edu"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject

  def trouble_ticket_notify_client_of_close(ticket)
    #Includes Google Form survey.  Need to configure power users who can view the form info pre-deployment and shift from danearing@cba.ua.edu to 
    #some_daemon_address@cba.ua.edu
    @ticket = ticket
    @client = User.find(@ticket.clientID)
    mail :to => @client.email, :subject => "Lab Ticket ##{@ticket.id} Closed"
  end

end
