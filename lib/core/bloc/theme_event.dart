part of 'theme_bloc.dart';

abstract class ThemeEvent {
  factory ThemeEvent.onChangeTheme() => const _ChangeTheme();
}

class _ChangeTheme implements ThemeEvent {
  const _ChangeTheme();
}
