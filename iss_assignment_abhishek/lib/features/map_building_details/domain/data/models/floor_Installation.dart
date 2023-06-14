class FloorInstallation {
  int? floodID;
  int? pending;
  int? done;

  FloorInstallation({this.floodID, this.pending, this.done});

  FloorInstallation.fromJson(Map<String, dynamic> json) {
    floodID = json['floodID'];
    pending = json['pending'];
    done = json['done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['floodID'] = floodID;
    data['pending'] = pending;
    data['done'] = done;
    return data;
  }
}
