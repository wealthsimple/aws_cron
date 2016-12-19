# frozen_string_literal: true

# Controller helper concern
module AwsCron
  module Controller
    extend ActiveSupport::Concern

    # Runs block and ensures error logging and proper JSON return
    def run(&block)
      yield
    rescue => exception
      Rails.logger.error(exception) # TODO replace with portable Ruby logger
    ensure
      self.return_object
    end

    # Runs block using defined timezone for cron scheduling
    # and ensures error logging and proper JSON return
    #
    # For tasks that call this method, make sure to have
    # cron.yaml call this task in way that allows it to
    # check programmatically if it needs to be triggered
    def run_in_tz(cron_str, &block)
      run do
        CronRunner.new(cron_str, time_provider).run do
          yield
        end
      end
    end

    protected

    def return_object
      raise SecurityError('You must implement return_object with a 200 HTTP response using your preferred web framework')
    end

    def time_provider
      Time
    end

    private
    require_relative 'aws_cron/runner/runner.rb'

  end
end