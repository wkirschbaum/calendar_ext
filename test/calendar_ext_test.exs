defmodule CalendarExtTest do
  use ExUnit.Case
  doctest CalendarExt

  describe "diff_weekdays" do
    test "on the same day" do
      day = elem(Date.new(2010, 7, 3), 1)

      assert CalendarExt.diff_weekdays(day, day) == 0
    end

    test "for one weekday" do
      from_date = elem(Date.new(2020, 11, 26), 1)
      to_date = elem(Date.new(2020, 11, 27), 1)

      assert CalendarExt.diff_weekdays(from_date, to_date) == 1
    end

    test "for one weekend_day" do
      from_date = elem(Date.new(2020, 11, 28), 1)
      to_date = elem(Date.new(2020, 11, 29), 1)

      assert CalendarExt.diff_weekdays(from_date, to_date) == 0
    end

    test "for one week_day and one weekend day" do
      from_date = elem(Date.new(2020, 11, 29), 1)
      to_date = elem(Date.new(2020, 11, 30), 1)

      assert CalendarExt.diff_weekdays(from_date, to_date) == 0
    end

    test "for one week and one weekend day" do
      from_date = elem(Date.new(2020, 11, 27), 1)
      to_date = elem(Date.new(2020, 11, 28), 1)

      assert CalendarExt.diff_weekdays(from_date, to_date) == 1
    end

    test "for two week days spanning a weekend" do
      from_date = elem(Date.new(2020, 11, 27), 1)
      to_date = elem(Date.new(2020, 12, 1), 1)

      assert CalendarExt.diff_weekdays(from_date, to_date) == 2
    end

    test "for a year" do
      from_date = elem(Date.new(2010, 7, 3), 1)
      to_date = elem(Date.new(2011, 7, 3), 1)

      assert CalendarExt.diff_weekdays(from_date, to_date) == 260
    end

    test "spanning over a year" do
      from_date = elem(Date.new(2019, 12, 28), 1)
      to_date = elem(Date.new(2020, 1, 13), 1)

      assert CalendarExt.diff_weekdays(from_date, to_date) == 10
    end

    test "diff_weekdays for a week period returns 4" do
      from_date = elem(Date.new(2020, 09, 21), 1)
      to_date = elem(Date.new(2020, 09, 25), 1)

      assert CalendarExt.diff_weekdays(from_date, to_date) == 4
    end

    test "from monday to saturday" do
      from_date = elem(Date.new(2020, 09, 21), 1)
      to_date = elem(Date.new(2020, 09, 26), 1)

      assert CalendarExt.diff_weekdays(from_date, to_date) == 5
    end

    test "for Sunday and Saturday returns 0" do
      from_date = elem(Date.new(2020, 09, 19), 1)
      to_date = elem(Date.new(2020, 09, 21), 1)

      assert CalendarExt.diff_weekdays(from_date, to_date) == 0
    end

    test "from_date is after to_date returns 0" do
      from_date = elem(Date.new(2020, 09, 19), 1)
      to_date = elem(Date.new(2020, 09, 21), 1)

      assert CalendarExt.diff_weekdays(to_date, from_date) == 0
    end
  end
end
