// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CountryDetail)
final countryDetailProvider = CountryDetailFamily._();

final class CountryDetailProvider
    extends $NotifierProvider<CountryDetail, CountryDetailState> {
  CountryDetailProvider._({
    required CountryDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'countryDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$countryDetailHash();

  @override
  String toString() {
    return r'countryDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CountryDetail create() => CountryDetail();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CountryDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CountryDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CountryDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$countryDetailHash() => r'c1a603437ca496c4652763f52b0b2c3b724c5ae0';

final class CountryDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          CountryDetail,
          CountryDetailState,
          CountryDetailState,
          CountryDetailState,
          String
        > {
  CountryDetailFamily._()
    : super(
        retry: null,
        name: r'countryDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CountryDetailProvider call(String alpha3Code) =>
      CountryDetailProvider._(argument: alpha3Code, from: this);

  @override
  String toString() => r'countryDetailProvider';
}

abstract class _$CountryDetail extends $Notifier<CountryDetailState> {
  late final _$args = ref.$arg as String;
  String get alpha3Code => _$args;

  CountryDetailState build(String alpha3Code);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CountryDetailState, CountryDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CountryDetailState, CountryDetailState>,
              CountryDetailState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
