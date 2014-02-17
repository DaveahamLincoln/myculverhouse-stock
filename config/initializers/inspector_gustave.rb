require 'rubygems'
require 'rufus-scheduler'
INSPECTOR_GUSTAVE = Rufus::Scheduler.new

#OK, so this is just a PlainScheduler.  You can't call SchedulerCore methods on it, so Rufus logging will have to go elsewhere.
INSPECTOR_GUSTAVE.every '5m' do
	puts('INSPECTOR_GUSTAVE is on the lookout for orphans.')
end
