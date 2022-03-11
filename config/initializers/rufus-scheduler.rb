require 'rufus/scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '10s' do
  print "daud"
end

# scheduler.cron '0 22 * * 1-5' do
#   # every day of the week at 22:00 (10pm)
#   puts 'activate security system'
# end