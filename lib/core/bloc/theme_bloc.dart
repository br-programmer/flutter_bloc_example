import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initialState()) {
    on<_ChangeTheme>(_changeThemeToState);
  }

  void _changeThemeToState(_, Emitter<ThemeState> emit) {
    emit(state.copyWith(dark: !state.dark));
  }
}
