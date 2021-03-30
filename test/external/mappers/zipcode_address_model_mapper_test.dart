import 'dart:convert';

import 'package:maplink/src/domain/models/zipcode_address_model.dart';
import 'package:maplink/src/external/mappers/zipcode_address_model_mapper.dart';
import 'package:test/test.dart';

import '../datasources/geocoder_mock.dart';

void main() {
  late ZipcodeAddressModel model;
  setUp(() {
    final addressJson = jsonDecode(responseMockSingleString);
    model = ZipcodeAddressModelMapper.fromJson(addressJson);
  });

  test("city", () => expect(model.city, "São Paulo"));
  test("country", () => expect(model.country, "BRA"));
  test("district", () => expect(model.district, "Jardim Paulista"));
  test("houseNumber", () => expect(model.houseNumber, "365"));
  test("latitude", () => expect(model.latitude, "-46.652355"));
  test("longitude", () => expect(model.longitude, "-23.564986"));
  test("state", () => expect(model.state, "SP"));
  test("streetName", () => expect(model.streetName, "Alameda Campinas"));
}
