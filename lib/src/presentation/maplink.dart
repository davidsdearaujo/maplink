import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maplink/src/domain/usecases/get_auth_token.dart';

import '../domain/errors/failure.dart';
import '../domain/errors/presentation.dart';
import '../domain/models/zipcode_address_model.dart';
import '../domain/usecases/get_address_by_street_name.dart';
import '../domain/usecases/get_address_by_zipcode_and_house_number.dart';
import '../external/datasources/geocoder_datasource_impl.dart';
import '../infra/repositories/geocoder_repository_impl.dart';

class Maplink {
  late GetAddressByStreetName _getAddressByStreetName;
  late GetAddressByZipcodeAndHouseNumber _getAddressByZipcodeAndHouseNumber;
  late GetAuthToken _getAuthToken;

  Future<String> getToken() async {
    var result = await _getAuthToken.call(client_id: clientId, client_secret: clientSecret);
    return result.fold((l) => '', (r) => r.accessToken);
  }

  final String clientId;
  final String clientSecret;

  Maplink({required this.clientId, required this.clientSecret}) {
    final client = Dio();
    final datasource = GeocoderDatasourceImpl(client);
    final repository = GeocoderRepositoryImpl(datasource);
    _getAddressByStreetName = GetAddressByStreetName(repository);
    _getAddressByZipcodeAndHouseNumber = GetAddressByZipcodeAndHouseNumber(repository);
    _getAuthToken = GetAuthToken(repository);
  }

  Future<List<ZipcodeAddressModel>> getAddressByZipcodeAndHouseNumber(
    String zipcode, [
    String? houseNumber,
  ]) async {
    var token = await getToken();

    final response = await _getAddressByZipcodeAndHouseNumber(
      token: token,
      zipcode: zipcode,
      houseNumber: houseNumber,
    );
    final data = responseProcess(response);
    return data;
  }

  ///|campo|descrição|valor padrão|
  ///|:-:|:-:|:-:|
  ///|country|`ISO 3166-1 alpha-3 country code`|BRA|
  Future<List<ZipcodeAddressModel>> getAddressByStreetName({
    required String city,
    required String state,
    required String streetName,
    String? country,
    String? housenumber,
  }) async {
    var token = await getToken();

    final response = await _getAddressByStreetName(
      token: token,
      city: city,
      state: state,
      streetName: streetName,
      country: country,
      housenumber: housenumber,
    );
    final data = responseProcess(response);
    return data;
  }

  dynamic responseProcess(Either response) {
    final data = response.fold(id, id);
    if (response.isRight()) {
      return data;
    } else if (response.isLeft() && data is Failure) {
      throw data;
    } else {
      throw PresentationFailure(data);
    }
  }
}
