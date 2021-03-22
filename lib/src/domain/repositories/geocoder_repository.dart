import 'package:dartz/dartz.dart';

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
}
