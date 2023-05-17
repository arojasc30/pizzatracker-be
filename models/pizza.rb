class Pizza < Sequel::Model(DB[:pizzas])
  many_to_one :person

  def self.calculate_increasing_streaks
  streaks = []
  previous_count = nil
  current_streak_start = nil

  dataset = DB[:pizzas].order(:date) # Replace 'pizzas' with your actual table name

  dataset.each do |consumption|
    next if consumption[:date].wday == 0 # Ignore Sundays

    if previous_count.nil? || consumption[:count] > previous_count
      # Start a new streak
      current_streak_start ||= consumption[:date]
    elsif consumption[:count] <= previous_count && current_streak_start
      # End the current streak
      streaks << { start_date: current_streak_start, end_date: consumption[:date] - 1 }
      current_streak_start = nil
    end

    previous_count = consumption[:count]
  end

  # Check if the last streak continued until the end
  streaks << { start_date: current_streak_start, end_date: Date.today - 1 } if current_streak_start

  streaks
end


  def self.calculate_most_pizzas_day
    consumptions = all
    daily_counts = consumptions.group_by { |consumption| consumption.date.day }
                               .transform_values(&:count)
    daily_counts.max_by { |_day, count| count }&.first
  end
end
