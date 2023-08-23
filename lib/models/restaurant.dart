class Restaurant {
  final String restaurantName;
  final String phiArea;

  Restaurant({required this.restaurantName, required this.phiArea});

  factory Restaurant.fromJson(Map<String, dynamic> parsedJson) {
    return Restaurant(
      restaurantName: parsedJson['restaurantName'],
      phiArea: parsedJson['phiArea'],
    );
  }
}
