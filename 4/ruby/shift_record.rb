require 'date'

class ShiftRecord
  include Comparable

    attr_accessor :time, :event, :guard

    def initialize(time:, event:, guard: nil)
      @time = DateTime.parse(time)
      @event = event
      @guard = guard
    end

    def<=>(an_other)
      time <=> an_other.time
    end
end
