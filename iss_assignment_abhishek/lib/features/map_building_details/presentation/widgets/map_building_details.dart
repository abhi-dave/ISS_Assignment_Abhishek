import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iss_assignment/features/qr_code_scanner/data/models/qr_scan_response_model.dart';
import 'package:iss_assignment/utils/app_color.dart';
import 'package:iss_assignment/utils/app_constants.dart';
import 'package:iss_assignment/utils/style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/cubit/map_building_details_cubit.dart';
import 'map_building_widget.dart';

class MapBuildingDetails extends StatefulWidget {
  final QRScanResponse data;
  const MapBuildingDetails({super.key, required this.data});

  @override
  State<MapBuildingDetails> createState() => _MapBuildingDetailsState();
}

class _MapBuildingDetailsState extends State<MapBuildingDetails> {
  @override
  void initState() {
    super.initState();
    context
        .read<MapBuildingDetailsCubit>()
        .fetchFloorInstallationData((widget.data.floorID ?? 0).toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: false,
          child: Stack(
            children: [
              MapBuildingWidget(
                data: widget.data,
              ),
              Positioned(
                height: AppConstants.sheetHeight,
                width: MediaQuery.of(context).size.width,
                bottom: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(AppConstants.radiusCircle),
                          topRight: Radius.circular(AppConstants.radiusCircle)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.35),
                            spreadRadius: 0,
                            blurRadius: AppConstants.radiusCircle,
                            offset: Offset(0, -5))
                      ]),
                  child: BlocBuilder<MapBuildingDetailsCubit,
                      MapBuildingDetailsState>(
                    builder: (context, state) {
                      if (state is MapBuildingDetailsFetchedState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    AppConstants.insetValue16,
                                    AppConstants.insetValue30,
                                    AppConstants.insetValue16,
                                    AppConstants.insetValue8,
                                  ),
                                  child: Text(widget.data.buildingName ?? "",
                                      style: textNormal),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      AppConstants.insetValue8,
                                      AppConstants.insetValue30,
                                      AppConstants.insetValue16,
                                      AppConstants.insetValue16),
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    child: FloatingActionButton(
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.1),
                                      shape: CircleBorder(),
                                      elevation: 1.0,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      AppConstants.insetValue16,
                                      0.0,
                                      AppConstants.insetValue16,
                                      0.0),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .floorName(widget.data.floorName),
                                    style: textNormal.copyWith(
                                        color: AppColor.blackOne, fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      AppConstants.insetValue16,
                                      0.0,
                                      AppConstants.insetValue16,
                                      0.0),
                                  child: Text(
                                      AppLocalizations.of(context)!
                                          .floorLevel(widget.data.floorLevel),
                                      style: textNormal.copyWith(
                                          color: AppColor.blackOne,
                                          fontSize: 14)),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  AppConstants.insetValue16,
                                  AppConstants.insetValue16,
                                  AppConstants.insetValue16,
                                  .0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                        AppLocalizations.of(context)!
                                            .pendingInstallation,
                                        maxLines: AppConstants.maximumTextLines,
                                        overflow: TextOverflow.ellipsis,
                                        style: textNormal.copyWith(
                                            color: AppColor.lightOrange,
                                            fontSize: 16)),
                                  ),
                                  Flexible(
                                    child: Text(
                                        AppLocalizations.of(context)!
                                            .doneInstallation,
                                        maxLines: AppConstants.maximumTextLines,
                                        overflow: TextOverflow.ellipsis,
                                        style: textNormal.copyWith(
                                            color: AppColor.darkGreen,
                                            fontSize: 16)),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        AppConstants.insetValue4,
                                        0.0,
                                        AppConstants.insetValue4,
                                        AppConstants.insetValue4),
                                    child: Text(
                                        (state.floorInstallation.pending ?? "-")
                                            .toString(),
                                        style: textNormal.copyWith(
                                            color: AppColor.lightOrange,
                                            fontSize: 80))),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      AppConstants.insetValue4,
                                      0.0,
                                      AppConstants.insetValue4,
                                      AppConstants.insetValue4),
                                  child: Text(
                                      (state.floorInstallation.done ?? "-")
                                          .toString(),
                                      style: textNormal.copyWith(
                                          color: AppColor.darkGreen,
                                          fontSize: 80)),
                                ),
                              ],
                            ),
                            Spacer(),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (state.floorInstallation.pending! == 0) {
                                    showNoPendingDialog(context);
                                  } else {
                                    showAlertDialog(context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(260, 54.0),
                                    maximumSize: const Size(260, 60.0),
                                    backgroundColor: AppColor.lightBlack,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            AppConstants.borderRadius))),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .makeInstallation,
                                  style: textWhite,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.amber,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }

  void showNoPendingDialog(BuildContext context) {
    Widget okButton = TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColor.lightBlack),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius)))),
      child: Container(
        alignment: Alignment.center,
        width: 100,
        child: Text(
          AppLocalizations.of(context)!.okay,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceAround,
      title: Text(AppLocalizations.of(context)!.noPendingInstall),
      titleTextStyle: textNormal,
      contentTextStyle: textAlert,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Text(AppLocalizations.of(context)!.noPendingInstallSubTitle),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(AppColor.lightBlack.withOpacity(0.15)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius)))),
      child: Container(
          alignment: Alignment.center,
          width: 100,
          child: Text(
            AppLocalizations.of(context)!.cancel,
            style: TextStyle(color: AppColor.lightBlack),
          )),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget confirmButton = TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColor.lightBlack),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius)))),
      child: Container(
        alignment: Alignment.center,
        width: 100,
        child: Text(
          AppLocalizations.of(context)!.confirm,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        context
            .read<MapBuildingDetailsCubit>()
            .postFloorInstallation((widget.data.floorID ?? 0).toString(), 1);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceAround,
      title: Text(AppLocalizations.of(context)!.confirmDialogTitle),
      titleTextStyle: textNormal,
      contentTextStyle: textAlert,
      content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Text(AppLocalizations.of(context)!.confirmDialogsubTitle)),
      actions: [
        cancelButton,
        confirmButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
