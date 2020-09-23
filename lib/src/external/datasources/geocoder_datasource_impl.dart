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
      String token, String zipcode, String houseNumber) async {
    final uri = Uri.https("api.maplink.com.br", "/v0/geocode/geocode", {
      "token": token,
      "postalCode": zipcode,
      if (houseNumber != null) "housenumber": houseNumber,
    });
    final data = await _client.get(uri);

    if (data == null) throw NullDatasourceResponseFailure();

    final json = jsonDecode(data.body);
    if (json is Map && json["message"] != null) {
      final errors = json["message"] is String
          ? jsonDecode(json["message"]) as List
          : json["message"];
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
    final List addressList = json["addresses"];
    if (addressList == null) throw EmptyDatasourceResponseFailure();

    final response = addressList.map(ZipcodeAddressModelMapper.fromJson);
    return response.toList().cast<ZipcodeAddressModel>();
  }

  @override
  Future<List<ZipcodeAddressModel>> getAddressByStreetName(
    String token,
    String country,
    String city,
    String state,
    String streetName,
    String housenumber,
  ) {
    // TODO: implement getAddressByStreetName
    throw UnimplementedError();
  }
}
