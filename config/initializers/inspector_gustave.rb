require 'rubygems'
require 'rufus-scheduler'

#Creates and registers a new Rufus Scheduler (basically a cron hosted on the Rails server instead of the vHost,
#	which only operates on application functions instead of system functions).
INSPECTOR_GUSTAVE = Rufus::Scheduler.new

#OK, so this is just a PlainScheduler.  You can't call SchedulerCore methods on it, so Rufus logging 
#will have to go elsewhere.

#This basically lets you know that INSPECTOR_GUSTAVE is working just by looking at the server output.
INSPECTOR_GUSTAVE.every '5m' do
	puts('INSPECTOR_GUSTAVE is on the lookout for orphans.')
end