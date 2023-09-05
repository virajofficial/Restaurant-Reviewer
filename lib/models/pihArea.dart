class PhiArea {
  final List<String> phiAreas;

  PhiArea({required this.phiAreas});

  factory PhiArea.fromJson(Map<String, dynamic> json) {
    return PhiArea(phiAreas: json['locations']);
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['url'] = this.url;
  //   data['token'] = this.token;
  //   data['id'] = this.id;
  //   return data;
  // }
}
