require 'spec_helper'

module SimpleObjects
  describe Serialization do

    class ExampleSerialization
      include Base

      attribute :one
      attribute :two

      def timestamp
        Time.now
      end
    end

    describe '#to_h' do
      let(:options) { {} }
      let(:example) { ExampleSerialization.new }

      subject { example.to_h(options) }

      it { is_expected.to be_a Hash }
      it { is_expected.to include(:one, :two) }

      context 'with option' do
        context ':only' do
          let(:options) { { only: [:one] } }

          it { is_expected.to_not include(:two) }
        end

        context ':except' do
          let(:options) { { except: [:one] } }

          it { is_expected.to_not include(:one) }
        end

        context ':methods' do
          let(:options) { { methods: [:timestamp] } }

          it { is_expected.to include(:timestamp) }
        end
      end

      context 'with a collection' do
        let(:example) { ExampleSerialization.new(one: [ExampleSerialization.new]) }

        it 'will call .to_h on entries' do
          expect(subject[:one]).to be_a Array
          expect(subject[:one].first).to include(:one, :two)
        end
      end

      context 'with a value that responds to .to_h' do
        let(:example) { ExampleSerialization.new(one: ExampleSerialization.new) }

        it 'will call .to_h' do
          expect(subject[:one]).to include(:one, :two)
        end
      end

    end
  end
end
