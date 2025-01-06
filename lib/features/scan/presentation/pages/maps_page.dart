import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          APP_NAME,
        ),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialView,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
