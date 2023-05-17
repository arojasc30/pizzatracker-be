class Consumption < Sequel::Model
  many_to_one :pizza
  many_to_one :person

  def self.calculate_increasing_streaks
    consumptions = all.order(:date)
    streaks = []
    current_streak_start = nil

    consumptions.each_with_index do |consumption, index|
      previous_consumption = consumptions[index - 1]

      if previous_consumption.nil? || consumption.pizzas_consumed > previous_consumption.pizzas_consumed
        # Start a new streak
        current_streak_start = consumption.date if current_streak_start.nil?
      elsif consumption.pizzas_consumed <= previous_consumption.pizzas_consumed
        # End the current streak
        unless current_streak_start.nil?
          streaks << { start_date: current_streak_start, end_date: previous_consumption.date }
          current_streak_start = nil
        end
      end
    end

    # Check if the last streak continued until the end
    streaks << { start_date: current_streak_start, end_date: consumptions.last.date } unless current_streak_start.nil?

    streaks
  end

  def self.calculate_most_pizzas_day
    consumptions = all
    daily_counts = consumptions.group_by { |consumption| consumption.date.day }
                               .transform_values(&:count)
    daily_counts.max_by { |_day, count| count }&.first
  end
end
