import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lootbox_wallet/pages/auth/auth.page.dart';
import 'package:lootbox_wallet/pages/onboarding/onboarding.page.dart';
import 'package:lootbox_wallet/common/models/Collection.dart';
import 'package:lootbox_wallet/common/models/Network.dart';
import 'package:lootbox_wallet/data/model/channels/AppChannel.dart';
import 'package:lootbox_wallet/pages/shell/components/TabView.dart';
import 'package:lootbox_wallet/providers/collections_provider.dart';
import 'package:lootbox_wallet/providers/network_provider.dart';
import 'package:mobx/mobx.dart';
import 'package:lootbox_wallet/state/app.dart';
import 'package:lootbox_wallet/state/keyring.dart';
import 'package:provider/provider.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ShellPage extends StatefulWidget {
  @override
  ShellPageState createState() => ShellPageState();
}

class ShellPageState extends State<ShellPage> {
  late AppState appState;
  late ReactionDisposer _appStateDisposer;

  @override
  void initState() {
    super.initState();
    () async {
      await Future.delayed(Duration.zero);

      context.read<NetworkProvider>().selectNetwork(selectedNetwork);
      context.read<Collections>().setCollections(collections);
    }();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appState = Provider.of<AppState>(context);
    _appStateDisposer = autorun(
      (_) {
        switch(appState.state) {
          case AppCurrentState.loading:
          case AppCurrentState.initial:
            context.loaderOverlay.show();
            break;
          case AppCurrentState.ready:
            context.loaderOverlay.hide();
        }
      }
    );
  }

  @override 
  void dispose() {
    _appStateDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Keyring keyringStore = Provider.of<Keyring>(context);

    if (appState.state == AppCurrentState.initial) {
      appState.initApp(keyringStore);
    }

    return Observer(
      builder: (_) {

        if(appState.state != AppCurrentState.ready)
          return Container(color: Colors.black,);
        
        if(appState.user != null)
          return TabView();

        if(appState.isOnboarding == true)
          return OnBoardingPage();

        return AuthPage();
      }
    );
  }
}