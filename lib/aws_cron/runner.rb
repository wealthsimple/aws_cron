module AwsCron

  # Cron runner that runs a schedule based on provided time_provider
  # You should avoid using this class directly
  class CronRunner
    def initialize(cron_str, time_provider=Time, leniency_secs=30*60)
      @cron = CronParser.new(cron_str, time_provider)
      @time_provider = time_provider
      @leniency_secs = leniency_secs
    end

    def run(time=@time_provider.now, &block)
      if should_run(time)
        yield
      end
    end

    def should_run(time)
      last_execution_time = @cron.last(time)

      time >= last_execution_time - @leniency_secs && time < last_execution_time + @leniency_secs
    end
  end
end
