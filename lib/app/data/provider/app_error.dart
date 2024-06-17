class AppError {
  final String message;

  const AppError(
    this.message,
  );
}

class SingleFieldError extends AppError {
  final String field;

  SingleFieldError(this.field, super.message);
}

class MultipleFieldError extends AppError {
  final List<(String, String)> fieldMsg;

  MultipleFieldError(this.fieldMsg, super.message);
}
