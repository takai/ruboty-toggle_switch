module Ruboty
  module ToggleSwitch
    class Storage
      include Enumerable

      Switch = Struct.new(:state, :from, :at, :note)

      NAMESPACE = 'ruboty-toggle_switch-storage'

      def initialize(brain)
        @brain = brain
      end

      def [](key)
        switches[key]
      end

      def []=(key, value)
        switches[key] = Switch.new(value[:state], value[:from], Time.now, value[:note])
      end

      def on?(key)
        state_for(key) == 'on'
      end

      def off?(key)
        state_for(key) == 'off'
      end

      def each
        switches.each do |entry|
          yield(*entry)
        end
      end

      def size
        switches.size
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
