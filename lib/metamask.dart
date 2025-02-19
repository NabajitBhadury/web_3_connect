import 'package:flutter/cupertino.dart';
import 'package:flutter_web3/flutter_web3.dart';

class MetaMaskProvider extends ChangeNotifier {
  //here we will store our provider
  static const operatingChain = 1;

  String currentAddress = ''; //current address

  int currentChain = -1; //current chain

  bool get isEnabled => ethereum != null;

  bool get isInOperatingChain => currentChain == operatingChain;

  bool get isConnected => isEnabled && currentAddress.isNotEmpty;

  Future<void> connect() async {
    //a function to connect to the wallet
    if (isEnabled) {
      //check if web3 is enabled
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) currentAddress = accs.first;
      debugPrint(accs.toString());

      currentChain = await ethereum!.getChainId();

      debugPrint(currentChain.toString());

      notifyListeners();
    }
  }

  clear() {
    //clear address and chain
    currentAddress = '';
    currentChain = -1;
    notifyListeners(); //it will update listener
  }

  init() {
    //initialize listener
    if (isEnabled) {
      ethereum!.onAccountsChanged((accounts) {
        //account change
        clear();
      });
      ethereum!.onChainChanged((accounts) {
        //chain change
      });
    }
  }
}
