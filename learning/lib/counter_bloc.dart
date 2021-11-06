import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/counter_events.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrement>(
      (event, emit) {
        emit(state + 1);
      },
    );
  }
}


