require 'spec_helper'
require 'pry'

module SimpleObjects
  describe Attributes do
    class BasicExample
      include Attributes

      attribute :foo
    end

    describe '.attribute' do
      subject { BasicExample.new }

      it { is_expected.to respond_to :foo }

      it 'is inherited' do
      end
    end

    context 'when inherited' do
      class AnotherBasicExample < BasicExample
      end

      subject { AnotherBasicExample.attributes }

      its(:size) { is_expected.to eq 1 }
    end

    describe '#mass_assign' do
      context 'with option' do
        class OptionsExample
          include Attributes

          attribute :one
          attribute :two, required: true
          attribute :three, default: 'three'
          attribute :four, type: String
        end

        let(:inputs) { }

        subject do
          example = OptionsExample.new
          example.send(:mass_assign, inputs)
          example
        end

        context ':default' do
          context 'without a value' do
            let(:inputs) { { two: '' } }

            it 'will set the default value' do
              expect(subject.three).to eq 'three'
            end
          end

          context 'with a value' do
            let(:inputs) { { two: '', three: 'one' } }

            it 'will do nothing' do
              expect(subject.three).to eq 'one'
            end
          end
        end

        context ':required' do
          context 'without a value' do
            let(:inputs) { {} }

            it 'raises RequiredMissingError' do
              expect { subject }.to raise_error RequiredMissingError
            end
          end

          context 'with a value' do
            let(:inputs) { { two: 'value' } }

            it 'will do nothing' do
              expect(subject.two).to eq 'value'
            end
          end
        end

        context ':type' do
          context 'with wrong type' do
            let(:inputs) { { two: 'value', four: 1 } }

            it 'raises MismatchedTypeError' do
              expect { subject }.to raise_error MismatchedTypeError
            end
          end

          context 'with matching types' do
            let(:inputs) { { two: 'value', four: 'a string' } }

            it 'will do nothing' do
              expect { subject }.to_not raise_error
            end
          end
        end
      end
    end
  end
end
