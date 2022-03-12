require 'rufus/scheduler'

scheduler = Rufus::Scheduler.new

scheduler.cron '0 23 * * *' do
  #run this everyday at 23 pm..
  BorrowBook.task_calculate_fine_for_borrowed_books
end

# scheduler.every '24h' do
#   print 'activate security system'
# end