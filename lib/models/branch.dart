class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;
  const PlaceLocation(
      {required this.latitude, required this.longitude, this.address = ''});
}

class Branch {
  final String id;
  final String restaurantId;
  final PlaceLocation location;

  Branch({
    required this.id,
    required this.restaurantId,
    required this.location,
  });
}
