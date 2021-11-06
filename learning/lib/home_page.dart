import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/counter_bloc.dart';
import 'package:learning_bloc/counter_events.dart';
import 'package:learning_bloc/theme/theme_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<CounterBloc>().add(const CounterIncrement()),
          child: const Icon(Icons.add),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<CounterBloc, int>(
              builder: (context, state) {
                return Text(
                  'Bloc : $state',
                  textAlign: TextAlign.center,
                );
              },
            ),
            const ThemeSwitchingWidget(),
          ],
        ),
      );
}

class ThemeSwitchingWidget extends StatelessWidget {
  const ThemeSwitchingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, state) {
            return SwitchListTile(
              value: state == ThemeMode.dark,
              onChanged: (value) => context.read<ThemeCubit>().toggle(),
              title: Text('$state'),
            );
          },
        )
      ],
    );
  }
}
