class Profile {
  String id;
  String name;
  String imageUrl;
  int followersCount;
  int followingCount;
  int reviewsCount;
  bool isFollowed;

  Profile({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.followersCount,
    required this.followingCount,
    required this.reviewsCount,
    this.isFollowed = false,
  });
}
