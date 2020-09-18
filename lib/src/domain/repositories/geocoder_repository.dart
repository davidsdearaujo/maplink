import 'package:dartz/dartz.dart';

import '../errors/failure.dart';
import '../models/zipcode_address_model.dart';

abstract class GeocoderRepository {
  Future<Either<Failure, List<ZipcodeAddressModel>>>
      getAddressByZipcodeAndHouseNumber(
    String token,
    String zipcode,
    String houseNumber,
  );
}
