part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState({this.dark = false});

  factory ThemeState.initialState() => const ThemeState();

  final bool dark;

  @override
  List<Object?> get props => [dark];

  ThemeState copyWith({bool? dark}) => ThemeState(
        dark: dark ?? this.dark,
      );
}
