class TroubleTicketMailer < ActionMailer::Base
  default from: "pookydaemon@tech.cba.ua.edu"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def trouble_ticket_notify_tech(ticket)
    @ticket = ticket
    @tech = User.find(@ticket.assignedTech)
    mail :to => @tech.email, :subject => "Assignment: Trouble Ticket ##{@ticket.id}"
  end

  def trouble_ticket_notify_client(ticket)
    @ticket = ticket
    @client = User.find(@ticket.clientID)
    mail :to => @client.email, :subject => "Trouble Ticket ##{@ticket.id} Received"
  end

  def trouble_ticket_notify_admin_of_create(ticket)
    @ticket = ticket
    mail :to => "admins@cba.ua.edu", :subject => "Urgent Trouble Ticket ##{@ticket.id} Received"
  end

  def trouble_ticket_notify_admin_of_orphan(ticket)
    @ticket = ticket
    @tech = User.find(@ticket.assignedTech)
    mail :to => "admins@cba.ua.edu", :subject => "Trouble Ticket ##{@ticket.id} Orphaned"
  end

  def trouble_ticket_notify_admin_of_super_orphan(ticket)
    @ticket = ticket
    @tech = User.find(@ticket.assignedTech)
    mail :to => "admins@cba.ua.edu", :subject => "URGENT! Trouble Ticket ##{@ticket.id} Orphaned"
  end

  def trouble_ticket_notify_client_of_close(ticket)
    #Includes Google Form survey.  Need to configure power users who can view the form info pre-deployment and shift from danearing@cba.ua.edu to 
    #some_daemon_address@cba.ua.edu
    @ticket = ticket
    @client = User.find(@ticket.clientID)
    mail :to => @client.email, :subject => "Trouble Ticket ##{@ticket.id} Received"
  end

end
