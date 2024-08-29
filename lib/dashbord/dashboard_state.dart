class DashboardState {}

class LoadingState extends DashboardState {}
class ErrorState extends DashboardState {
  ErrorState({
    this.errorMessage,
  });
  final String? errorMessage;
}

class SuccessState extends DashboardState {
  SuccessState({
    this.scessMessage,
  });
  final String? scessMessage;
}
