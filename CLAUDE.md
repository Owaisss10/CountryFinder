# Flutter project rules

General rules for Flutter apps (iOS and Android). Follow the conventions the
project already uses; don't restructure code toward other conventions unless
asked.

## Architecture

- MVVM with repositories. Widgets read state from Riverpod providers,
  providers talk to repositories, and only repositories touch the network or
  the database.
- Organize `lib/` by layer: `core/`, `models/`, `repositories/`,
  `providers/`, `screens/`, `components/`, `shared/`, `theme/`, `l10n/`.
  `test/` mirrors `lib/`.
- Don't swap libraries the project already depends on (state management,
  routing, networking, storage) for alternatives.
- Handle errors with the project's existing error types; map them to
  user-facing text in the UI, never show raw exceptions.

## Code generation

- Providers use `riverpod_generator` (`@riverpod`); models use freezed +
  json_serializable. After changing either, run
  `dart run build_runner build --delete-conflicting-outputs`.
- If the project commits generated files (`*.g.dart`, `*.freezed.dart`,
  `lib/l10n/gen/`), commit them with the change that produced them.
- After editing an ARB file, run `flutter gen-l10n`.

## Widgets

- Keep widgets small (under ~150 lines including `build`) and compose them
  from named sub-widgets, not nested anonymous closures.
- Split helpers into small private widget classes (`_Header`, `_Body`)
  rather than `Widget _buildHeader()` methods. Classes get `const`
  constructors and keys, rebuild on their own, and read better.
- Default to `StatelessWidget`. Use `StatefulWidget` only for local UI state
  that belongs there: controllers, animations, focus.
- Every constructor that can be `const` is `const`, including small ones like
  `const SizedBox(height: Spacing.large)`.
- `build` is a pure function of its inputs: no side effects, and no logic
  that could run elsewhere (providers, `initState`, helpers).

## UI

- Give every screen a native look on both platforms: branch on a platform
  check from the theme (so debug overrides work), and prefer shared adaptive
  components over per-screen branching.
- No hard-coded colors, spacing or sizes: use the theme's color and text
  tokens and named constants. Add a new named constant when a value is
  needed.
- No hard-coded user-facing text: put it in the ARB file and read it through
  `AppLocalizations`. Use ICU plurals for counts.
- Everything works in light and dark mode.
- Interactive elements have a screen reader label (tooltip or `Semantics`)
  and a tap target of at least 44×44 on iOS and 48×48 on Android.
- Text search ignores case and accents in a way that doesn't depend on the
  device language.

## Code style

- Match the surrounding code: naming, comment density, idioms.
- Keep the lints in `analysis_options.yaml` clean; prefer package imports,
  single quotes, `final` locals, no `print`, no unawaited futures.
- Use `async`/`await` over `.then()` chains. After an `await`, check
  `mounted` / `context.mounted` before using `context` or `ref`.
- Dispose controllers, focus nodes, animation controllers and subscriptions.

## Before finishing a change

- `dart format lib test`
- `flutter analyze` reports no issues.
- `flutter test` passes. Add or update tests for behaviour changes, using
  fakes instead of the network or a real database.
- Update the README when a user-visible feature changes.

## Git

- Work on the development branch, not the release branch.
- Commit only when asked, and never push without being asked.
- No AI co-author or "Generated with" lines in commits or PRs.
