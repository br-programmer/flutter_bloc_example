import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState.initialState()) {
    on<Increment>(_incrementToState);
    on<Decrement>(_decrementToState);
  }

  void _incrementToState(_, Emitter<CounterState> emit) {
    emit(state.copyWith(count: state.count + 1));
  }

  void _decrementToState(_, Emitter<CounterState> emit) {
    emit(state.copyWith(count: state.count - 1));
  }
}
