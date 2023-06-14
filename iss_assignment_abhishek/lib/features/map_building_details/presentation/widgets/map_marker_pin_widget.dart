import 'package:flutter/material.dart';

class MapMarkerPinWidget extends StatelessWidget {
  final Color color;

  const MapMarkerPinWidget({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 8.0,
        height: 8.0,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
          ),
        ));
  }
}
