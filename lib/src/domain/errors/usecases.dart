import 'package:maplink/src/domain/errors/failure.dart';

class NullTokenFailure extends Failure {
  NullTokenFailure()
      : super(
          "null-token-failure",
          message:
              "É necessário preencher o token para realizar essa requisição.",
        );
}

class EmptyTokenFailure extends Failure {
  EmptyTokenFailure()
      : super("empty-token-failure",
            message:
                "É necessário preencher o token para realizar essa requisição.");
}

class NullZipcodeFailure extends Failure {
  NullZipcodeFailure()
      : super("null-zipcode-failure",
            message:
                "É necessário preencher o zipcode para realizar essa requisição.");
}

class EmptyZipcodeFailure extends Failure {
  EmptyZipcodeFailure()
      : super("empty-zipcode-failure",
            message:
                "É necessário preencher o zipcode para realizar essa requisição.");
}

class InvalidFieldFailure extends Failure {
  InvalidFieldFailure(String fieldName)
      : super("invalid-field-$fieldName-failure",
            message:
                "É necessário preencher o campo $fieldName para realizar essa requisição.");
}
