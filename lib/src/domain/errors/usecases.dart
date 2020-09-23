import 'package:maplink/src/domain/errors/failure.dart';

class NullTokenFailure extends Failure {
  NullTokenFailure()
      : super(
          "null-token-failure",
          message: "É necessário preencher o token para continuar.",
        );
}

class EmptyTokenFailure extends Failure {
  EmptyTokenFailure()
      : super("empty-token-failure",
            message: "É necessário preencher o token para continuar.");
}

class InvalidFieldFailure extends Failure {
  InvalidFieldFailure(String fieldName)
      : super("invalid-field-$fieldName-failure",
            message:
                "É necessário preencher o campo $fieldName para continuar.");
}
