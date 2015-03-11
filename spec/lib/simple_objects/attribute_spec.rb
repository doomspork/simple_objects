require 'spec_helper'

module SimpleObjects
  describe Attribute do
    subject { Attribute.new('test') }

    it { is_expected.to respond_to :default }
    it { is_expected.to respond_to :name }
    it { is_expected.to respond_to :required }
    it { is_expected.to respond_to :type }

    context 'with options' do
      subject { Attribute.new('test', default: 'foo', type: String, required: true) }

      its(:name) { is_expected.to eq 'test' }
      its(:default) { is_expected.to eq 'foo' }
      its(:required) { is_expected.to be_truthy }
      its(:type) { is_expected.to eq String }
    end
  end
end
