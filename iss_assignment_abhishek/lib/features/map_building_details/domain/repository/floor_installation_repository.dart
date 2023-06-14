import 'package:iss_assignment/core/api_end_points.dart';
import 'package:iss_assignment/core/http_client.dart';
import 'package:iss_assignment/features/map_building_details/domain/data/models/floor_installation_request.dart';

import '../data/models/floor_Installation.dart';

abstract class IFloorInstallationRepository {
  Future<FloorInstallation> getFloorInstallationWith(String floorId);
  Future<FloorInstallation> postFloorInstallationWith(
      String floorId, FloorInstallationRequest request);
}

class FloorInstallationRepository extends IFloorInstallationRepository {
  @override
  Future<FloorInstallation> getFloorInstallationWith(String floorId) async {
    HttpClient httpClient = HttpClient();
    httpClient.initialize();

    final response = await httpClient
        .get(APIEndPoints.baseURL + APIEndPoints.floorInstallation + floorId);
    final floorInstllation = FloorInstallation.fromJson(response);

    return floorInstllation;
  }

  @override
  Future<FloorInstallation> postFloorInstallationWith(
      String floorId, FloorInstallationRequest request) async {
    HttpClient httpClient = HttpClient();
    httpClient.initialize();

    final response = await httpClient.post(
        APIEndPoints.baseURL + APIEndPoints.floorInstallation + floorId,
        body: request.toJson());
    final floorInstllation = FloorInstallation.fromJson(response);

    return floorInstllation;
  }
}
