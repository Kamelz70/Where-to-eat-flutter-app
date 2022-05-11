enum FoodType { FOOD, BEVERAGE }

class ReviewItem {
  final String id;
  final String title;
  final FoodType foodType;
  final double price;
  final double rating;
  final String description;

  const ReviewItem(
      {required this.id,
      required this.title,
      required this.foodType,
      required this.price,
      required this.rating,
      required this.description});
}
