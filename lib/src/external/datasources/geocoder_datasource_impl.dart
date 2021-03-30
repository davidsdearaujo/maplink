import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maplink/src/external/errors/geocoder_errors.dart';
import 'package:maplink/src/external/mappers/zipcode_address_model_mapper.dart';
import 'package:maplink/src/infra/datasources/geocoder_datasource.dart';

import '../../domain/models/zipcode_address_model.dart';

class GeocoderDatasourceImpl implements GeocoderDatasource {
  final http.Client _client;

  GeocoderDatasourceImpl(this._client);

  @override
  Future<List<ZipcodeAddressModel>> getAddressByZipcodeAndHouseNumber(
    String token,
    String zipcode,
    String houseNumber,
  ) async {
    return await request(
      token: token,
      zipcode: zipcode,
      houseNumber: houseNumber,
    );
  }

  @override
  Future<List<ZipcodeAddressModel>> getAddressByStreetName(
    String token,
    String country,
    String city,
    String state,
    String streetName,
    String houseNumber,
  ) async {
    return await request(
      token: token,
      country: country,
      city: city,
      state: state,
      streetName: streetName,
      houseNumber: houseNumber,
    );
  }

  Future<List<ZipcodeAddressModel>> request({
    String token,
    String country,
    String city,
    String state,
    String streetName,
    String houseNumber,
    String zipcode,
  }) async {
    final uri = Uri.https("api.maplink.com.br", "/v0/geocode/geocode", {
      "token": token,
      if (zipcode != null) "postalCode": zipcode,
      if (streetName != null) "streetName": streetName,
      if (city != null) "city": city,
      if (state != null) "state": state,
      if (country != null) "country": country,
      if (houseNumber != null) "housenumber": houseNumber,
    });
    var request = http.Request('GET', uri);
    http.StreamedResponse apiResponse = await _client.send(request);
    String data;
    if (apiResponse.statusCode == 200) {
      data = await apiResponse.stream.bytesToString();
    } else {
      print(apiResponse.reasonPhrase);
    }
    if (data == null) throw NullDatasourceResponseFailure();
    final json = jsonDecode(data);
    throwMultipleErrorsIfExists(json);
    throwSingleErrorsIfExists(json);
    final List addressList = json["addresses"];
    if (addressList == null) throw EmptyDatasourceResponseFailure();

    final response = addressList.map(ZipcodeAddressModelMapper.fromJson);
    return response.toList().cast<ZipcodeAddressModel>();
  }

  void throwMultipleErrorsIfExists(dynamic json) {
    if (json is Map && json["message"] != null) {
      final errors = json["message"] is String ? jsonDecode(json["message"]) as List : json["message"];
      final parsedErrors = errors.map((error) => ErrorsMaplinkMessage(code: error["Code"], errorMessage: error["Message"]));
      throw ErrorsMaplinkFailure(parsedErrors.toList().cast<ErrorsMaplinkMessage>());
    }
  }

  void throwSingleErrorsIfExists(dynamic json) {
    if (json is Map && json["status"] != null) {
      final error = ErrorsMaplinkMessage(code: json["status"]["code"], errorMessage: json["status"]["message"]);
      throw ErrorsMaplinkFailure([error]);
    }
  }
}
