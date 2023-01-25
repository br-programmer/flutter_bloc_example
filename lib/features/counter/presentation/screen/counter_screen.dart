import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/features/counter/counter.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Counter Example'),
          elevation: 0,
        ),
        body: const _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final countBloc = context.read<CounterBloc>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocSelector<CounterBloc, CounterState, int>(
          selector: (state) => state.count,
          builder: (context, count) => Text('$count'),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => countBloc.add(Decrement()),
              color: Colors.red,
              icon: const Icon(Icons.remove),
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () => countBloc.add(Increment()),
              color: Colors.green,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
