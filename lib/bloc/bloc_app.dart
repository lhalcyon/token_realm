import 'package:bloc/bloc.dart';
import 'package:l_token/bloc/states.dart';
import 'package:l_token/style/themes.dart';

enum AppEventType {
  changeTheme,
}

class AppEvent{
  final AppEventType type;

  AppEvent(this.type);


}

class AppBloc extends Bloc<AppEvent,AppState>{


  @override
  AppState get initialState {
    return new AppState(theme: kLightTheme);
  }

  @override
  Stream<AppState> mapEventToState(AppState currentState, AppEvent event) {
    AppState state = currentState;
    switch (event.type){
      case AppEventType.changeTheme:
        bool isDark = currentState.theme.isDark();
        state = state.copyWith(theme: isDark ? kLightTheme : kDarkTheme);
        break;
      default:break;
    }
    var stateFuture = Future.value(state);
    return Stream.fromFuture(stateFuture);
  }

  void changeTheme(){
    dispatch(AppEvent(AppEventType.changeTheme));
  }


}