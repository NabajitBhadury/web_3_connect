import 'package:flutter/cupertino.dart';
import 'package:flutter_web3/flutter_web3.dart';

class MetaMaskProvider extends ChangeNotifier {
  static const operatingChain = 80002;

  String currentAddress = '';
  int currentChain = -1;

  bool get isEnabled => ethereum != null;
  bool get isInOperatingChain => currentChain == operatingChain;
  bool get isConnected => isEnabled && currentAddress.isNotEmpty;

  Future<void> connect() async {
    if (isEnabled) {
      try {
        final accs = await ethereum!.requestAccount();
        if (accs.isNotEmpty) currentAddress = accs.first;
        debugPrint('Connected Address: $currentAddress');

        currentChain = await ethereum!.getChainId();
        debugPrint('Current Chain ID: $currentChain');

        if (!isInOperatingChain) {
          await switchToPolygonAmoy();
        }

        notifyListeners();
      } catch (e) {
        debugPrint('Error connecting to MetaMask: $e');
      }
    } else {
      debugPrint('MetaMask is not available');
    }
  }

  Future<void> switchToPolygonAmoy() async {
    if (isEnabled) {
      try {
        await ethereum!.walletSwitchChain(operatingChain);
      } catch (e) {
        debugPrint('Error switching chain: $e');
        if (e.toString().contains('Unrecognized chain ID')) {
          await addPolygonAmoyNetwork();
        }
      }
    }
  }

  Future<void> addPolygonAmoyNetwork() async {
    if (isEnabled) {
      try {
        await ethereum!.walletAddChain(
          chainId: operatingChain,
          chainName: 'Polygon Amoy Testnet',
          nativeCurrency: CurrencyParams(
            name: 'MATIC',
            symbol: 'MATIC',
            decimals: 18,
          ),
          rpcUrls: [
            'https://polygon-amoy.g.alchemy.com/v2/ZgdG5H6uBQ5zNyYzDoh3mtOpwI-VuEvd'
          ],
          // blockExplorerUrls: ['https://www.oklink.com/amoy'],
        );
      } catch (e) {
        debugPrint('Error adding Polygon Amoy network: $e');
      }
    }
  }

  void clear() {
    currentAddress = '';
    currentChain = -1;
    notifyListeners();
  }

  void init() {
    if (isEnabled) {
      ethereum!.onAccountsChanged((accounts) {
        clear();
      });

      ethereum!.onChainChanged((chainId) {
        currentChain = chainId;
        notifyListeners();
      });
    }
  }
}
