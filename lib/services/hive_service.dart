import 'package:hive/hive.dart';

class HiveFavoritesService {
  final box = Hive.box('favorites');

  List getFavorites() {
    return box.values.toList();
  }

  void addFavorite(Map<String, dynamic> id) {
    box.put(id['name'], id);
  }

  void removeFavorite(Map<String, dynamic> id) {
    box.delete(id['name']);
  }
}
