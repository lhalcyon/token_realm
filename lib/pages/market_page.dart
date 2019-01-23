import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l_token/bloc/bloc_app.dart';
import 'package:l_token/bloc/states.dart';
import 'package:l_token/pages/routes/routes.dart';
import 'package:l_token/pages/wallet/init/identity_init_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class MarketPage extends StatelessWidget {
  static const String routeName = Routes.market + "/index";

  @override
  Widget build(BuildContext context) {
    final AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    return new Scaffold(
      body: new Container(
        alignment: Alignment.center,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<AppEvent,AppState>(
              bloc: appBloc,
              builder: (BuildContext context,AppState state){
                return new RaisedButton(
                    onPressed: () {
                      appBloc.changeTheme();
                      appBloc.toggleLoading(true);
                      new Future.delayed(Duration(milliseconds: 2000),(){
                        appBloc.toggleLoading(false);
                      });
                    },
                    child: new Text(
                      'ShowLoading',
                      style: TextStyle(color: Colors.purple),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
