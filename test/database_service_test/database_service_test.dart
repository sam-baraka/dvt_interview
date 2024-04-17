import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dvt_interview/services/firestore_service.dart';
import 'package:dvt_interview/services/favorites_service.dart';

class MockFirestoreService extends Mock implements FirestoreService {
  @override
  Future<void> addData(String collection, Map<String, dynamic> data) {
    return super.noSuchMethod(Invocation.method(#addData, [collection, data]),
        returnValue: Future.value());
  }

  @override
  Future<QuerySnapshot> getData(String collection) {
    return super.noSuchMethod(Invocation.method(#getData, [collection]),
        returnValue: Future.value(QuerySnapshot));
  }
}

void main() {
  group('FavoritesService', () {
    late FavoritesService favoritesService;
    late MockFirestoreService mockFirestoreService;

    setUp(() {
      mockFirestoreService = MockFirestoreService();
      favoritesService =
          FavoritesService(firestoreService: mockFirestoreService);
    });

    test('addFavorite should call addData on FirestoreService', () async {
      const userId = 'user1';
      const productId = 'product1';

      when(mockFirestoreService.addData('favorites', {
        'userId': userId,
        'productId': productId,
      })).thenAnswer((_) async => {});

      await favoritesService.addFavorite(userId, productId);

      verify(mockFirestoreService.addData('favorites', {
        'userId': userId,
        'productId': productId,
      })).called(1);
    });
  });
}
