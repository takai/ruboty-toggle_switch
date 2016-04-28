# Copyright 2016 Naoto Takai
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'spec_helper'

describe Ruboty::ToggleSwitch::Storage do
  subject(:storage) { Ruboty::ToggleSwitch::Storage.new(brain) }
  let(:brain) { Ruboty::Brains::Memory.new }
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
