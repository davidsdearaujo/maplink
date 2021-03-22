import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

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
  late String _token;
  String get token => _token;

  Maplink(String token) {
    _token = token;
    final client = Client();
    final datasource = GeocoderDatasourceImpl(client);
    final repository = GeocoderRepositoryImpl(datasource);
    _getAddressByStreetName = GetAddressByStreetName(repository);
    _getAddressByZipcodeAndHouseNumber = GetAddressByZipcodeAndHouseNumber(repository);
  }

  Future<List<ZipcodeAddressModel>> getAddressByZipcodeAndHouseNumber(
    String zipcode, [
    String? houseNumber,
  ]) async {
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
