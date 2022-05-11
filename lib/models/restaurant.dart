// ignore_for_file: constant_identifier_names

enum Complexity { Simple, Challenging, Hard }
enum Affordability { Affordable, Pricey, Luxurious }

class Restaurant {
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final double serviceRating;
  final double tasteRating;
  final double costRating;
  final double quantityRating;

  const Restaurant({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.serviceRating,
    required this.tasteRating,
    required this.costRating,
    required this.quantityRating,
  });
}
