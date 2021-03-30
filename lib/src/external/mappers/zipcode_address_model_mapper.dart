import 'package:maplink/src/domain/models/zipcode_address_model.dart';

class ZipcodeAddressModelMapper {
  static fromJson(dynamic address) {
    if (address == null) return null;
    if (!(address is Map)) return null;

    String? country;
    String? state;
    String? city;
    String? district;
    String? houseNumber;
    String? streetName;
    String? latitude;
    String? longitude;

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
      final location = address["addressLine"]["location"];
      if (location != null && location["coordinates"] != null && location["coordinates"].length >= 2) {
        latitude = location["coordinates"][0]?.toString() ?? "";
        longitude = location["coordinates"][1]?.toString() ?? "";
      }
    } else if (address["street"] != null) {
      streetName = address["street"]["name"];
      if (address["street"]["center"] != null && address["street"]["center"]["coordinates"] != null && address["street"]["center"]["coordinates"].length >= 2) {
        latitude = address["street"]["center"]["coordinates"][0].toString();
        longitude = address["street"]["center"]["coordinates"][1].toString();
      }
    }

    return ZipcodeAddressModel(
      city: city ?? "",
      country: country ?? "",
      district: district ?? "",
      houseNumber: houseNumber ?? "",
      streetName: streetName ?? "",
      state: state ?? "",
      latitude: latitude ?? "",
      longitude: longitude ?? "",
    );
  }
}
