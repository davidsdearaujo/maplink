import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:maplink/src/domain/models/auth_user.dart';
import 'package:maplink/src/external/errors/geocoder_errors.dart';
import 'package:maplink/src/external/mappers/auth_user_mapper.dart';
import 'package:maplink/src/external/mappers/zipcode_address_model_mapper.dart';
import 'package:maplink/src/infra/datasources/geocoder_datasource.dart';

import '../../domain/models/zipcode_address_model.dart';

class GeocoderDatasourceImpl implements GeocoderDatasource {
  final Dio _client;

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

  @override
  Future<AuthUser> getAuthToken(String client_id, String client_secret) async {
    _client.options.headers = {
      "Content-Type": "application/x-www-form-urlencoded",
    };
    var response = await _client.post(
      'https://api.maplink.global/oauth/client_credential/accesstoken?grant_type=client_credentials',
      data: {
        'client_id': client_id,
        'client_secret': client_secret,
      },
    );

    return AuthUserMapper.fromMap(response.data);
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
    var response = await _client.post('https://api.maplink.global/geocode/v1/geocode',
        data: jsonEncode({
          if (zipcode != null) "zipcode": zipcode,
          if (streetName != null) "road": streetName,
          if (city != null) "city": city,
          if (state != null) "state": state,
          if (country != null) "country": country,
          if (houseNumber != null) "number": houseNumber,
        }),
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    return List<ZipcodeAddressModel>.from(response.data['results'].map((e) => ZipcodeAddressModelMapper.fromJson(e['address'])));
  }

  void throwMultipleErrorsIfExists(dynamic data) {
    if (data.statusCode == 200) {
      return;
    }

    if (data.statusCode == 400) {
      throw ErrorsMaplinkFailure([
        ErrorsMaplinkMessage(code: '400', errorMessage: 'Bad Request (falta de parâmetros ou envio incompleto ou requisição com erros)')
      ]);
    }

    if (data.statusCode == 500) {
      throw ErrorsMaplinkFailure([
        ErrorsMaplinkMessage(code: '500', errorMessage: 'An Internal Server Error occurred (erro interno no processamento da requisição)')
      ]);
    }

    if (data is Map && data["message"] != null) {
      final errors = data["message"] is String ? jsonDecode(data["message"]) as List : data["message"];
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
}
