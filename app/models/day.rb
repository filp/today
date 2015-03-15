class Day
  include ActiveModel::Model

  attr_accessor :user
  attr_reader   :datetime

  def tasks
    @tasks_scope ||= \
    begin
      raise "Attempt to get tasks without Day#user" if user.nil?

      # TODO
      user.tasks
    end
  end

  def today?
    datetime.to_date == Date.today
  end

  def yesterday?
    1.day.ago.to_date == datetime.to_date
  end

  def datetime=(new_date)
    @datetime = new_date

    # Ensure the model updates properly to account
    # for the new date.
    reload

    new_date
  end

  # Mimics ActiveRecord's #reload by simply niling the
  # instance variable keeping the tasks scope
  def reload
    @tasks_scope = nil
  end

  def self.today(user)
    Day.new(
      user:     user,
      datetime: Date.today
    )
  end

  def self.yesterday(user)
    Day.new(
      user:     user,
      datetime: 1.day.ago.to_date
    )
  end
end