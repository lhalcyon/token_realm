import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:l_token/model/identity.dart';
import 'package:l_token/model/wallet.dart';
import 'package:token_core_plugin/model/ex_wallet.dart';
import 'package:token_core_plugin/token_core_plugin.dart';
import 'package:l_token/pages/routes/routes.dart';
import 'package:l_token/pages/wallet/init/identity_create_result_page.dart';
import 'package:l_token/style/styles.dart';
import 'package:l_token/view/password_inputfield.dart';
import 'package:l_token/view/status_widget.dart';
import 'package:logging/logging.dart';


class IdentityCreatePage extends StatefulWidget {
  static const String routeName = Routes.main + '/create';

  @override
  State createState() {
    return new _WalletCreateState();
  }
}

class _CreateFormData {
  String name = '';

  String password = '';

  String rePassword = '';

  bool hasBeenEdited() {
    return name != '' && password != '' && rePassword != '';
  }

  @override
  String toString() {
    return '_CreateFormData{name: $name, password: $password, rePassword: $rePassword}';
  }
}

class _WalletCreateState extends State<IdentityCreatePage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _CreateFormData _formData = _CreateFormData();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(context),
      backgroundColor: Colors.white,
      body: _body(context),
    );
  }

  _appBar(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return new AppBar(
      brightness: theme.brightness,
      elevation: 0.0,
      iconTheme: theme.iconTheme,
      backgroundColor: Colors.white,
    );
  }

  _body(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    Form form = new Form(
        key: _formKey,
        autovalidate: false,
        onWillPop: _warnUserActualExit,
        child: new Container(
          width: double.infinity,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.only(top: 36.0, bottom: 8.0),
                child: new Icon(
                  Icons.account_balance_wallet,
                  size: 48.0,
                  color: theme.primaryColor,
                ),
              ),
              new Text(
                'Create Identity',
                style: new TextStyle(color: theme.primaryColor, fontSize: 24.0),
              ),
              new Container(
                margin: EdgeInsets.only(
                    left: Dimens.padding,
                    right: Dimens.padding,
                    top: Dimens.padding),
                child: new Theme(
                  data: theme.copyWith(primaryColor: theme.dividerColor),
                  child: new TextFormField(
                    decoration: new InputDecoration(hintText: 'Identity Name'),
                    onSaved: (value) {
                      this._formData.name = value;
                    },
                  ),
                ),
              ),
              new Container(
                margin: EdgeInsets.symmetric(horizontal: Dimens.padding),
                child: new Theme(
                  data: theme.copyWith(primaryColor: theme.dividerColor),
                  child: new PasswordField(
                    labelText: 'Password',
                    onSaved: (value) {
                      this._formData.password = value;
                    },
                  ),
                ),
              ),
              new Container(
                margin: EdgeInsets.symmetric(horizontal: Dimens.padding),
                child: new Theme(
                  data: theme.copyWith(primaryColor: theme.dividerColor),
                  child: new PasswordField(
                    labelText: 'Repeat Password',
                    onSaved: (value) {
                      this._formData.rePassword = value;
                    },
                  ),
                ),
              ),
              new Padding(
                padding: EdgeInsets.only(
                    top: 36.0, left: Dimens.padding, right: Dimens.padding),
                child: new RaisedButton(
                  onPressed: () {
                    final FormState form = _formKey.currentState;
                    form.save();
                    _handleCreateWallet(context);
                  },
                  child: new Container(
                    alignment: Alignment.center,
                    height: Dimens.itemHeight,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: Dimens.padding),
                    child: new Text('Create'),
                  ),
                ),
              )
            ],
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ));
    return StatusWidget(status: Status.Result, widget: form);
  }

  Future<bool> _warnUserActualExit() async {
    final FormState form = _formKey.currentState;
    if (form == null || !_formData.hasBeenEdited()) {
      return true;
    }

    return await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return new AlertDialog(
                title: const Text('This form has errors'),
                content: const Text('Really leave this form?'),
                actions: <Widget>[
                  new FlatButton(
                    child: const Text('YES'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                  new FlatButton(
                    child: const Text('NO'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ],
              );
            }) ??
        false;
  }

  _handleCreateWallet(BuildContext context) async {
    // todo 校验
    String password = _formData.password;
    String name = _formData.name;
    print("before:${new DateTime.now()}\n");

    var identity = await TokenCorePlugin.createIdentity(
        password, Network.testNet, SegWit.none, Words.twelve);

    var mnemonic =
        await TokenCorePlugin.exportMnemonic(identity.keystore, password);
    print(identity.toString());

    Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
      return new IdentityCreateResultPage(
          Identity(
              name: name, avatar: "ic_default_user_avatar", identity: identity),
          mnemonic);
    }));
  }
}
