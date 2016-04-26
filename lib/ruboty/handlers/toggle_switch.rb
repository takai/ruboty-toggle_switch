module Ruboty
  module Handlers
    class ToggleSwitch < Base
      NAMESPACE = 'toggle_switch'

      on(/toggle\s+(?<switch>.*)\s+(?<state>on|off)(?:\s+(?<note>.*))?\z/, name: 'toggle', description: 'Toggle switch')
      on(/show\s+(?<switch>.*)\s+status\z/, name: 'show', description: 'Show switch status')

      def toggle(message)
        switch = message[:switch]
        state = message[:state]
        note = message[:note]

        storage_state = storage[switch] && storage[switch].state

        if storage_state == state
          message.reply("#{switch} is already #{state}.")
        else
          storage[switch] = {state: state, from: message.from_name, note: note}
          message.reply("#{switch} is now #{state}.")
        end
      end

      def show(message)
        switch = message[:switch]

        if (record = storage[switch])
          text = "#{switch} is #{record.state} by #{record.from} "
          text << "#{record.note} " if record.note
          text << "#{record.at.strftime('on %b %d at %H:%M')}."

          message.reply(text)
        end
      end

      private

      def storage
        @storage ||= Ruboty::ToggleSwitch::Storage.new(robot.brain)
      end
    end
  end
end
