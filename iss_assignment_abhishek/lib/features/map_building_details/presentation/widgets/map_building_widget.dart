// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:iss_assignment/core/api_end_points.dart';
import 'package:iss_assignment/utils/app_color.dart';
import 'package:iss_assignment/utils/app_constants.dart';
import 'package:latlong2/latlong.dart';

import 'package:iss_assignment/features/map_building_details/presentation/widgets/map_marker_pin_widget.dart';

import '../../../qr_code_scanner/data/models/qr_scan_response_model.dart';

class MapBuildingWidget extends StatefulWidget {
  final QRScanResponse data;

  const MapBuildingWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<MapBuildingWidget> createState() => _MapBuildingWidgetState();
}

class _MapBuildingWidgetState extends State<MapBuildingWidget> {
  @override
  Widget build(BuildContext context) {
    LatLng topLeftCorner =
        widget.data.floorplan!.boundaries!.topLeft!.toLntLng();
    LatLng bottomLeftCorner =
        widget.data.floorplan!.boundaries!.bottomLeft!.toLntLng();
    LatLng topRightCorner =
        widget.data.floorplan!.boundaries!.topRight!.toLntLng();
    LatLng userPosition = widget.data.userLocation!.toLntLng();
    String floorPlanImage =
        APIEndPoints.baseURL + (widget.data.floorplan!.imageURL ?? '');

    if (widget.data.floorplan!.imageURL != null) {
      floorPlanImage =
          APIEndPoints.baseURL + (widget.data.floorplan!.imageURL ?? '');
    } else {
      floorPlanImage = '';
    }

    final overlayImages = <BaseOverlayImage>[
      RotatedOverlayImage(
          topLeftCorner: bottomLeftCorner,
          bottomLeftCorner: topLeftCorner,
          bottomRightCorner: topRightCorner,
          opacity: 0.8,
          imageProvider: NetworkImage(floorPlanImage)),
    ];

    return FlutterMap(
      options: MapOptions(center: userPosition, zoom: AppConstants.zoomValue),
      children: [
        TileLayer(
          urlTemplate: APIEndPoints.osmURL,
        ),
        OverlayImageLayer(
          overlayImages: overlayImages,
        ),
        MarkerLayer(
          markers: [
            Marker(
                point: userPosition,
                builder: (context) =>
                    const MapMarkerPinWidget(color: AppColor.lightBlack))
          ],
        )
      ],
    );
  }
}
