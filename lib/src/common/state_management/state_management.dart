import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class StateManagement<T> extends Cubit<T> {
  StateManagement(super.initialState);

  @protected
  void emitState(T newState) {
    if (state != newState) {
      emit(newState);
    }
  }
}

@protected
typedef StateBuilder<S> = Widget Function(BuildContext context, S state);

class StateBuilderWidget<V extends Cubit<S>, S> extends StatelessWidget {
  final V viewModel;
  final StateBuilder<S> builder;
  final Widget? child;

  const StateBuilderWidget({
    super.key,
    required this.viewModel,
    required this.builder,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<V>.value(
      value: viewModel,
      child: BlocBuilder<V, S>(
        bloc: viewModel,
        builder: (context, state) {
          return builder(context, state);
        },
      ),
    );
  }
}
