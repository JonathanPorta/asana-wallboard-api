desc "Syncronize state with Asana"
namespace :sync do
  task :all do
    Rake::Task['sync:users'].invoke
  end

  task users: :environment do
    puts "syncing users"
    SyncUsers.new.call()
  end

  desc 'Syncronize Asana every 5 minutes'
  task periodically: :environment do
    puts 'Starting Periodic Sync for all Asana data models'
    while true do
      Rake::Task['sync:all'].invoke
      sleep 300
    end
  end
end
