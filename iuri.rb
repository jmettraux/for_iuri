
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

sequel = Sequel.connect('mysql2://root@localhost/ruote_test')
storage = Ruote::Sequel::Storage.new(sequel)

if ARGV.first == 'worker'

  class CleanCar < Ruote::Participant
    def on_workitem
      workitem.fields['counter'] = workitem.fields['counter'] + 1
      puts "* clean car #{workitem.fei.sid}"
      puts "  counter #{workitem.fields['counter']}"
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
      repeat do
        clean_car
      end
    end

  wfid = ruote.launch(pdef)

  puts "launched flow instanced #{wfid}"

  #storage.close

  # exits immediately
end

