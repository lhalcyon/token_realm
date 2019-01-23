import 'package:l_token/style/themes.dart';

class AppState {
  final LTheme theme;

  final bool loadingVisible;

  AppState({this.theme, this.loadingVisible = false});

  AppState copyWith({LTheme theme, bool loadingVisible}) {
    return AppState(
        theme: theme == null ? this.theme : theme,
        loadingVisible:
            loadingVisible == null ? this.loadingVisible : loadingVisible);
  }
}
