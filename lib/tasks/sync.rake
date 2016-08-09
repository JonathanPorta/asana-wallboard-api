desc "Syncronize state with Asana"
namespace :sync do
  task :all do
    Rake::Task['sync:users'].invoke
    Rake::Task['sync:projects'].invoke
    Rake::Task['sync:tasks'].invoke
  end

  task users: :environment do
    puts "syncing users"
    SyncUsers.new.call()
  end

  task projects: :environment do
    puts "syncing projects"
    SyncProjects.new.call()
  end

  task tasks: :environment do
    puts "syncing tasks"
    SyncTasks.new.call()
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
