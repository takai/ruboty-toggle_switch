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

module Ruboty
  module Handlers
    class ToggleSwitch < Base
      NAMESPACE = 'toggle_switch'

      on(/toggle\s+(?<switch>.*)\s+(?<state>on|off)(?:\s+(?<note>.*))?\z/, name: 'toggle', description: 'Toggle switch')
      on(/show\s+(?<switch>.*)\s+status\z/, name: 'show', description: 'Show switch status')
      on(/list switches/, name: 'list', description: 'Show list of switches')

      def toggle(message)
        switch = message[:switch]
        state  = message[:state]
        note   = message[:note]

        storage_state = storage[switch] && storage[switch].state

        if storage_state == state
          message.reply("#{switch} is already #{state}.")
        else
          storage[switch] = { state: state, from: message.from_name, note: note }
          message.reply("#{switch} is now #{state}.")
        end
      end

      def show(message)
        switch = message[:switch]

        if (record = storage[switch])
          text = "#{switch} is #{record.state} "
          text << "by #{record.from} " if record.from
          text << "#{record.note} " if record.note
          text << record.at.strftime('on %b %d at %H:%M')
          text << '.'

          message.reply(text)
        end
      end

      def list(message)
        storage.each do |key, record|
          message.reply("- #{key} is #{record.state}.")
        end
      end

      private

      def storage
        @storage ||= Ruboty::ToggleSwitch::Storage.new(robot.brain)
      end
    end
  end
end
