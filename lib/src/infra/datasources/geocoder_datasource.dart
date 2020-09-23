import 'package:maplink/src/domain/models/zipcode_address_model.dart';

abstract class GeocoderDatasource {
  Future<List<ZipcodeAddressModel>> getAddressByZipcodeAndHouseNumber(
    String token,
    String zipcode,
    String houseNumber,
  );
  
  Future<List<ZipcodeAddressModel>> getAddressByStreetName(
    String token,
    String country,
    String city,
    String state,
    String streetName,
    String housenumber,
  );
}
