part of 'qr_code_scanner_cubit.dart';

@immutable
abstract class QrCodeScannerState {}

class QrCodeScannerInitialState extends QrCodeScannerState {}

class QrCodeScannerScanningState extends QrCodeScannerState {}

class QrCodeScannerLoadingState extends QrCodeScannerState {}

class QrCodeScannerDataFetchedState extends QrCodeScannerState {
  final QRScanResponse data;

  QrCodeScannerDataFetchedState(this.data);
}

class QrCodeScannerErrorState extends QrCodeScannerState {
  final String error;

  QrCodeScannerErrorState(this.error);
}
