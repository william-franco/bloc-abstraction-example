import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@protected
typedef StateBuilder<S> = Widget Function(
  BuildContext context,
  S state,
  Widget? child,
);

class StateBuilderWidget<C extends Cubit<S>, S> extends StatelessWidget {
  final C controller;
  final StateBuilder<S> builder;
  final Widget? child;

  const StateBuilderWidget({
    super.key,
    required this.controller,
    required this.builder,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<C>(
      create: (context) => controller,
      child: BlocBuilder<C, S>(
        bloc: controller,
        builder: (context, state) {
          return builder(context, state, child);
        },
      ),
    );
  }
}
