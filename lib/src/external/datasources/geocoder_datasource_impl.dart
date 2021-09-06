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
    String? houseNumber,
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
    String? houseNumber,
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
    required String token,
    String? country,
    String? city,
    String? state,
    String? streetName,
    String? houseNumber,
    String? zipcode,
  }) async {
    var uri = Uri.https("api.maplink.global", "geocode/v1/geocode", {
      "token": token,
      if (zipcode != null) "postalCode": zipcode,
      if (streetName != null) "streetName": streetName,
      if (city != null) "city": city,
      if (state != null) "state": state,
      if (country != null) "country": country,
      if (houseNumber != null) "housenumber": houseNumber,
    });

    var request = await _client.post(uri);

    final json = jsonDecode(request.body);

    throwMultipleErrorsIfExists(json);
    throwSingleErrorsIfExists(json);

    final List addressList = json["addresses"];
    final response = addressList.map(ZipcodeAddressModelMapper.fromJson);
    return response.toList().cast<ZipcodeAddressModel>();
  }

  void throwMultipleErrorsIfExists(dynamic json) {
    if (json is Map && json["message"] != null) {
      final errors = json["message"] is String ? jsonDecode(json["message"]) as List : json["message"];
      final parsedErrors = errors.map(
        (error) => ErrorsMaplinkMessage(
          code: error["Code"],
          errorMessage: error["Message"],
        ),
      );
      throw ErrorsMaplinkFailure(
        parsedErrors.toList().cast<ErrorsMaplinkMessage>(),
      );
    }
  }

  void throwSingleErrorsIfExists(dynamic json) {
    if (json is Map && (json["status"] != null || json["fault"] != null)) {
      final error = ErrorsMaplinkMessage(
        code: json["status"]?["code"] ?? json["fault"]["detail"]["errorcode"],
        errorMessage: json["status"]?["message"] ?? json["fault"]["faultstring"],
      );
      throw ErrorsMaplinkFailure([error]);
    }
  }
}
