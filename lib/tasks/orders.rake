namespace :orders do
  desc 'This task destroys guest orders that have expired'
  task clean: :environment do
    OrdersCleanerService.new.call
  end
end
