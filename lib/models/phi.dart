class Phi {
  final String phiName;
  final String phiArea;

  Phi({required this.phiName, required this.phiArea});

  factory Phi.fromJson(Map<String, dynamic> parsedJson) {
    return Phi(
      phiName: parsedJson['phiName'],
      phiArea: parsedJson['phiArea'],
    );
  }
}
