require 'aws_cron'
require 'active_support/testing/time_helpers'
require 'active_support/all'

module AwsCron
  describe Controller do
    include ActiveSupport::Testing::TimeHelpers

    subject {
      obj = Struct.new(:dummy) { include Controller }.new
      allow(obj).to receive(:return_object)
      obj
    }

    context 'with timezone time' do
      it 'should run block' do
        expect { |b| subject.run_in_tz('* * * * *', &b) }.to yield_control
      end

      context 'with specific time' do
        before(:each) { travel_to Time.new(2016, 1, 2, 3, 1) }

        it 'should run block after set time' do
          expect { |b| subject.run_in_tz('0 3 * * *', &b) }.to yield_control
        end

        it 'should not run block before set time' do
          expect { |b| subject.run_in_tz('30 2 * * *', &b) }.to_not yield_control
        end
      end
    end

    context 'without timezone time' do
      it 'should run block' do
        expect { |b| subject.run(&b) }.to yield_control
      end
    end
  end
end
