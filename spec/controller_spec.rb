describe AwsCronRunner do

  subject {
    obj = Struct.new(:dummy) { include AwsCronRunner }.new
    allow(obj).to receive(:return_object)
    obj
  }

  context 'with timezone time' do
    it 'should run block' do
      expect { |b| subject.run_in_tz('* * * * *', &b) }.to yield_control
    end

    context 'with specific time' do
      before(:each) { Timecop.freeze(Time.local(2016, 1, 2, 3, 1)) }

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
