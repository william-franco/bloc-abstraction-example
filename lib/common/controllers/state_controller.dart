import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class StateController<T> extends Cubit<T> {
  StateController(super.initialState);

  @protected
  void emitState(T newState) {
    if (state != newState) {
      emit(newState);
    }
  }
}
