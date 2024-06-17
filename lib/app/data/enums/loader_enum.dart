enum LoaderEnum {
  initial,
  loading,
  failed,
  success;

  bool get isLoading => this == loading;
  bool get isSuccess => this == success;
  bool get isFailed => this == failed;
  bool get isInitial => this == initial;
}
