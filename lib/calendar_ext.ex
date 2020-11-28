defmodule CalendarExt do
  @doc ~S"""
  Calculates the week number of week days between `from_date` and `to_date`.

  ## Examples

  iex> CalendarExt.diff_weekdays(~D[2020-10-10], ~D[2020-10-20])
  6

  It will return 0 if the second date is in the past

  iex> CalendarExt.diff_weekdays(~D[2020-10-10], ~D[2020-08-20])
  0

  """
  def diff_weekdays(%Date{} = from_date, %Date{} = to_date) do
    saturday = 6

    if Date.diff(to_date, from_date) > 0 do
      Date.range(to_date, from_date)
      |> Enum.reject(fn date -> date == to_date end)
      |> Enum.reduce(0, fn date, acc ->
        acc + if Date.day_of_week(date) < saturday, do: 1, else: 0
      end)
    else
      0
    end
  end
end
