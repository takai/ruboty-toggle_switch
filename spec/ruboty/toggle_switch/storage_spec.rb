require 'spec_helper'

describe Ruboty::ToggleSwitch::Storage do
  subject(:storage) { Ruboty::ToggleSwitch::Storage.new(brain) }
  let(:brain) { double('brain', data: {}) }
  let(:key) { 'key' }

  describe '#[](key)' do
    context 'nil' do
      it { expect(storage[key]).to be_nil }
    end
    context 'on' do
      before { storage[key] = { state: 'on' } }

      it { expect(storage[key].state).to eq('on') }
    end
  end

  describe '#on?' do
    context 'nil' do
      it { expect(storage.on?(key)).to be_falsey }
    end
    context 'on' do
      before { storage[key] = { state: 'on' } }

      it { expect(storage.on?(key)).to be_truthy }
    end
    context 'off' do
      before { storage[key] = { state: 'off' } }

      it { expect(storage.on?(key)).to be_falsey }
    end
  end

  describe '#off?' do
    context 'nil' do
      it { expect(storage.off?(key)).to be_falsey }
    end
    context 'on' do
      before { storage[key] = { state: 'on' } }

      it { expect(storage.off?(key)).to be_falsey }
    end
    context 'off' do
      before { storage[key] = { state: 'off' } }

      it { expect(storage.off?(key)).to be_truthy }
    end
  end
end
