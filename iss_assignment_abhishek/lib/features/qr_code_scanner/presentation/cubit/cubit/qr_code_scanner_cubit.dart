import 'package:bloc/bloc.dart';
import 'package:iss_assignment/features/qr_code_scanner/data/models/qr_scan_response_model.dart';
import 'package:iss_assignment/features/qr_code_scanner/domain/respository/qrscan_repository.dart';
import 'package:meta/meta.dart';

part 'qr_code_scanner_state.dart';

class QrCodeScannerCubit extends Cubit<QrCodeScannerState> {
  final IQRScanRepository repository;

  QrCodeScannerCubit(this.repository) : super(QrCodeScannerInitialState());

  void toggleToQrView() {
    emit(QrCodeScannerScanningState());
  }

  Future<void> fetchQrCodeData(String uniqueId) async {
    emit(QrCodeScannerLoadingState());

    try {
      QRScanResponse data = await repository.getQRScanData(uniqueId);
      emit(QrCodeScannerDataFetchedState(data));
    } catch (error) {
      if (error is TypeError) {
        emit(QrCodeScannerErrorState('Error: Invalid QR Code!'));
      } else {
        emit(QrCodeScannerErrorState('Error: $error'));
      }
    }
  }
}
