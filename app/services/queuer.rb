class Queuer
  def self.get_weekly_posts_count activity, network
    case activity.to_i
    when 1 # Casual
      case network
      when 'twitter'
        4
      else
        2
      end

    when 2 # Active
      case network
      when 'twitter'
        12
      when 'instagram'
        5
      else
        4
      end

    when 3 # Turbo
      case network
      when 'twitter'
        32
      when 'instagram'
        12
      else
        7
      end
    end
  end

  def self.valid_wdays_for_this_activity activity
    case activity.to_i
    when 1
      [3, 4, 5]
    when 2
      [3, 4, 5, 6]
    when 3
      [3, 4, 5, 6]
    end
  end

  def self.check_wdays_for_last_day activity
    case activity.to_i
    when 1
      [4, 5, 6]
    when 2
      [4, 5, 6, 7]
    when 3
      [4, 5, 6, 7]
    end  
  end

  def self.create_slots start_on, end_on, weekly_posts_count, activity
    slots = []
  
    
    slot_lists = []
    date = start_on.to_time.change(hour: 8, minute: 0)
    end_time = end_on + 20.hours
    while date <= end_time
      slot_list = []
      beginning_of_week = [date.at_beginning_of_week.to_time.change(hour: 8, minute: 0), start_on.to_time.change(hour: 8, minute: 0)].max
      end_of_week = [date.at_end_of_week.to_time.change(hour: 20, minute: 0), end_on.to_time.change(hour: 20, minute: 0)].min

      (beginning_of_week.to_i..end_of_week.to_i).step(30.minutes) do |date|
        time = Time.at(date)
        if time.wday.in?(valid_wdays_for_this_activity(activity)) 
          if (time.hour <= 11 && time.hour >= 8) || (time.hour >= 16 && time.hour <= 20)
            slot_list << { time: time, post: nil }
          end
        end
      end
      slot_lists << slot_list
      date = date + 1.week
    end


    slots = []
    slot_lists.each do |slot_list|
      if slot_list.count >= weekly_posts_count
        slots += slot_list.shuffle[0..weekly_posts_count - 1]
      end
    end
    slots
  end

  def self.fill_posts_to_slots posts, slots
    # binding.pry
    posts_size = posts.size
    (0..slots.size - 1).each do |i|
      slots[i][:post] = posts[i % posts_size]
      i += 1
    end
    slots
  end
end