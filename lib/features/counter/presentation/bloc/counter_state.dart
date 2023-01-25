part of 'counter_bloc.dart';

class CounterState extends Equatable {
  const CounterState({this.count = 0});

  factory CounterState.initialState() => const CounterState();

  final int count;

  @override
  List<Object?> get props => [count];

  CounterState copyWith({int? count}) {
    return CounterState(count: count ?? this.count);
  }
}
