class HardJob
  include Sidekiq::Job
  sidekiq_options queue: 'critical'

  def perform(name, count)
    puts "Performing hard job for #{name}, #{count} times"
  end
  
end
