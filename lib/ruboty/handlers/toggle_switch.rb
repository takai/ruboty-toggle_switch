module Ruboty
  module Handlers
    class ToggleSwitch < Base
      NAMESPACE = 'toggle_switch'

      on(/toggle\s+(?<switch>.*)\s+(?<state>on|off)/, name: 'toggle', description: 'Toggle switch')
      on(/show\s+(?<switch>.*)\s+status/, name: 'show', description: 'Show switch status')

      def toggle(message)
        switch = message[:switch]
        state = message[:state]

        storage_state = storage[switch] && storage[switch].state

        if storage_state == state
          message.reply("#{switch} is already #{state}.")
        else
          storage[switch] = {state: state, from: message.from_name}
          message.reply("#{switch} is now #{state}.")
        end
      end

      def show(message)
        switch = message[:switch]

        if (record = storage[switch])
          message.reply("#{switch} is #{record.state} by #{record.from}.")
        end
      end

      private

      def storage
        @storage ||= Ruboty::ToggleSwitch::Storage.new(robot.brain)
      end
    end
  end
end
