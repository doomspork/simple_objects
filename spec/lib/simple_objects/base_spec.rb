require 'spec_helper'

module SimpleObjects
  describe Base do

    class MockObject
      include Base

      attr_accessor :one, :two, :three
    end

    describe '#initialize' do
      let(:args) do
        {
          one: 1,
          two: 3
        }
      end

      subject { MockObject.new(args) }

      its(:one) { is_expected.to eq 1 }
      its(:two) { is_expected.to eq 3 }
      its(:three) { is_expected.to be_nil }
    end

    describe '#to_h' do
      subject { MockObject.new(one: 'foo', two: 2).to_h }

      it { is_expected.to include(one: 'foo', two: 2, three: nil) }
    end
  end
end
