defprotocol CalendarExt.Comparible do
  @spec compare(t, t) :: :lt | :eq | :gt
  def compare(comparible, comparible)
end

defimpl CalendarExt.Comparible, for: Date  do
  def compare(%Date{} = left, %Date{} = right) do
    Date.compare(left, right)
  end
end

defimpl CalendarExt.Comparible, for: DateTime  do
  def compare(%DateTime{} = left, %DateTime{} = right) do
    DateTime.compare(left, right)
  end
end

defimpl CalendarExt.Comparible, for: NaiveDateTime  do
  def compare(%NaiveDateTime{} = left, %NaiveDateTime{} = right) do
    NaiveDateTime.compare(left, right)
  end
end

defimpl CalendarExt.Comparible, for: Time  do
  def compare(%Time{} = left, %Time{} = right) do
    Time.compare(left, right)
  end
end
