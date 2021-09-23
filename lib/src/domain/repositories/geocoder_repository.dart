import 'package:dartz/dartz.dart';
import 'package:maplink/src/domain/models/auth_user.dart';

import '../errors/failure.dart';
import '../models/zipcode_address_model.dart';

abstract class GeocoderRepository {
  Future<Either<Failure, List<ZipcodeAddressModel>>> getAddressByZipcodeAndHouseNumber(
    String token,
    String zipcode,
    String? houseNumber,
  );

  Future<Either<Failure, List<ZipcodeAddressModel>>> getAddressByStreetName(
    String token,
    String country,
    String city,
    String state,
    String streetName,
    String? housenumber,
  );

  Future<Either<Failure, AuthUser>> getAuthToken(String client_id, String client_secret);
}
