# frozen_string_literal: true

require 'active_support'

# Controller helper concern
module AwsCron
  module Controller
    extend ActiveSupport::Concern

    class_methods do
      def timezone(name)
        @aws_time_provider = ActiveSupport::TimeZone.new(name)
      end

      def aws_time_provider
        @aws_time_provider
      end
    end

    # Runs block and ensures error logging and proper JSON return
    def run(&block)
      yield
    rescue => exception
      AwsCron::log(:error, exception)
    ensure
      return_object
    end

    # Runs block using defined timezone for cron scheduling
    # and ensures error logging and proper JSON return
    #
    # For tasks that call this method, make sure to have
    # cron.yaml call this task in way that allows it to
    # check programmatically if it needs to be triggered
    def run_in_tz(cron_str, &block)
      run do
        CronRunner.new(cron_str, self.class.aws_time_provider || time_provider || Time).run do
          yield
        end
      end
    end

    protected

    def return_object
      if respond_to?(:render) # Check for ActionController::Rendering
        render :json => {message: 'ok'}
      else
        raise SecurityError('You must implement return_object with a 200 HTTP response using your preferred web framework')
      end
    end

    # Please use <tt>timezone</tt>, unless you need a custom time provider.
    def time_provider
    end
  end
end
