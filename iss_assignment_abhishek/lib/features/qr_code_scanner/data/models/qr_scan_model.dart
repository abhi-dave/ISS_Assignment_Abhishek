class QRScan {
  String? building;
  String? useCase;
  String? uniqueId;

  QRScan({this.building, this.useCase, this.uniqueId});

  QRScan.fromJson(Map<String, dynamic> json) {
    building = json['building'];
    useCase = json['useCase'];
    uniqueId = json['uniqueId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['building'] = this.building;
    data['useCase'] = this.useCase;
    data['uniqueId'] = this.uniqueId;
    return data;
  }
}
