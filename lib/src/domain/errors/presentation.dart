import 'package:maplink/src/domain/errors/failure.dart';

class PresentationFailure extends Failure {
  final Object data;
  PresentationFailure(this.data)
      : super(
          "presenter-failure",
          message: "Ocorreu um erro interno, tente novamente mais tarde.",
          innerException: Exception(data),
        );
}
