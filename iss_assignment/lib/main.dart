import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:iss_assignment/features/qr_code_scanner/presentation/cubit/cubit/qr_code_scanner_cubit.dart';
import 'package:iss_assignment/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iss_assignment/utils/app_color.dart';
import 'package:iss_assignment/utils/app_constants.dart';

import 'features/qr_code_scanner/domain/respository/qrscan_repository.dart';
import 'features/qr_code_scanner/presentation/widgets/qr_code_scanner.dart';

void main() {
  runApp(const ISSApp());
}

class ISSApp extends StatelessWidget {
  const ISSApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.AppName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.lightBlack),
        useMaterial3: true,
      ),
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: BlocProvider(
        create: (_) => QrCodeScannerCubit(QRScanRepository()),
        child: const QRCodeScanner(),
      ),
    );
  }
}
