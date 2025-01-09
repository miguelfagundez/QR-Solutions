import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_solutions/config/theme/colors.dart';
import 'package:qr_solutions/core/utils/constants.dart';
import 'package:qr_solutions/features/scan/domain/entities/scan.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late final Scan scan;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  MapType mapType = MapType.normal;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    scan = ModalRoute.of(context)!.settings.arguments as Scan;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialView = CameraPosition(
      //target: LatLng(37.42796133580664, -122.085749655962),
      target: scan.getLatLng(),
      zoom: 17,
      tilt: 25.0,
    );

    Set<Marker> centerMarker = <Marker>{};
    centerMarker.add(Marker(
      markerId: const MarkerId('center-marker'),
      position: scan.getLatLng(),
    ));

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            APP_NAME,
          ),
          actions: [
            IconButton(
              onPressed: () async {
                final GoogleMapController newController =
                    await _controller.future;
                newController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: scan.getLatLng(),
                      zoom: 17,
                      tilt: 25.0,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.location_searching),
            )
          ],
        ),
        body: GoogleMap(
          mapType: mapType,
          markers: centerMarker,
          initialCameraPosition: initialView,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.layers_outlined,
            color: AppColors.iconColorScanButton,
          ),
          onPressed: () {
            setState(() {
              if (mapType == MapType.normal) {
                mapType = MapType.hybrid;
              } else {
                mapType = MapType.normal;
              }
            });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
