import 'package:flutter/material.dart';

class ScanDetailsPage extends StatelessWidget {
  const ScanDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Details'),
      ),
      body: const Center(
        child: Text('Scan Details Page'),
      ),
    );
  }
}
