import 'package:flutter/cupertino.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:metamask/utils/constants/abi.dart';
import 'package:metamask/utils/constants/address.dart';

enum AuthScreens {
  loginScreen,
  homeScreen,
}

class MetaMaskProvider extends ChangeNotifier {
  static const operatingChain = 80002;

  String currentAddress = '';
  int currentChain = -1;

  bool get isEnabled => ethereum != null;
  bool get isInOperatingChain => currentChain == operatingChain;
  bool get isConnected => isEnabled && currentAddress.isNotEmpty;

  AuthScreens _screen = AuthScreens.loginScreen;
  AuthScreens get screen => _screen;

  set screen(AuthScreens value) {
    _screen = value;
    notifyListeners();
  }

  Future<TransactionResponse?> createAppeal(
    int startTime,
    int votingPeriod,
    String uri,
    String executionData,
    String hookData,
    String target,
  ) async {
    try {
      // Safely get the Ethereum provider
      final ethereumProvider = ethereum;
      if (ethereumProvider == null) {
        debugPrint('❌ Ethereum is not available');
        return null;
      }

      // Initialize Web3Provider with the ethereum provider
      final provider = Web3Provider(ethereumProvider);
      debugPrint('✅ Web3Provider initialized.');

      final signer = provider.getSigner();
      final contract = Contract(
        address,
        abi,
        signer,
      );

      final tx = await contract.send(
        "createAppeal",
        [
          BigInt.from(startTime),
          BigInt.from(votingPeriod),
          uri,
          executionData,
          target,
          hookData
        ],
      );

      debugPrint('✅ Transaction submitted: ${tx.hash}');
      return tx;
    } catch (e) {
      debugPrint('❌ Error creating appeal: $e');
      return null;
    }
  }

  Future<void> connect() async {
    if (ethereum == null) {
      debugPrint('❌ MetaMask is not available.');
      return;
    }

    try {
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) {
        currentAddress = accs.first;
        debugPrint('✅ Connected Address: $currentAddress');
      }

      currentChain = await ethereum!.getChainId();
      debugPrint('✅ Current Chain ID: $currentChain');

      if (!isInOperatingChain) {
        await switchToPolygonAmoy();
      }

      notifyListeners();
      debugPrint('✅ Ethereum object after connection: $ethereum');
    } catch (e) {
      debugPrint('❌ Error connecting to MetaMask: $e');
    }
  }

  Future<void> switchToPolygonAmoy() async {
    if (isEnabled) {
      try {
        await ethereum!.walletSwitchChain(operatingChain);
        debugPrint('✅ Switched to Polygon Amoy.');
      } catch (e) {
        debugPrint('❌ Error switching chain: $e');
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
        );
        debugPrint('✅ Polygon Amoy network added.');
      } catch (e) {
        debugPrint('❌ Error adding Polygon Amoy network: $e');
      }
    }
  }

  Future<void> disconnect() async {
    try {
      currentAddress = '';
      currentChain = -1;
      notifyListeners();
      debugPrint('✅ Disconnected from MetaMask.');
    } catch (e) {
      debugPrint('❌ Error during disconnect: $e');
    }
  }

  void clear() {
    currentAddress = '';
    currentChain = -1;
    notifyListeners();
  }

  void init() {
    if (ethereum == null) {
      debugPrint("❌ Ethereum object is NULL. MetaMask might not be installed.");
      return;
    }

    ethereum!.onAccountsChanged((accounts) {
      clear();
      debugPrint("⚠️ MetaMask account changed.");
    });

    ethereum!.onChainChanged((chainId) {
      currentChain = chainId;
      notifyListeners();
      debugPrint("⚠️ Chain changed to: $currentChain");
    });

    debugPrint("✅ Ethereum object initialized successfully.");
  }
}
