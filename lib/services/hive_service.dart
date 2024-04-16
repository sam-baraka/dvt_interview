import 'package:hive/hive.dart';

class HiveFavoritesService {
  final box = Hive.box('favorites');

  Future<List> getFavorites() async {
    await Hive.openBox('favorites');
    return Future.value(box.values.toList());
  }

  void addFavorite(Map<String, dynamic> id) async {
    await Hive.openBox('favorites');
    box.put(id['name'], id);
  }

  void removeFavorite(Map<String, dynamic> id) async {
    await Hive.openBox('favorites');
    box.delete(id['name']);
  }
}
