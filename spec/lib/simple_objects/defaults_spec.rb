require 'spec_helper'

module SimpleObjects
  describe Defaults do

    class MockObject
      include Base
      include Defaults

      attr_accessor :one, :two, :three

      attr_default two: 2
    end

    describe '#initialize' do

      subject { MockObject.new(one: 1) }

      its(:one) { is_expected.to eq 1 }
      its(:two) { is_expected.to eq 2 }
      its(:three) { is_expected.to be_nil }
    end
  end
end
