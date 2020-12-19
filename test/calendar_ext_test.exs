defmodule CalendarExtTest do
  use ExUnit.Case
  doctest CalendarExt

  describe "to_naive_with_invalid_time" do
    test "it leaves a valid UTC date as is" do
      date = "2020-12-18T22:28:36Z"

      assert CalendarExt.to_naive_with_invalid_time(date) == ~N[2020-12-18 22:28:36]
    end

    test "it assumes UTC" do
      date = "2020-12-18T22:28:36"

      assert CalendarExt.to_naive_with_invalid_time(date) == ~N[2020-12-18 22:28:36]
    end

    test "it assumes default offset" do
      date = "2020-12-18T22:28:36"

      assert CalendarExt.to_naive_with_invalid_time(date, "+02:00") == ~N[2020-12-18 20:28:36]
    end

    test "it handles negative time" do
      date = "2020-12-18T27:28:36"

      assert CalendarExt.to_naive_with_invalid_time(date, "+02:00") == ~N[2020-12-19 01:28:36]
    end

    test "it assumes default offset with bad time" do
      date = "2020-12-18T24:28:36"

      assert CalendarExt.to_naive_with_invalid_time(date, "+02:00") == ~N[2020-12-18 22:28:36]
    end

    test "it adjusts the offset date" do
      date = "2020-12-18T22:28:36+02:00"

      assert CalendarExt.to_naive_with_invalid_time(date) == ~N[2020-12-18 20:28:36]
    end

    test "it handles > 24 hours clock" do
      date = "2020-12-18T24:28:36"

      assert CalendarExt.to_naive_with_invalid_time(date) == ~N[2020-12-19 00:28:36]
    end

    test "it handles milliseconds without timezone" do
      date = "2020-12-19 07:28:48.548646"
      assert CalendarExt.to_naive_with_invalid_time(date) == ~N[2020-12-19 07:28:48.548646]
    end

    test "it handles milliseconds with timezone" do
      date = "2020-12-19 07:28:48.548646Z"
      assert CalendarExt.to_naive_with_invalid_time(date) == ~N[2020-12-19 07:28:48.548646]
    end
  end


  describe "outside?" do
    test "returns true if a Date is before the start_date" do
      date = elem(Date.new(2001, 1, 25), 1)

      start_date = elem(Date.new(2010, 1, 25), 1)
      end_date = elem(Date.new(2010, 3, 3), 1)

      assert CalendarExt.outside?(date, start_date, end_date) == true
    end

    test "returns true if a Date is after the end_date" do
      date = elem(Date.new(2101, 1, 25), 1)

      start_date = elem(Date.new(2010, 1, 25), 1)
      end_date = elem(Date.new(2010, 3, 3), 1)

      assert CalendarExt.outside?(date, start_date, end_date) == true
    end


    test "returns false if a Date is on the start_date" do
      start_date = elem(Date.new(2010, 1, 25), 1)
      end_date = elem(Date.new(2010, 3, 3), 1)

      assert CalendarExt.outside?(start_date, start_date, end_date) == false
    end

    test "returns false if a Date is on the end_date" do
      start_date = elem(Date.new(2010, 1, 25), 1)
      end_date = elem(Date.new(2010, 3, 3), 1)

      assert CalendarExt.outside?(end_date, start_date, end_date) == false
    end

    test "returns false if a DateTime is before the start_date" do
      date = elem(DateTime.new(Date.utc_today(), Time.utc_now()), 1)

      start_date = DateTime.add(date, 10)
      end_date = DateTime.add(start_date, 10)

      assert CalendarExt.outside?(end_date, start_date, end_date) == false
    end
  end

  describe "to_date" do
    test "returns date for a Date" do
      date = Date.utc_today()
      assert CalendarExt.to_date(date) == date
    end

    test "returns date for a NaiveDateTime" do
      date = NaiveDateTime.utc_now()
      assert CalendarExt.to_date(date) == NaiveDateTime.to_date(date)
    end

    test "returns date for a DateTime" do
      date = DateTime.utc_now()
      assert CalendarExt.to_date(date) == DateTime.to_date(date)
    end

    test "returns nil for nil" do
      assert CalendarExt.to_date(nil) == nil
    end
  end

  describe "max" do
    test "returns left if left is max Date" do
      left = elem(Date.new(2010, 9, 25), 1)
      right = elem(Date.new(2010, 7, 3), 1)

      assert CalendarExt.max(left, right) == left
    end

    test "returns right if right is max Date" do
      left = elem(Date.new(2011, 9, 25), 1)
      right = elem(Date.new(2012, 10, 3), 1)

      assert CalendarExt.max(left, right) == right
    end

    test "returns left if left eq right Date" do
      left = elem(Date.new(2011, 9, 25), 1)
      right = elem(Date.new(2011, 9, 25), 1)

      assert CalendarExt.max(left, right) == left
    end

    test "returns right if right is after left DateTime" do
      left = DateTime.utc_now
      right = DateTime.add(left, 10)

      assert CalendarExt.max(left, right) == right
    end

    test "returns right if right is after left NaiveDateTime" do
      left = NaiveDateTime.utc_now
      right = NaiveDateTime.add(left, 10)

      assert CalendarExt.max(left, right) == right
    end

    test "returns right if right is after left Time" do
      left = Time.utc_now()
      right = Time.add(left, 10)

      assert CalendarExt.max(left, right) == right
    end
  end

  describe "min" do
    test "returns left if left is min Date" do
      left = elem(Date.new(2009, 9, 25), 1)
      right = elem(Date.new(2010, 7, 3), 1)

      assert CalendarExt.min(left, right) == left
    end

    test "returns right if right is min Date" do
      left = elem(Date.new(2011, 9, 25), 1)
      right = elem(Date.new(2010, 10, 3), 1)

      assert CalendarExt.min(left, right) == right
    end

    test "returns left if left eq right Date" do
      left = elem(Date.new(2011, 9, 25), 1)
      right = elem(Date.new(2011, 9, 25), 1)

      assert CalendarExt.min(left, right) == left
    end
  end

  describe "utc_morning" do
    test "it has zeros for hhmmssmm" do
      morning = CalendarExt.utc_morning()

      assert morning.hour == 0
      assert morning.minute == 0
      assert morning.second == 0
      assert {0, _} = morning.microsecond
    end
  end

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

    test "works for DateTime" do
      from_date = Date.utc_today()
      to_date = from_date

      assert CalendarExt.diff_weekdays(to_date, from_date) == 0
    end

    test "works for NaiveDateTime" do
      from_date = NaiveDateTime.utc_now()
      to_date = from_date

      assert CalendarExt.diff_weekdays(to_date, from_date) == 0
    end
  end
end
