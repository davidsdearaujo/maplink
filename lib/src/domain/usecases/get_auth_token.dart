import 'package:dartz/dartz.dart';
import 'package:maplink/src/domain/errors/usecases.dart';
import 'package:maplink/src/domain/models/auth_user.dart';

import '../errors/failure.dart';

import '../repositories/geocoder_repository.dart';

class GetAuthToken {
  final GeocoderRepository _repository;

  GetAuthToken(this._repository);
  Future<Either<Failure, AuthUser>> call({
    required String client_id,
    required String client_secret,
  }) async {
    if (client_id.isEmpty) {
      return left(EmptyClientIdFailure());
    }
    if (client_secret.isEmpty) {
      return left(EmptyClientSecretFailure());
    }

    return await _repository.getAuthToken(client_id, client_secret);
  }
}
