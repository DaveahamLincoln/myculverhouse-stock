class LabTicket < ActiveRecord::Base
  #Don't know why this comment is here.
  #has_and_belongs_to_many :tasks

  #This may not work as intended.
  has_many :tasks

  attr_accessible :clientID, :dateScheduled, :locationID, :problemDescription, :programID, :receivingTech, :requestedBy, :resolution, :status, :supervisorID, :techNotes, :urgency, :dateClosed, :closingTech
  
  #Adds opinio comment functionality to the model.
  opinio_subjectum

  def send_lab_ticket_close_burst
    #Mailer sends the client a notification that their ticket has been closed which includes a link to a google form with an exit survey.
    LabTicketMailer.lab_ticket_notify_client_of_close(self).deliver
    #Fires the unsubscribe_from_thread method.
    #unsubscribe_from_thread(self)
    #close_thread(self)
  end

  def status_alias
    #Returns a string representation of a given status for rendering in a view.  You can add more status types
    #by defining them here.
    if self.status==1 then
      "Open"
    elsif self.status==2 then
      "Deployed"
    elsif self.status==3 then
      "Awaiting Hardware"
    elsif self.status==4 then
      "Awaiting Client"
    elsif self.status==5 then
      "Outsourced"
    elsif self.status==6 then
      "On Hold"
    end
  end

  def digest
    #Returns an easy to read output representing the LabTicket.
    "ID##{self.id} - #{self.problemDescription}"
  end
end
