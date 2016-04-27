module Ruboty
  module ToggleSwitch
    class Storage
      include Enumerable

      # Represents a switch.
      Switch = Struct.new(:state, :from, :at, :note)

      NAMESPACE = 'ruboty-toggle_switch-storage'

      # Returns a new instance of Storage
      # @param [Ruboty::Brain] brain
      def initialize(brain)
        @brain = brain
      end

      # Returns the switch to which the specified key is mapped.
      #
      # @return [Switch, nil] the switch or nil
      def [](key)
        switches[key]
      end

      # Update the switch which is associated with the specified key.
      #
      # @param [String] key the key for the switch.
      # @param [Hash] value the value to update the switch.
      # @option value [String] :state "on" or "off".
      # @option value [String] :from a name of the message sender.
      def []=(key, value)
        switches[key] = Switch.new(value[:state], value[:from], Time.now, value[:note])
      end

      # Returns true if the switch is 'on'.
      #
      # @return [Boolean] true if the state of the switch is "on"
      def on?(key)
        state_for(key) == 'on'
      end

      # Returns true if the switch is 'off'.
      #
      # @return [Boolean] true if the state of the switch is "off"
      def off?(key)
        state_for(key) == 'off'
      end

      # Yields each pair of the key and switch.
      def each
        switches.each do |entry|
          yield(*entry)
        end
      end

      private

      def state_for(key)
        switches[key] && switches[key].state
      end

      def switches
        @brain.data[NAMESPACE] ||= {}
      end
    end
  end
end
