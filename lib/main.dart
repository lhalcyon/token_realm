import 'package:flutter/material.dart';
import 'package:l_token/config/states.dart';
import 'package:l_token/style/themes.dart';
import 'package:l_token/pages/main_page.dart';
import 'package:l_token/pages/routes/page.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() {
  // todo 获取 debug or release 配置
  _initLog(true);
  Store<AppState> store = new Store(appReducer,
      initialState: new AppState(theme: kLightTheme, loadingVisible: false));
  runApp(new App(store: store));
}

void _initLog(bool loggable) {
  Logger.root.level = Level.ALL;
  Logger.root.isLoggable(loggable?Level.ALL:Level.OFF);
  Logger.root.onRecord.listen((record){
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
}

class App extends StatelessWidget {
  final Store<AppState> store;

  App({this.store});

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
        store: store,
        child: new StoreBuilder<AppState>(builder: (context, store) {
          bool needLoadingVisible = store.state.loadingVisible;
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Opacity(
                opacity: needLoadingVisible ? 1.0 : 0.0,
                child: _buildGlobalLoading(context),
              ),
              new MaterialApp(
                theme: store.state.theme.themeData,
                routes: _buildRoutes(),
                home: new MainPage(),
              ),
            ],
          );
        }));
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return new Map<String, WidgetBuilder>.fromIterable(
      kAllPages,
      key: (dynamic page) => '${page.routeName}',
      value: (dynamic page) => page.buildRoute,
    );
  }

  _buildGlobalLoading(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        const ModalBarrier(
          color: Colors.grey,
        ),
        Container(
          width: 102.0,
          height: 102.0,
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
              color: theme.backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          child: new CircularProgressIndicator(),
        )
      ],
    );
  }
}
