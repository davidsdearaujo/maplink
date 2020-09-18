import 'package:maplink/src/domain/models/zipcode_address_model.dart';

class ZipcodeAddressModelMapper {
  static fromJson(dynamic address) {
    if (address == null) return null;
    if (!(address is Map)) return null;

    String country;
    String state;
    String city;
    String district;
    String houseNumber;
    String streetName;
    String latitude;
    String longitude;

    if (address["country"] != null) {
      country = address["country"]["countryCode"];
    }
    if (address["state"] != null) {
      state = address["state"]["shortName"];
    }
    if (address["city"] != null) {
      city = address["city"]["name"];
    }
    if (address["district"] != null) {
      district = address["district"]["name"];
    }
    if (address["addressLine"] != null) {
      houseNumber = address["addressLine"]["houseNumber"];
      streetName = address["addressLine"]["name"];
      if (address["addressLine"]["location"] != null &&
          address["addressLine"]["location"]["coordinates"] != null &&
          address["addressLine"]["location"]["coordinates"].length >= 2) {
        latitude = address["addressLine"]["location"]["coordinates"][0]?.toString();
        longitude = address["addressLine"]["location"]["coordinates"][1]?.toString();
      }
    }

    return ZipcodeAddressModel(
      city: city,
      country: country,
      district: district,
      houseNumber: houseNumber,
      streetName: streetName,
      state: state,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
