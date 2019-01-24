import 'package:l_token/style/themes.dart';

class AppState {
  final LTheme theme;

  AppState({this.theme});

  AppState copyWith({LTheme theme, bool loadingVisible}) {
    return AppState(
        theme: theme == null ? this.theme : theme);
  }
}
