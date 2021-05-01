# frozen_string_literal: true

FactoryBot.define do
  factory :time_entry, class: TimeEntry do
    user { User.first }
    clock_in { Time.now - 2.hours }
    clock_out { Time.now }
    detail { "Clay Modeling" }
  end
end
