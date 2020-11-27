class Restaurant {
  int id;
  String name;
  String city;
  int rating;
  String image;

  Restaurant({this.name, this.city, this.rating, this.image, this.id});
  factory Restaurant.fromJson(dynamic json) {
    return Restaurant(
      name: json['name'] as String,
      city: json['city'] as String,
      rating: json['rating'] as int,
      image: 'tinder.jpg',
      id: json['id'] as int,
    );
  }
}
