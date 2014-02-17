class TroubleTicket < ActiveRecord::Base
  attr_accessible :assignedTech, :assignedTechConfirmed, :clientID, :dateClosed, :dateScheduled, 
  :equipmentID, :locationID, :problemDescription, :programID, :receivingTech, :requestedBy, :resolution, 
  :status, :supervisorID, :techNotes, :urgency

  def send_trouble_ticket_create_burst
    #Uses the TroubleTicketMailer in app/mailers to send mail to the assigned tech and the client.
	TroubleTicketMailer.trouble_ticket_notify_tech(self).deliver
    TroubleTicketMailer.trouble_ticket_notify_client(self).deliver
    
    #Fires the bank of choreos that creates the Disqus thread, binds it to the ticket, and subscribes the client.
    #self.create_thread(self)

    #Checks to see if the ticket is urgent.  If it is, the mailer sends the administrators an email notifying them that an urgent ticket has been created.
    if self.urgency >= 3 
    	TroubleTicketMailer.trouble_ticket_notify_admin_of_create(self).deliver
    end

    #Adds a thread to the INSPECTOR_GUSTAVE rufus-scheduler that triggers in T+1 hour.
    INSPECTOR_GUSTAVE.in '1h' do
      #If the assigned tech hasn't confirmed the ticket, the mailer sends the admins an email notifying them that the icket has been orphaned and 
      #adds another thread to INSPECTOR_GUSTAVE that fires in T+30 minutes.
      if not self.assignedTechConfirmed
        TroubleTicketMailer.trouble_ticket_notify_admin_of_orphan(self).deliver
        INSPECTOR_GUSTAVE.in '30m' do
          #If the assigned tech still hasn't confirmed the ticket at T+1:30, the mailer sends the admins an email alerting them to the fact.
          if not self.assignedTechConfirmed == 0
            TroubleTicketMailer.trouble_ticket_notify_admin_of_super_orphan(self).deliver
          end
        end
      end
    end
  end

end
