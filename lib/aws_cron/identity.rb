# frozen_string_literal: true

module AwsCron
  # Gem identity information.
  module Identity
    def self.name
      "aws_cron"
    end

    def self.label
      "AwsCron"
    end

    def self.version
      "0.1.3"
    end

    def self.version_label
      "#{label} #{version}"
    end
  end
end
