module Ruboty
  module ToggleSwitch
    class Storage
      Record = Struct.new(:state, :from, :at)

      NAMESPACE = 'ruboty-toggle_switch-storage'

      def initialize(brain)
        @brain = brain
      end

      def [](key)
        records[key]
      end

      def []=(key, value)
        records[key] = Record.new(value[:state], value[:from], Time.now)
      end

      private

      def records
        @brain.data[NAMESPACE] ||= {}
      end
    end
  end
end
