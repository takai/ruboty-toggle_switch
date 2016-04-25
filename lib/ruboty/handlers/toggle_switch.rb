module Ruboty
  module Handlers
    class ToggleSwitch < Base
      NAMESPACE = 'toggle_switch'

      on(/toggle\s+(?<switch>.*)\s+(?<state>on|off)/, name: 'toggle', description: 'Toggle switch')
      on(/show\s+(?<switch>.*)\s+status/, name: 'show', description: 'Show switch status')

      def toggle(message)
        switch = message[:switch]
        state = message[:state]

        if switches[switch] == state
          message.reply("#{switch} is already #{state}.")
        else
          switches[switch] = state
          message.reply("#{switch} is now #{state}.")
        end
      end

      def show(message)
        switch = message[:switch]

        if (state = switches[switch])
          message.reply("#{switch} is #{state}.")
        end
      end

      private

      def switches
        robot.brain.data[NAMESPACE] ||= {}
      end
    end
  end
end
