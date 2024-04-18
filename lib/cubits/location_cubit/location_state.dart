sealed class LocationState {
  const LocationState();
}

class LocationInitial extends LocationState {
  const LocationInitial();
}

class LocationLoading extends LocationState {
  const LocationLoading();
}

class LocationLoaded extends LocationState {
  final double lat;
  final double lon;

  const LocationLoaded({required this.lat, required this.lon});
}

class LocationError extends LocationState {
  final String message;

  const LocationError({required this.message});
}
