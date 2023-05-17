class Pizza < Sequel::Model(DB[:pizzas])
  many_to_one :person

  def self.calculate_increasing_streaks
    streaks = []
    previous_count = nil
    current_streak_start = nil
    consumptions_by_day = DB[:pizzas].order(:date).to_a.group_by { |record| record[:date].to_date }
                                     .transform_values(&:count)

    consumptions_by_day.each do |date, count|
      next if date.wday == 0 # Ignore Sundays

      if previous_count.nil?
        # Initialize the streak with the first valid count
        previous_count = count
        current_streak_start = date
      elsif count > previous_count
        # Continue the streak
        previous_count = count
      elsif count <= previous_count && !current_streak_start.nil?
        # End the streak
        streaks << { start_date: current_streak_start, end_date: date }
        current_streak_start = nil
      end
    end

    # Check if the last streak continues until the end
    unless current_streak_start.nil?
      streaks << { start_date: current_streak_start,
                   end_date: consumptions_by_day.keys.last }
    end

    streaks
  end

  def self.calculate_most_pizzas_day
    consumptions = all
    daily_counts = consumptions.group_by { |consumption| consumption.date.day }
                               .transform_values(&:count)
    daily_counts.max_by { |_day, count| count }&.first
  end
end
