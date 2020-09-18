import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:maplink/src/domain/errors/failure.dart';
import 'package:maplink/src/domain/errors/presentation.dart';
import 'package:maplink/src/domain/models/zipcode_address_model.dart';
import 'package:maplink/src/domain/usecases/get_address_by_zipcode_and_house_number.dart';
import 'package:maplink/src/external/datasources/geocoder_datasource_impl.dart';
import 'package:maplink/src/infra/repositories/geocoder_repository_impl.dart';

class Maplink {
  GetAddressByZipcodeAndHouseNumber _getAddressByZipcodeAndHouseNumber;
  String _token;
  String get token => _token;

  Maplink(String token) {
    _token = token;
    final client = Client();
    final datasource = GeocoderDatasourceImpl(client);
    final repository = GeocoderRepositoryImpl(datasource);
    _getAddressByZipcodeAndHouseNumber =
        GetAddressByZipcodeAndHouseNumber(repository);
  }

  Future<List<ZipcodeAddressModel>> getAddressByZipcodeAndHouseNumber(
    String zipcode, [
    String houseNumber,
  ]) async {
    final response = await _getAddressByZipcodeAndHouseNumber(
      token: token,
      zipcode: zipcode,
      houseNumber: houseNumber,
    );

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
