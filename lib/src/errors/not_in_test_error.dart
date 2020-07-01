class NotInTestError implements Error {
  NotInTestError();
  StackTrace get stackTrace => StackTrace.fromString("here");
}
