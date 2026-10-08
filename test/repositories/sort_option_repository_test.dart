import 'package:country_finder/models/sort_option.dart';
import 'package:country_finder/repositories/sort_option_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('defaults, then round-trips through the sortOption key', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final repo = SharedPrefsSortOptionRepository(prefs);
    expect(repo.load(), SortOption.defaultOption);

    const option = SortOption(
      field: SortField.area,
      direction: SortDirection.descending,
    );
    await repo.save(option);
    expect(prefs.getString('sortOption'), isNotNull);
    expect(SharedPrefsSortOptionRepository(prefs).load(), option);
  });

  test('an unreadable value falls back to the default', () async {
    SharedPreferences.setMockInitialValues({'sortOption': '{"field":"x"}'});
    final prefs = await SharedPreferences.getInstance();
    expect(
      SharedPrefsSortOptionRepository(prefs).load(),
      SortOption.defaultOption,
    );
  });
}
