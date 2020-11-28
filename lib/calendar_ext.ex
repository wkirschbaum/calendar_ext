defmodule CalendarExt do
  alias CalendarExt.Comparible

  @type dateable :: Date.t() | DateTime.t() | NaiveDateTime.t()

  @doc ~S"""
  Converts dateable to %Date{}. It will return nil for nil values.
  """
  @spec to_date(dateable) :: Date.t()
  def to_date(%Date{} = date), do: date
  def to_date(%DateTime{} = date), do: DateTime.to_date(date)
  def to_date(%NaiveDateTime{} = date), do: NaiveDateTime.to_date(date)
  def to_date(nil), do: nil

  @doc ~S"""
  Calculates the week number of week days between `from_date` and `to_date`.

  ## Examples

  iex> CalendarExt.diff_weekdays(~D[2020-10-10], ~D[2020-10-20])
  6

  It will return 0 if the second date is in the past

  iex> CalendarExt.diff_weekdays(~D[2020-10-10], ~D[2020-08-20])
  0
  """
  @spec diff_weekdays(dateable(), dateable()) :: integer
  def diff_weekdays(%DateTime{} = from_date, %DateTime{} = to_date) do
    diff_weekdays(
      DateTime.to_date(from_date),
      DateTime.to_date(to_date)
    )
  end

  def diff_weekdays(%NaiveDateTime{} = from_date, %NaiveDateTime{} = to_date) do
    diff_weekdays(
      NaiveDateTime.to_date(from_date),
      NaiveDateTime.to_date(to_date)
    )
  end

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
  @spec min(Comparible.t(), Comparible.t()) :: Comparible.t()
  def min(left, right) do
    case Comparible.compare(left, right) do
      :lt -> left
      _ -> right
    end
  end

  @doc ~S"""
  Returns the earliest date.
  """
  @spec max(Comparible.t(), Comparible.t()) :: Comparible.t()
  def max(left, right) do
    case Comparible.compare(left, right) do
      :gt -> left
      _ -> right
    end
  end

  @spec outside?(Comparible.t(), Comparible.t(), Comparible.t()) :: true | false
  def outside?(date, start_date, end_date) do
    Comparible.compare(date, start_date) == :lt || Comparible.compare(date, end_date) == :gt
  end
end
