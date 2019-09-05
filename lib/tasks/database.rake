namespace :db do
  desc "Rebuild the development database from scratch"
  task :rebuild => :environment do
    sh "rm -f db/development.sqlite3"
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:seed"].invoke
  end
end

# これを作成することによって bin/rails db:rebuildコマンドが使用できるようになる
# sqliteのみ使用できる mysqlやpsgreでは使えない
