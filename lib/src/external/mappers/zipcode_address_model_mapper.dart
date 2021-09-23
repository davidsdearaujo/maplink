import 'package:maplink/src/domain/models/zipcode_address_model.dart';

class ZipcodeAddressModelMapper {
  static ZipcodeAddressModel? fromJson(dynamic address) {
    if (address == null) return null;
    if (!(address is Map)) return null;

    String? state;
    String? city;
    String? district;
    String? houseNumber;
    String? streetName;
    String? latitude;
    String? longitude;

    if (address["state"] != null) {
      state = address["state"]["code"];
    }
    if (address["city"] != null) {
      city = address["city"];
    }
    if (address["district"] != null) {
      district = address["district"];
    }
    if (address["addressLine"] != null) {
      houseNumber = address["addressLine"]["houseNumber"];
      streetName = address["addressLine"]["name"];
      final location = address["addressLine"]["location"];
      if (location != null && location["coordinates"] != null && location["coordinates"].length >= 2) {
        latitude = location["coordinates"][0]?.toString() ?? "";
        longitude = location["coordinates"][1]?.toString() ?? "";
      }
    }

    if (address["number"] != null) {
      houseNumber = address["number"];
    }

    if (address["road"] != null) {
      streetName = address["road"];
    }

    if (address["mainLocation"] != null) {
      latitude = address["mainLocation"]['lat'].toString();
      longitude = address["mainLocation"]['lon'].toString();
    }

    return ZipcodeAddressModel(
      city: city ?? "",
      district: district ?? "",
      houseNumber: houseNumber ?? "",
      streetName: streetName ?? "",
      state: state ?? "",
      latitude: latitude ?? "",
      longitude: longitude ?? "",
    );
  }
}
