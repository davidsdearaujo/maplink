import 'package:dartz/dartz.dart';
import 'package:maplink/src/domain/errors/usecases.dart';
import 'package:meta/meta.dart';

import '../errors/failure.dart';
import '../models/zipcode_address_model.dart';
import '../repositories/geocoder_repository.dart';

class GetAddressByZipcodeAndHouseNumber {
  final GeocoderRepository _repository;

  GetAddressByZipcodeAndHouseNumber(this._repository);
  Future<Either<Failure, List<ZipcodeAddressModel>>> call({
    @required String token,
    @required String zipcode,
    String houseNumber,
  }) async {
    if (token == null) return left(NullTokenFailure());
    if (token.isEmpty) return left(EmptyTokenFailure());
    if (zipcode == null) return left(NullZipcodeFailure());
    if (zipcode.isEmpty) return left(EmptyZipcodeFailure());

    return _repository.getAddressByZipcodeAndHouseNumber(
      token,
      zipcode,
      houseNumber,
    );
  }
}
