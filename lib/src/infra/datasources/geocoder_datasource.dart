import 'package:maplink/src/domain/models/zipcode_address_model.dart';

abstract class GeocoderDatasource {
  Future<List<ZipcodeAddressModel>> getAddressByZipcodeAndHouseNumber(
    String token,
    String zipcode,
    String houseNumber,
  );
}
