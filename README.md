# CalendarExt

[![Test](https://github.com/wkirschbaum/calendar_ext/actions/workflows/test.yml/badge.svg)](https://github.com/wkirschbaum/calendar_ext/actions/workflows/test.yml)
[![Hex.pm](https://img.shields.io/hexpm/v/calendar_ext.svg)](https://hex.pm/packages/calendar_ext)
[![Hexdocs.pm](https://img.shields.io/badge/hexdocs-docs-8e7ce6.svg)](https://hexdocs.pm/calendar_ext)

Additional functions for `Date`, `Time`, `DateTime` and `NaiveDateTime`.

## Installation

Add `calendar_ext` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:calendar_ext, "~> 0.1"}
  ]
end
```

## Usage

Count the weekdays between two dates (the start date is included, the end
date is not; returns `0` when the second date is not after the first):

```elixir
iex> CalendarExt.diff_weekdays(~D[2020-10-10], ~D[2020-10-20])
6
```

Pick the earliest or latest of two `Date`, `Time`, `DateTime` or
`NaiveDateTime` values:

```elixir
iex> CalendarExt.min(~D[2020-01-01], ~D[2020-06-01])
~D[2020-01-01]

iex> CalendarExt.max(~T[09:00:00], ~T[17:00:00])
~T[17:00:00]
```

Check whether a date falls outside a range (inclusive of both endpoints):

```elixir
iex> CalendarExt.outside?(~D[2021-05-01], ~D[2021-01-01], ~D[2021-03-01])
true
```

Convert to a `Date`, passing `nil` through:

```elixir
iex> CalendarExt.to_date(~N[2020-12-18 22:28:36])
~D[2020-12-18]

iex> CalendarExt.to_date(nil)
nil
```

Get the start of today as a `NaiveDateTime`:

```elixir
iex> CalendarExt.utc_morning()
~N[2026-07-17 00:00:00.000000]
```

Parse ISO 8601 datetime strings that may have a missing offset or an
invalid time such as `24:28:36` (hours wrap into the next day):

```elixir
iex> CalendarExt.to_naive_with_invalid_time("2020-12-18T22:28:36")
~N[2020-12-18 22:28:36]

iex> CalendarExt.to_naive_with_invalid_time("2020-12-18T24:28:36")
~N[2020-12-19 00:28:36]
```

Full documentation is available at
[https://hexdocs.pm/calendar_ext](https://hexdocs.pm/calendar_ext).

## Supported versions

Tested against all currently supported Elixir versions (1.16 through 1.20)
on compatible Erlang/OTP releases (26 through 29).

## License

MIT — see [LICENSE](LICENSE).
