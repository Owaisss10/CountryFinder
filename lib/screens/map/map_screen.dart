import 'package:country_finder/providers/favorites_provider.dart';
import 'package:country_finder/components/error_view.dart';
import 'package:country_finder/components/floating_panel.dart';
import 'package:country_finder/components/loading_view.dart';
import 'package:country_finder/components/offline_banner.dart';
import 'package:country_finder/core/app_tab.dart';
import 'package:country_finder/core/constants.dart';
import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/models/country.dart';
import 'package:country_finder/providers/countries_list_provider.dart';
import 'package:country_finder/providers/country_map_provider.dart';
import 'package:country_finder/screens/map/basemap_layer.dart';
import 'package:country_finder/screens/map/cluster_marker.dart';
import 'package:country_finder/screens/map/country_marker.dart';
import 'package:country_finder/screens/map/island_dots_layer.dart';
import 'package:country_finder/screens/map/selected_country_card.dart';
import 'package:country_finder/screens/map/zoom_controls.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

/// Every country as a flag pin on a minimal world map drawn by the app
/// itself (no tile server, works offline). Nearby pins group into a counted
/// circle; tapping it zooms in. Tapping a pin shows the country's card, which
/// opens its detail screen.
class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({
    super.key,
    required this.tab,
    required this.countries,
    this.bottomInset = 0,
  });

  /// The tab hosting the map; tapped countries open in its stack.
  final AppTab tab;

  /// The countries to pin, e.g. search results or favorites.
  final List<Country> countries;

  /// Room to leave under the selected country's card, for controls the
  /// host floats over the bottom of the map.
  final double bottomInset;

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen>
    with SingleTickerProviderStateMixin {
  final _mapController = MapController();
  final _cardKey = GlobalKey();

  // The pan in progress that moves a selected pin out from under its card.
  late final AnimationController _pan;
  LatLng? _panFrom;
  LatLng? _panTo;

  @override
  void initState() {
    super.initState();
    _pan = AnimationController(vsync: this, duration: AppAnimation.mapPan)
      ..addListener(_onPanTick);
    // Like the list tabs: load the countries if nothing has loaded yet.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (ref.read(countriesListProvider).countries.isEmpty) {
        ref.read(countriesListProvider.notifier).load();
      }
    });
  }

  @override
  void dispose() {
    _pan.dispose();
    _mapController.dispose();
    super.dispose();
  }

  void _onPanTick() {
    final (from, to) = (_panFrom, _panTo);
    if (from == null || to == null) return;
    final t = Curves.easeOut.transform(_pan.value);
    _mapController.move(
      LatLng(
        from.latitude + (to.latitude - from.latitude) * t,
        from.longitude + (to.longitude - from.longitude) * t,
      ),
      _mapController.camera.zoom,
    );
  }

  void _onPinTap(MapPin pin) {
    ref
        .read(mapSelectionProvider(widget.tab).notifier)
        .select(pin.country.alpha3Code);
    // The card appears in the next frame; then make sure it isn't covering
    // the pin.
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _keepAboveCard(pin.point),
    );
  }

  /// Pans the map up just enough that the pin's tip sits above its card.
  void _keepAboveCard(LatLng point) {
    if (!mounted) return;
    final card = _cardKey.currentContext?.findRenderObject();
    final screen = context.findRenderObject();
    if (card is! RenderBox || screen is! RenderBox) return;
    final cardTop = screen.globalToLocal(card.localToGlobal(Offset.zero)).dy;
    final camera = _mapController.camera;
    final overlap =
        camera.latLngToScreenOffset(point).dy -
        (cardTop - MapStyle.pinRevealMargin);
    if (overlap <= 0) return;
    // Moving the camera's centre down by the overlap moves the map up.
    final target = camera.screenOffsetToLatLng(
      camera.nonRotatedSize.center(Offset.zero) + Offset(0, overlap),
    );
    if (MediaQuery.disableAnimationsOf(context)) {
      _mapController.move(target, camera.zoom);
      return;
    }
    _panFrom = camera.center;
    _panTo = target;
    _pan.forward(from: 0);
  }

  /// One marker per pin, drawn bottom to top: other pins, favorites, then
  /// the selected pin, so a star badge or the selection is never hidden by a
  /// neighbour.
  List<Marker> _markers(
    List<MapPin> pins,
    String? selectedCode,
    Set<String> favorites,
  ) {
    int layerOf(MapPin pin) => switch (pin.country.alpha3Code) {
      final code when code == selectedCode => 2,
      final code when favorites.contains(code) => 1,
      _ => 0,
    };
    return [
      for (final layer in const [0, 1, 2])
        for (final pin in pins.where((pin) => layerOf(pin) == layer))
          Marker(
            key: ValueKey(pin.country.alpha3Code),
            point: pin.point,
            width: CountryMarker.width,
            height: CountryMarker.height,
            // The whole pin sits above its point, so the pointer's tip marks it.
            alignment: Alignment.topCenter,
            child: CountryMarker(
              key: ValueKey('map-marker-${pin.country.alpha3Code}'),
              country: pin.country,
              selected: pin.country.alpha3Code == selectedCode,
              favorite: favorites.contains(pin.country.alpha3Code),
              onTap: () => _onPinTap(pin),
            ),
          ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final selectedCode = ref.watch(mapSelectionProvider(widget.tab));
    final selection = ref.read(mapSelectionProvider(widget.tab).notifier);
    final shown = {for (final c in widget.countries) c.alpha3Code};
    final pins = ref
        .watch(mapPinsProvider)
        .where((pin) => shown.contains(pin.country.alpha3Code))
        .toList();
    final favorites = ref.watch(favoritesProvider.select((s) => s.codes));
    // Only while its pin is on this map (a search may have hidden it).
    final selected = ref.watch(selectedMapCountryProvider(widget.tab));
    final selectedHere = selected != null && shown.contains(selected.alpha3Code)
        ? selected
        : null;

    final markers = _markers(pins, selectedCode, favorites);

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: const LatLng(
              MapStyle.initialLatitude,
              MapStyle.initialLongitude,
            ),
            initialZoom: MapStyle.initialZoom,
            minZoom: MapStyle.minZoom,
            maxZoom: MapStyle.maxZoom,
            // The sea; the basemap draws the land on top.
            backgroundColor: AppColors.of(context).mapWater,
            // Keeps the map from scrolling past the poles.
            cameraConstraint: const CameraConstraint.containLatitude(),
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
            onTap: (_, _) => selection.clearSelection(),
          ),
          children: [
            // Under the land, so only dots for islands too small to see show.
            const IslandDotsLayer(),
            const BasemapLayer(),
            MarkerClusterLayerWidget(
              options: MarkerClusterLayerOptions(
                markers: markers,
                size: const Size.square(MapStyle.clusterSize),
                maxClusterRadius: MapStyle.clusterRadius,
                showPolygon: false,
                builder: (context, markers) => ClusterMarker(
                  count: markers.length,
                  hasFavorite: markers.any(
                    (marker) => favorites.contains(_codeOf(marker)),
                  ),
                ),
              ),
            ),
            const ZoomControls(),
          ],
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(Spacing.large),
              child: _OfflineNotice(),
            ),
          ),
        ),
        const _StatusPanel(),
        if (selectedHere case final selected?)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              // Leaves the bottom-right corner to the zoom buttons.
              padding: EdgeInsets.fromLTRB(
                Spacing.large,
                0,
                Spacing.large + MapStyle.zoomButtonSize + Spacing.small,
                Spacing.large + widget.bottomInset,
              ),
              child: SelectedCountryCard(
                key: _cardKey,
                country: selected,
                onOpen: () =>
                    context.push(widget.tab.detailPath(selected.alpha3Code)),
              ),
            ),
          ),
      ],
    );
  }
}

/// The country code a marker was keyed with in [_MapScreenState._markers].
String? _codeOf(Marker marker) => switch (marker.key) {
  ValueKey<String>(:final value) => value,
  _ => null,
};

/// The offline banner, shown when the pins come from saved data.
class _OfflineNotice extends ConsumerWidget {
  const _OfflineNotice();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOffline = ref.watch(
      countriesListProvider.select((s) => s.isOffline),
    );
    if (!isOffline) return const SizedBox.shrink();
    return ClipRRect(
      borderRadius: BorderRadius.circular(CornerRadius.large),
      child: OfflineBanner(
        cacheDate: ref.watch(countriesListProvider.select((s) => s.cacheDate)),
        onRetry: ref.read(countriesListProvider.notifier).retry,
      ),
    );
  }
}

/// Loading or error message over the map, until the countries have loaded.
class _StatusPanel extends ConsumerWidget {
  const _StatusPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final viewState = ref.watch(
      countriesListProvider.select((s) => s.viewState),
    );
    final hasCountries = ref.watch(
      countriesListProvider.select((s) => s.countries.isNotEmpty),
    );
    final Widget? message = switch (viewState) {
      ViewLoading() when !hasCountries => LoadingView(
        message: l10n.loadingCountries,
      ),
      ViewFailed(:final error) when !hasCountries => ErrorView(
        message: error.message(l10n),
        onRetry: ref.read(countriesListProvider.notifier).retry,
      ),
      _ => null,
    };
    if (message == null) return const SizedBox.shrink();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.large),
        // The state views center themselves; IntrinsicHeight keeps the panel
        // as tall as its content instead of the whole screen.
        child: FloatingPanel(child: IntrinsicHeight(child: message)),
      ),
    );
  }
}
