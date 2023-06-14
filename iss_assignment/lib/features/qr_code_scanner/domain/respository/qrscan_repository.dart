import '../../../../core/api_end_points.dart';
import '../../../../core/http_client.dart';
import '../../data/models/qr_scan_response_model.dart';

abstract class IQRScanRepository {
  Future<QRScanResponse> getQRScanData(String uniqueId);
}

class QRScanRepository extends IQRScanRepository {
  @override
  Future<QRScanResponse> getQRScanData(String uniqueId) async {
    HttpClient httpClient = HttpClient();
    httpClient.initialize();

    final response = await httpClient
        .get(APIEndPoints.baseURL + APIEndPoints.qrCodeInstallation + uniqueId);
    final qrScanData = QRScanResponse.fromJson(response);

    return qrScanData;
  }
}
