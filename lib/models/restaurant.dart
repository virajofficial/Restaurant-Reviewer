class Restaurant {
  final int resId;
  final String resName;
  final String resRegNo;
  final String resContactNo;
  final String resRegDate;
  final String resAddress;
  final String resPhiArea;

  Restaurant({
    this.resId = 0,
    required this.resName,
    required this.resRegNo,
    required this.resContactNo,
    required this.resRegDate,
    required this.resAddress,
    required this.resPhiArea,
  });

  factory Restaurant.fromJson(Map<String, dynamic> parsedJson) {
    return Restaurant(
      resId: parsedJson['id'],
      resName: parsedJson['restaurantName'],
      resRegNo: parsedJson['registrationNo'],
      resContactNo: parsedJson['contactNumber'],
      resRegDate: parsedJson['registrationDate'],
      resAddress: parsedJson['address'],
      resPhiArea: parsedJson['phiArea'],
    );
  }
}
