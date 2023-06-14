class FloorInstallationRequest {
  int? newConfrimedInstallations;

  FloorInstallationRequest({this.newConfrimedInstallations});

  FloorInstallationRequest.fromJson(Map<String, dynamic> json) {
    newConfrimedInstallations = json['newConfrimedInstallations'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['newConfrimedInstallations'] = newConfrimedInstallations;
    return data;
  }
}
