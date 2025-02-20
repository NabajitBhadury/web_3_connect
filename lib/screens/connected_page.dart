import 'package:flutter/material.dart';
import 'package:metamask/metamask.dart';
import 'package:provider/provider.dart';

class ConnectedPage extends StatelessWidget {
  final MetaMaskProvider provider;
  const ConnectedPage({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MetaMaskProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Connected')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Connected to: ${provider.currentAddress}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                provider.disconnect();
                Navigator.pop(context);
              },
              child: const Text('Disconnect'),
            ),
            ElevatedButton(
              onPressed: provider.isConnected
                  ? () async {
                      await provider.createAppeal(
                        DateTime.now().millisecondsSinceEpoch ~/ 1000,
                        DateTime.now().millisecondsSinceEpoch ~/ 1000,
                        'Sample URI',
                        '0x',
                        '0x',
                        '0x',
                      );
                    }
                  : null,
              child: const Text('Create Appeal'),
            ),
          ],
        ),
      ),
    );
  }
}
