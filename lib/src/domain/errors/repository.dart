import 'package:maplink/src/domain/errors/failure.dart';

class DatasourceExceptionFailure extends Failure {
  DatasourceExceptionFailure(String code, Exception exception)
      : super(code, innerException: exception);
}
