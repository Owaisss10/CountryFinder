// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_tab_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The tab currently on screen, so tab roots can react to being shown
/// (Favorites refreshes).

@ProviderFor(SelectedTab)
final selectedTabProvider = SelectedTabProvider._();

/// The tab currently on screen, so tab roots can react to being shown
/// (Favorites refreshes).
final class SelectedTabProvider extends $NotifierProvider<SelectedTab, AppTab> {
  /// The tab currently on screen, so tab roots can react to being shown
  /// (Favorites refreshes).
  SelectedTabProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedTabProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedTabHash();

  @$internal
  @override
  SelectedTab create() => SelectedTab();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppTab value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppTab>(value),
    );
  }
}

String _$selectedTabHash() => r'e050f019786a32bb9224f3f7fb97b2f172d25d70';

/// The tab currently on screen, so tab roots can react to being shown
/// (Favorites refreshes).

abstract class _$SelectedTab extends $Notifier<AppTab> {
  AppTab build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AppTab, AppTab>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppTab, AppTab>,
              AppTab,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
