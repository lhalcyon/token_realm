import 'package:flutter/material.dart';
import 'package:l_token/bloc/bloc_app.dart';
import 'package:l_token/bloc/states.dart';
import 'package:l_token/style/themes.dart';
import 'package:l_token/pages/main_page.dart';
import 'package:l_token/pages/routes/page.dart';
import 'package:logging/logging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // todo 获取 debug or release 配置
  _initLog(true);

  runApp(App());
}

void _initLog(bool loggable) {
  Logger.root.level = Level.ALL;
  Logger.root.isLoggable(loggable ? Level.ALL : Level.OFF);
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
}


class App extends StatefulWidget {

  App();

  @override
  State createState() {
    return _AppState();
  }
}

class _AppState extends State<App>{

  final AppBloc _appBloc = AppBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      bloc: _appBloc,
      child: BlocBuilder(
        bloc: _appBloc,
        builder: (BuildContext context, AppState state) {
          bool needLoadingVisible = _appBloc.currentState.loadingVisible;
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              MaterialApp(
                theme: _appBloc.currentState.theme.themeData,
                routes: _buildRoutes(),
                home: new MainPage(),
              ),
              Opacity(
                opacity: needLoadingVisible ? 1.0 : 0.0,
                child: _buildGlobalLoading(context),
              ),
            ],
          );
        },
      ),
    );

  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return new Map<String, WidgetBuilder>.fromIterable(
      kAllPages,
      key: (dynamic page) => '${page.routeName}',
      value: (dynamic page) => page.buildRoute,
    );
  }

  _buildGlobalLoading(BuildContext context) {
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
              color: const Color(0xfff2f2f2),
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          child: new CircularProgressIndicator(),
        )
      ],
    );
  }
}
