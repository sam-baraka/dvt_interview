import 'package:dvt_interview/services/location_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:mockito/mockito.dart';

class MockLocation extends Mock implements Location {
  @override
  Future<bool> serviceEnabled() =>
      super.noSuchMethod(Invocation.method(#serviceEnabled, []),
          returnValue: Future.value(true),
          returnValueForMissingStub: Future.value(true));

  @override
  Future<bool> requestService() =>
      super.noSuchMethod(Invocation.method(#requestService, []),
          returnValue: Future.value(true),
          returnValueForMissingStub: Future.value(true));

  @override
  Future<PermissionStatus> hasPermission() =>
      super.noSuchMethod(Invocation.method(#hasPermission, []),
          returnValue: Future.value(PermissionStatus.granted),
          returnValueForMissingStub: Future.value(PermissionStatus.granted));

  @override
  Future<PermissionStatus> requestPermission() =>
      super.noSuchMethod(Invocation.method(#requestPermission, []),
          returnValue: Future.value(PermissionStatus.granted),
          returnValueForMissingStub: Future.value(PermissionStatus.granted));

  @override
  Future<LocationData> getLocation() =>
      super.noSuchMethod(Invocation.method(#getLocation, []),
          returnValue: Future.value(LocationData.fromMap({
            'latitude': 37.7749,
            'longitude': -122.4194,
          })),
          returnValueForMissingStub: Future.value(LocationData.fromMap({
            'latitude': 37.7749,
            'longitude': -122.4194,
          })));
}

void main() {
  group('LocationService', () {
    late LocationService locationService;
    late MockLocation mockLocation;

    setUp(() {
      mockLocation = MockLocation();
      locationService = LocationService(location: mockLocation);
    });

    test(
        'should get location when service is enabled and permission is granted',
        () async {
      when(mockLocation.serviceEnabled()).thenAnswer((_) async => true);
      when(mockLocation.hasPermission())
          .thenAnswer((_) async => PermissionStatus.granted);
      when(mockLocation.getLocation())
          .thenAnswer((_) async => LocationData.fromMap({
                'latitude': 37.7749,
                'longitude': -122.4194,
              }));

      final locationData = await locationService.getLocation();

      expect(locationData.latitude, equals(37.7749));
      expect(locationData.longitude, equals(-122.4194));
    });

    test('should request service when service is not enabled', () async {
      when(mockLocation.serviceEnabled()).thenAnswer((_) async => false);
      when(mockLocation.requestService()).thenAnswer((_) async => true);
      when(mockLocation.hasPermission())
          .thenAnswer((_) async => PermissionStatus.granted);
      when(mockLocation.getLocation())
          .thenAnswer((_) async => LocationData.fromMap({
                'latitude': 37.7749,
                'longitude': -122.4194,
              }));

      final locationData = await locationService.getLocation();

      expect(locationData.latitude, equals(37.7749));
      expect(locationData.longitude, equals(-122.4194));
    });

    test(
        'should throw exception when service is not enabled and cannot be requested',
        () async {
      when(mockLocation.serviceEnabled()).thenAnswer((_) async => false);
      when(mockLocation.requestService()).thenAnswer((_) async => false);

      expect(() async => await locationService.getLocation(), throwsException);
    });

    test('should request permission when permission is denied', () async {
      when(mockLocation.serviceEnabled()).thenAnswer((_) async => true);
      when(mockLocation.hasPermission())
          .thenAnswer((_) async => PermissionStatus.denied);
      when(mockLocation.requestPermission())
          .thenAnswer((_) async => PermissionStatus.granted);
      when(mockLocation.getLocation())
          .thenAnswer((_) async => LocationData.fromMap({
                'latitude': 37.7749,
                'longitude': -122.4194,
              }));

      final locationData = await locationService.getLocation();

      expect(locationData.latitude, equals(37.7749));
      expect(locationData.longitude, equals(-122.4194));
    });

    test(
        'should throw exception when permission is denied and cannot be granted',
        () async {
      when(mockLocation.serviceEnabled()).thenAnswer((_) async => true);
      when(mockLocation.hasPermission())
          .thenAnswer((_) async => PermissionStatus.denied);
      when(mockLocation.requestPermission())
          .thenAnswer((_) async => PermissionStatus.deniedForever);

      expect(() async => await locationService.getLocation(), throwsException);
    });
  });
}
