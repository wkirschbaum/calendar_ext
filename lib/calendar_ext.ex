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
  @spec diff_weekdays(Date.t(), Date.t()) :: integer
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

  @doc ~S"""
  Returns the morning of NaiveDateTime.utc_now().
  """
  @spec utc_morning() :: NaiveDateTime.t()
  def utc_morning() do
    %{microsecond: {_, precision}} = datetime = NaiveDateTime.utc_now()

    %{datetime | :hour => 0, :minute => 0, :second => 0, :microsecond => {0, precision}}
  end

  @type calendar_ext :: Date.t() | DateTime.t() | NaiveDateTime.t()

  @doc ~S"""
  Returns the latest date
  """
  @spec min(calendar_ext, calendar_ext) :: calendar_ext
  def min(%Date{} = left, %Date{} = right) do
    case Date.compare(left, right) do
      :lt -> left
      _ -> right
    end
  end

  # def max(%DateTime{} = left, %DateTime{} = right) do
  #   case DateTime.compare(left, right) do
  #     :lt -> right
  #     _ -> left
  #   end
  # end

  # def max(%NaiveDateTime{} = left, %NaiveDateTime{} = right) do
  #   case NaiveDateTime.compare(left, right) do
  #     :lt -> right
  #     _ -> left
  #   end
  # end

  @doc ~S"""
  Returns the earliest date.
  """
  @spec max(calendar_ext, calendar_ext) :: calendar_ext
  def max(%Date{} = left, %Date{} = right) do
    case Date.compare(left, right) do
      :gt -> left
      _ -> right
    end
  end
end
