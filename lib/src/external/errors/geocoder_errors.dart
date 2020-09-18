import 'package:maplink/src/domain/errors/failure.dart';

class NullDatasourceResponseFailure extends Failure {
  NullDatasourceResponseFailure() : super("null-datasource-response");
}

class EmptyDatasourceResponseFailure extends Failure {
  EmptyDatasourceResponseFailure() : super("empty-datasource-response");
}

class GeocoderDatasourceErrorMessagesFailure extends Failure {
  final List<GeocoderDatasourceErrorMessage> errors;

  GeocoderDatasourceErrorMessagesFailure(this.errors)
      : super("geocoder-datasource-error-messages-failure");

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is GeocoderDatasourceErrorMessagesFailure &&
        listEquals(o.errors, errors);
  }

  @override
  int get hashCode => errors.hashCode;

  @override
  String toString() =>
      'GeocoderDatasourceErrorMessagesFailure(errors: $errors)';
}

class GeocoderDatasourceErrorMessage {
  final String code;
  final String errorMessage;

  GeocoderDatasourceErrorMessage({this.code, this.errorMessage});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is GeocoderDatasourceErrorMessage && o.code == code;
  }

  @override
  int get hashCode => code.hashCode ^ errorMessage.hashCode;

  @override
  String toString() =>
      'GeocoderDatasourceErrorMessage(code: $code, errorMessage: $errorMessage)';
}

bool listEquals<T>(List<T> a, List<T> b) {
  if (a == null) return b == null;
  if (b == null || a.length != b.length) return false;
  if (identical(a, b)) return true;
  for (int index = 0; index < a.length; index += 1) {
    if (a[index] != b[index]) return false;
  }
  return true;
}
