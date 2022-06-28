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
  final int reviewsCount;
  final double? serviceRating;
  final double? tasteRating;
  final double? costRating;
  final double? quantityRating;
  final double? totalRating;

  Branch({
    required this.id,
    required this.location,
    required this.reviewsCount,
    this.tasteRating,
    this.costRating,
    this.quantityRating,
    this.totalRating,
    this.serviceRating,
    this.restaurantId,
  });
}
