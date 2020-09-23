import 'package:maplink/src/domain/errors/repository.dart';
import 'package:maplink/src/domain/models/zipcode_address_model.dart';

import 'package:maplink/src/domain/errors/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:maplink/src/infra/datasources/geocoder_datasource.dart';

import '../../domain/repositories/geocoder_repository.dart';

class GeocoderRepositoryImpl implements GeocoderRepository {
  final GeocoderDatasource _datasource;
  GeocoderRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, List<ZipcodeAddressModel>>>
      getAddressByZipcodeAndHouseNumber(
    String token,
    String zipcode,
    String houseNumber,
  ) async {
    try {
      final response = await _datasource.getAddressByZipcodeAndHouseNumber(
        token,
        zipcode,
        houseNumber,
      );
      return right(response);
    } on Failure catch (exception) {
      return left(exception);
    } on Exception catch (exception) {
      return left(DatasourceExceptionFailure(
        "geocoder-datasource-exception",
        exception,
      ));
    } catch (error) {
      return left(DatasourceExceptionFailure(
        "geocoder-datasource-unexpected-throw",
        Exception(error),
      ));
    }
  }

  @override
  Future<Either<Failure, List<ZipcodeAddressModel>>> getAddressByStreetName(
    String token,
    String country,
    String city,
    String state,
    String streetName,
    String housenumber,
  ) async {
    try {
      final response = await _datasource.getAddressByStreetName(
        token,
        country,
        city,
        state,
        streetName,
        housenumber,
      );
      return right(response);
    } on Failure catch (exception) {
      return left(exception);
    } on Exception catch (exception) {
      return left(DatasourceExceptionFailure(
        "geocoder-datasource-exception",
        exception,
      ));
    } catch (error) {
      return left(DatasourceExceptionFailure(
        "geocoder-datasource-unexpected-throw",
        Exception(error),
      ));
    }
  }
}
