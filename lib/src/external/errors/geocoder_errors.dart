import 'package:maplink/src/domain/errors/failure.dart';

class NullDatasourceResponseFailure extends Failure {
  NullDatasourceResponseFailure() : super("null-datasource-response");
}

class EmptyDatasourceResponseFailure extends Failure {
  EmptyDatasourceResponseFailure() : super("empty-datasource-response", message: "Endereço não encontrado");
}

class ErrorsMaplinkFailure extends Failure {
  final List<ErrorsMaplinkMessage> errors;

  ErrorsMaplinkFailure(this.errors) : super("maplink-error-messages-failure");

  @override
  String get message {
    return errors.map((e) => e.errorMessage).join("\n");
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is ErrorsMaplinkFailure && listEquals(o.errors, errors);
  }

  @override
  int get hashCode => errors.hashCode;

  @override
  String toString() => 'ErrorsMaplinkFailure(errors: $errors)';
}

class ErrorsMaplinkMessage {
  final String? code;
  final String? errorMessage;

  ErrorsMaplinkMessage({this.code, this.errorMessage});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is ErrorsMaplinkMessage && o.code == code;
  }

  @override
  int get hashCode => code.hashCode ^ errorMessage.hashCode;

  @override
  String toString() => 'ErrorsMaplinkMessage(code: $code, errorMessage: $errorMessage)';
}

bool listEquals<T>(List<T> a, List<T> b) {
  if (identical(a, b)) return true;
  for (int index = 0; index < a.length; index += 1) {
    if (a[index] != b[index]) return false;
  }
  return true;
}
