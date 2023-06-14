import 'package:latlong2/latlong.dart';

class QRScanResponse {
  int? buildingID;
  String? buildingName;
  int? floorID;
  String? floorName;
  int? floorLevel;
  UserLocation? userLocation;
  Floorplan? floorplan;

  QRScanResponse(
      {this.buildingID,
      this.buildingName,
      this.floorID,
      this.floorName,
      this.floorLevel,
      this.userLocation,
      this.floorplan});

  QRScanResponse.fromJson(Map<String, dynamic> json) {
    buildingID = json['buildingID'];
    buildingName = json['buildingName'];
    floorID = json['floorID'];
    floorName = json['floorName'];
    floorLevel = json['floorLevel'];
    userLocation = json['userLocation'] != null
        ? new UserLocation.fromJson(json['userLocation'])
        : null;
    floorplan = json['floorplan'] != null
        ? new Floorplan.fromJson(json['floorplan'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buildingID'] = this.buildingID;
    data['buildingName'] = this.buildingName;
    data['floorID'] = this.floorID;
    data['floorName'] = this.floorName;
    data['floorLevel'] = this.floorLevel;
    if (this.userLocation != null) {
      data['userLocation'] = this.userLocation!.toJson();
    }
    if (this.floorplan != null) {
      data['floorplan'] = this.floorplan!.toJson();
    }
    return data;
  }
}

class UserLocation {
  double? lat;
  double? long;

  UserLocation({this.lat, this.long});

  UserLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }

  LatLng toLntLng() {
    return LatLng(this.lat!, this.long!);
  }
}

class Floorplan {
  String? imageURL;
  Boundaries? boundaries;

  Floorplan({this.imageURL, this.boundaries});

  Floorplan.fromJson(Map<String, dynamic> json) {
    imageURL = json['imageURL'];
    boundaries = json['boundaries'] != null
        ? new Boundaries.fromJson(json['boundaries'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageURL'] = this.imageURL;
    if (this.boundaries != null) {
      data['boundaries'] = this.boundaries!.toJson();
    }
    return data;
  }
}

class Boundaries {
  UserLocation? topLeft;
  UserLocation? bottomLeft;
  UserLocation? topRight;

  Boundaries({this.topLeft, this.bottomLeft, this.topRight});

  Boundaries.fromJson(Map<String, dynamic> json) {
    topLeft = json['topLeft'] != null
        ? new UserLocation.fromJson(json['topLeft'])
        : null;
    bottomLeft = json['bottomLeft'] != null
        ? new UserLocation.fromJson(json['bottomLeft'])
        : null;
    topRight = json['topRight'] != null
        ? new UserLocation.fromJson(json['topRight'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topLeft != null) {
      data['topLeft'] = this.topLeft!.toJson();
    }
    if (this.bottomLeft != null) {
      data['bottomLeft'] = this.bottomLeft!.toJson();
    }
    if (this.topRight != null) {
      data['topRight'] = this.topRight!.toJson();
    }
    return data;
  }
}
