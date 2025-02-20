import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metamask/metamask.dart';
import 'package:metamask/screens/connected_page.dart';
import 'package:provider/provider.dart';

class MetamaskLoginPage extends StatefulWidget {
  const MetamaskLoginPage({Key? key}) : super(key: key);

  @override
  State<MetamaskLoginPage> createState() => _MetamaskLoginPageState();
}

class _MetamaskLoginPageState extends State<MetamaskLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      body: Stack(
        children: [
          Center(
            child: Consumer<MetaMaskProvider>(
              builder: (context, provider, child) {
                if (provider.isConnected && provider.isInOperatingChain) {
                  // Navigate to new page when connected
                  Future.microtask(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConnectedPage(provider: provider),
                      ),
                    );
                  });
                }

                return provider.isConnected && !provider.isInOperatingChain
                    ? const Text(
                        'Wrong chain. Please connect to ${MetaMaskProvider.operatingChain}',
                        textAlign: TextAlign.center,
                      )
                    : provider.isEnabled
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Click the button to connect...'),
                              const SizedBox(height: 8),
                              CupertinoButton(
                                onPressed: () =>
                                    context.read<MetaMaskProvider>().connect(),
                                color: Colors.white,
                                padding: const EdgeInsets.all(0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.network(
                                      'https://i0.wp.com/kindalame.com/wp-content/uploads/2021/05/metamask-fox-wordmark-horizontal.png?fit=1549%2C480&ssl=1',
                                      width: 300,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : const Text('Please use a Web3 supported browser.');
              },
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTicLAkhCzpJeu9OV-4GOO-BOon5aPGsj_wy9ETkR4g-BdAc8U2-TooYoiMcPcmcT48H7Y&usqp=CAU',
                fit: BoxFit.cover,
                opacity: const AlwaysStoppedAnimation(0.025),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
