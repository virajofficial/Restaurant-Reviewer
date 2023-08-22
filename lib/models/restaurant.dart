class Restaurant {
  final String name;
  final String address;

  Restaurant({required this.name, required this.address});

  factory Restaurant.fromJson(Map<String, dynamic> parsedJson) {
    return Restaurant(
      name: parsedJson['name'],
      address: parsedJson['address'],
    );
  }
}
