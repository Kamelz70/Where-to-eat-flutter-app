class PlaceLocation {
  final double? latitude;
  final double? longitude;
  final String address;
  const PlaceLocation({this.latitude, this.longitude, required this.address});
}

class Branch {
  final String id;
  final String? restaurantId;
  final PlaceLocation location;

  Branch({
    required this.id,
    this.restaurantId,
    required this.location,
  });
}
