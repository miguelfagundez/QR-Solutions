import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_solutions/src/services/providers/scans_provider.dart';
import 'package:qr_solutions/src/utils/convert.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanProvider = Provider.of<ScanProvider>(context);
    final myScans = scanProvider.scans;

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: myScans.length,
        itemBuilder: (_, i) => ListTile(
          leading: Icon(
            convertTypeToIcon(myScans[i].type ?? ''),
            color: Theme.of(context).primaryColor,
          ),
          title: Text(myScans[i].value),
          subtitle: Text(convertType(myScans[i].type ?? '')),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
          ),
          onTap: () => print('${myScans[i].id}'),
        ),
      ),
    );
  }
}
