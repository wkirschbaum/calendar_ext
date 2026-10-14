# Changelog

## v0.1.9 (2026-10-14)

- Update development dependencies (`ex_doc` 0.40.3 → 0.40.4, `earmark_parser`
  1.4.45 → 1.4.46, `makeup` 1.2.2 → 1.2.3); no runtime changes
- Update GitHub Actions to their Node 24 versions

## v0.1.8 (2026-07-17)

- Fix `Date.range/2` deprecation warning in `CalendarExt.diff_weekdays/2`
  on Elixir 1.18+ (a negative range was constructed internally; behaviour
  is unchanged)
- Update development dependencies
- Remove dialyxir
- Test against all currently supported Elixir versions (1.16 – 1.20) on
  compatible Erlang/OTP releases (26 – 29), with formatting and
  warnings-as-errors checks in CI
- Rewrite README with usage examples and add this changelog
- Format codebase with `mix format`

## v0.1.7 and earlier

See the [commit history](https://github.com/wkirschbaum/calendar_ext/commits/master).
