class Phi {
  final int phiId;
  final String phiName;
  final String phiRegNo;
  final String phiEmail;
  final String phiContactNo;
  final String phiAddress;
  final String phiArea;

  Phi({
    this.phiId = 0,
    required this.phiName,
    required this.phiRegNo,
    required this.phiEmail,
    required this.phiContactNo,
    required this.phiAddress,
    required this.phiArea,
  });

  factory Phi.fromJson(Map<String, dynamic> parsedJson) {
    return Phi(
      phiId: parsedJson['id'],
      phiName: parsedJson['phiName'],
      phiRegNo: parsedJson['registrationNo'],
      phiEmail: parsedJson['email'],
      phiContactNo: parsedJson['contactNumber'],
      phiAddress: parsedJson['address'],
      phiArea: parsedJson['phiArea'],
    );
  }
}
