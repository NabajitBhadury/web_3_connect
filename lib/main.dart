import 'package:flutter/material.dart';
import 'package:metamask/metamask.dart';
import 'package:metamask/screens/connected_page.dart';
import 'package:metamask/screens/metamask_login_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MetaMaskProvider()..init(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: const MetamaskLoginPage(),
      ),
    );
  }
}

class AuthHandeler extends StatelessWidget {
  const AuthHandeler({Key? key}) : super(key: key);

  Widget getPage(AuthScreens screen, MetaMaskProvider provider) {
    switch (screen) {
      case AuthScreens.loginScreen:
        return const MetamaskLoginPage();
      case AuthScreens.homeScreen:
        return ConnectedPage(
          provider: provider,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<MetaMaskProvider>(context);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: getPage(vm.screen, vm),
    );
  }
}
