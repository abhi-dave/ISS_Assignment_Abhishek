// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iss_assignment/features/map_building_details/domain/repository/floor_installation_repository.dart';
import 'package:iss_assignment/features/map_building_details/presentation/cubit/cubit/map_building_details_cubit.dart';
import 'package:iss_assignment/features/qr_code_scanner/data/models/qr_scan_model.dart';
import 'package:iss_assignment/utils/app_constants.dart';
import 'package:iss_assignment/utils/style.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:iss_assignment/features/qr_code_scanner/presentation/cubit/cubit/qr_code_scanner_cubit.dart';
import '../../../map_building_details/presentation/widgets/map_building_details.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({
    Key? key,
  }) : super(key: key);

  @override
  State<QRCodeScanner> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool gotValidQR = false;
  QRScan? result;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(child: BlocBuilder<QrCodeScannerCubit, QrCodeScannerState>(
        builder: (context, state) {
          if (state is QrCodeScannerInitialState) {
            return Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/Background.png',
                        fit: BoxFit.cover)),
                Center(
                    child: Image.asset(
                  'assets/images/qr_code_sample.png',
                  fit: BoxFit.contain,
                )),
              ],
            );
          } else {
            return _buildQrView(context);
          }
        },
      )),
      BlocConsumer<QrCodeScannerCubit, QrCodeScannerState>(
        listener: (context, state) {
          if (state is QrCodeScannerDataFetchedState) {
            gotValidQR = false;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (context) => MapBuildingDetailsCubit(
                              FloorInstallationRepository()),
                          child: MapBuildingDetails(
                            data: state.data,
                          ),
                        ))).then((value) => controller?.resumeCamera());
          } else if (state is QrCodeScannerErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                onVisible: () {
                  gotValidQR = false;
                  controller?.resumeCamera();
                },
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is QrCodeScannerLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            );
          } else {
            return Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.grey.withOpacity(0.38)),
                  height: 150,
                  child: ClipRect(
                    child: BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: AppConstants.blurValue,
                            sigmaY: AppConstants.blurValue),
                        child: Center(
                          child: SizedBox(
                            height: 50.0,
                            width: MediaQuery.of(context).size.width * 0.76,
                            child: ElevatedButton(
                              onPressed: () {
                                context
                                    .read<QrCodeScannerCubit>()
                                    .toggleToQrView();
                              },
                              style: ElevatedButton.styleFrom(
                                  //TODO: Remove Hard Coded Value
                                  backgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              child: Text(
                                AppLocalizations.of(context)!.scan,
                                style: textNormal.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        )),
                  ),
                ));
          }
        },
      )
    ]));
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (gotValidQR) {
        return;
      }
      /*
      {
        \n
        "building": "ISS 2"\n
        "useCase":"FSA"\n
        "uniqueId": "09033927-6a9a-4773-bd89-295c6bfac034"\n
        }

      {
      "building": "ISS HQ"
      "useCase":"FSA"
      "uniqueId": "e6a86043-dde4-4062-8a5c-67f0e856f6ae"
      }

       */
      //TODO: Confirm with the team to get the JSON in correct format.
      String preProccessedId = scanData.code!.split('"uniqueId":').last;
      if (preProccessedId.isNotEmpty) {
        controller.pauseCamera();
        gotValidQR = true;
        String uniqueId = preProccessedId.replaceAll(' ', '');
        uniqueId = uniqueId.replaceAll(RegExp(r'\u007D'), '');
        uniqueId = uniqueId.replaceAll(RegExp(r'\u0022'), '');
        uniqueId = uniqueId.replaceAll(RegExp(r'\u000A'), '');
        context.read<QrCodeScannerCubit>().fetchQrCodeData(uniqueId);
      }
    });
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? AppConstants.scanAreaSmallDevice
        : AppConstants.scanAreaLargeDevice;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderColor: Colors.orange,
              borderRadius: AppConstants.overLayRadius,
              borderLength: AppConstants.overLayLength,
              borderWidth: AppConstants.overLayRadius,
              cutOutSize: scanArea),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ),
      ],
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.permissionTitle)),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
