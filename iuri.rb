
require 'rufus-json/automatic'
require 'ruote'
require 'ruote-sequel'


if ! %w[ worker launch purge ].include?(ARGV.first)
  puts
  puts "run me with"
  puts
  puts "  ruby #{$0} worker   # to run a worker"
  puts
  puts "  ruby #{$0} launch   # to launch a sample flow"
  puts
  puts "  ruby #{$0} purge    # to purge the db"
  puts
  exit 1
end

#sequel = Sequel.connect('mysql2://root@localhost/ruote_test')
#Ruote::Sequel.create_table(sequel)
#storage = Ruote::Sequel::Storage.new(sequel)
require 'ruote/storage/fs_storage'
storage = Ruote::FsStorage.new('ruote_work')

if ARGV.first == 'worker'

  #class CleanCar < Ruote::StorageParticipant
  class CleanCar < Ruote::Participant
    def on_workitem
      #super
      workitem.fields['counter'] = workitem.fields['counter'] + 1
      puts "-" * 80
      puts "* clean car #{workitem.fei.sid}"
      puts "  counter #{workitem.fields['counter']}"
      @context.storage.get_many('expressions').each do |d|
        puts "exp: #{d['_id']}"
      end
      @context.storage.get_many('workitems').each do |d|
        puts "wi: #{d['_id']}"
      end
      @context.storage.get_many('errors').each do |d|
        puts "err: #{d['_id']}"
      end
      #proceed(workitem)
      reply
    end
  end

  ruote =  Ruote::Dashboard.new(Ruote::Worker.new(storage))
  ruote.noisy = (ENV['NOISY'] == 'true')

  ruote.register('clean_car', CleanCar)

  puts "ruote worker running, pid is #{$$}"
  ruote.join

  # doesn't exit on its own

elsif ARGV.first == 'purge'

  storage.purge!
  #storage.close

else

  ruote =  Ruote::Dashboard.new(storage)
  ruote.noisy = (ENV['NOISY'] == 'true')

  pdef =
    Ruote.define do
      set 'f:counter' => 0
      #cursor do
      #  clean_car
      #  rewind
      #end
      repeat do
        clean_car
      end
    end

  wfid = ruote.launch(pdef)

  puts "launched flow instanced #{wfid}"

  #storage.close

  # exits immediately
end

