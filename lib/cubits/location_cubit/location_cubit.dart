import 'package:dvt_interview/cubits/location_cubit/location_state.dart';
import 'package:dvt_interview/services/location_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationService locationService;

  LocationCubit({required this.locationService})
      : super(const LocationInitial());

  Future<void> getLocation() async {
    try {
      emit(const LocationLoading());
      final locationData = await locationService.getLocation();
      emit(LocationLoaded(
          lat: locationData.latitude!, lon: locationData.longitude!,name: 'Current Location'));
    } on Exception catch (e) {
      emit(LocationError(message: e.toString()));
    }
  }

  setLocation(double lat, double lon, String name) {
    emit(LocationLoaded(lat: lat, lon: lon, name: name));
  }
}
