require 'spec_helper'

module SimpleObjects
  describe Base do

    class ExampleBase
      include Base

      attribute :one
      attribute :two
    end

    subject { ExampleBase.new }

    describe '#initialize' do
      let(:args) do
        {
          one: 1,
          two: 3
        }
      end

      subject { ExampleBase.new(args) }

      its(:one) { is_expected.to eq 1 }
      its(:two) { is_expected.to eq 3 }
    end

    it { is_expected.to respond_to(:to_h) }
  end
end
