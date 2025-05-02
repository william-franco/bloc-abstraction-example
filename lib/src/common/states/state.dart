sealed class AppState<T> {}

final class InitialState<T> extends AppState<T> {}

final class LoadingState<T> extends AppState<T> {}

final class SuccessState<T> extends AppState<T> {
  final T data;

  SuccessState({required this.data});
}

final class ErrorState<T> extends AppState<T> {
  final String message;

  ErrorState({required this.message});
}
