import 'package:flutter/material.dart';
import 'package:l_token/pages/routes/routes.dart';
import 'package:l_token/pages/wallet/init/identity_init_page.dart';

class MarketPage extends StatelessWidget {
  static const String routeName = Routes.market + "/index";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        alignment: Alignment.center,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(IdentityInitPage.routeName);
                },
                child: new Text(
                  'InitWalletPage',
                  style: TextStyle(color: Colors.purple),
                ))
          ],
        ),
      ),
    );
  }
}
