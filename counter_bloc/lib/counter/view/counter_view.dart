import 'package:counter_bloc/counter/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Bloc'),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: context.read<CounterCubit>().increment,
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: context.read<CounterCubit>().decrement,
            child: const Icon(Icons.remove),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<CounterCubit, int>(
            builder: (context, state) => Text(
              '$state',
              style: const TextStyle(fontSize: 40),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
