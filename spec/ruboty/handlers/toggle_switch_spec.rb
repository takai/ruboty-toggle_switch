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

describe Ruboty::Handlers::ToggleSwitch do
  let(:robot) { Ruboty::Robot.new }
  let(:from) { 'alice' }

  context 'switch is not on nor off' do
    describe '#toggle' do
      context 'turns on' do
        it 'turns switch on' do
          expect(robot).to receive(:say).with(hash_including(body: 'switch on apple is now on.'))
          robot.receive(body: "#{robot.name} toggle switch on apple on")
        end
      end
      context 'turns off' do
        it 'turns switch on' do
          expect(robot).to receive(:say).with(hash_including(body: 'switch on apple is now off.'))
          robot.receive(body: "#{robot.name} toggle switch on apple off")
        end
      end
    end

    describe '#show' do
      it do
        expect(robot).not_to receive(:say)
        robot.receive(body: "#{robot.name} show switch status")
      end
    end

    describe '#list' do
      it do
        expect(robot).not_to receive(:say)
        robot.receive(body: "#{robot.name} list switches")
      end
    end
  end

  context 'switch is on' do
    before { robot.receive(body: "#{robot.name} toggle switch on", from: from) }

    describe '#toggle' do
      context 'turns on' do
        it 'turns switch on' do
          expect(robot).to receive(:say).with(hash_including(body: 'switch is already on.'))
          robot.receive(body: "#{robot.name} toggle switch on")
        end
      end
      context 'turns off' do
        it 'turns switch on' do
          expect(robot).to receive(:say).with(hash_including(body: 'switch is now off.'))
          robot.receive(body: "#{robot.name} toggle switch off")
        end
      end
    end

    describe '#show' do
      it do
        expect(robot).to receive(:say).with(hash_including(body: /switch is on by #{from} on \w+ \d+ at \d\d:\d\d/))
        robot.receive(body: "#{robot.name} show switch status")
      end
    end

    describe '#list' do
      it do
        expect(robot).to receive(:say).with(hash_including(body: /- switch is on/))
        robot.receive(body: "#{robot.name} list switches")
      end
    end
  end

  context 'switch is on with note' do
    before { robot.receive(body: "#{robot.name} toggle switch on for great good", from: from) }

    describe '#show' do
      it do
        expect(robot).to receive(:say).with(hash_including(body: /switch is on by #{from} for great good on \w+ \d+ at \d\d:\d\d/))
        robot.receive(body: "#{robot.name} show switch status")
      end
    end
  end

  context 'switch is off' do
    before { robot.receive(body: "#{robot.name} toggle switch off", from: from) }

    describe '#toggle' do
      context 'turns on' do
        it 'turns switch on' do
          expect(robot).to receive(:say).with(hash_including(body: 'switch is now on.'))
          robot.receive(body: "#{robot.name} toggle switch on")
        end
      end
      context 'turns off' do
        it 'turns switch on' do
          expect(robot).to receive(:say).with(hash_including(body: 'switch is already off.'))
          robot.receive(body: "#{robot.name} toggle switch off")
        end
      end
    end

    describe '#show' do
      it do
        expect(robot).to receive(:say).with(hash_including(body: /switch is off by #{from} on \w+ \d+ at \d\d:\d\d/))
        robot.receive(body: "#{robot.name} show switch status")
      end
    end

    describe '#list' do
      it do
        expect(robot).to receive(:say).with(hash_including(body: /- switch is off/))
        robot.receive(body: "#{robot.name} list switches")
      end
    end
  end
end
