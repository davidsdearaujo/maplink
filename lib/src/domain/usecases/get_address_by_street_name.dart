import 'package:dartz/dartz.dart';
import 'package:maplink/src/domain/errors/usecases.dart';
import 'package:meta/meta.dart';

import '../errors/failure.dart';
import '../models/zipcode_address_model.dart';
import '../repositories/geocoder_repository.dart';

class GetAddressByStreetName {
  final GeocoderRepository _repository;

  GetAddressByStreetName(this._repository);
  Future<Either<Failure, List<ZipcodeAddressModel>>> call({
    @required String token,
    String country = "BRA",
    @required String city,
    @required String state,
    @required String streetName,
    String housenumber,
  }) async {
    if (token == null) return left(NullTokenFailure());
    if (token.isEmpty) return left(EmptyTokenFailure());
    if (city == null || city.isEmpty) {
      return left(InvalidFieldFailure("city"));
    }
    if (state == null || state.isEmpty) {
      return left(InvalidFieldFailure("state"));
    }
    if (streetName == null || streetName.isEmpty) {
      return left(InvalidFieldFailure("streetName"));
    }

    return await _repository.getAddressByStreetName(
      token,
      country ?? "BRA",
      city,
      state,
      streetName,
      housenumber,
    );
  }
}
