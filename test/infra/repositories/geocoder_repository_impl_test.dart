import 'package:dartz/dartz.dart';
import 'package:maplink/src/domain/models/zipcode_address_model.dart';
import 'package:maplink/src/infra/datasources/geocoder_datasource.dart';
import 'package:maplink/src/infra/repositories/geocoder_repository_impl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGeocoderDatasource extends Mock implements GeocoderDatasource {}

void main() {
  late MockGeocoderDatasource datasource;
  late GeocoderRepositoryImpl repository;

  setUp(() {
    datasource = MockGeocoderDatasource();
    repository = GeocoderRepositoryImpl(datasource);
  });

  final successMockResponse = [
    ZipcodeAddressModel(
      state: "SP",
      city: "São Paulo",
      country: "BRA",
      district: "Mooca",
      streetName: "Rua Guaimbé",
      houseNumber: "156",
      latitude: "0",
      longitude: "0",
    )
  ];

  group("Sucesso", () {
    test("getAddressByZipcodeAndHouseNumber", () async {
      when(() => datasource.getAddressByZipcodeAndHouseNumber(
            any(),
            any(),
            any(),
          )).thenAnswer((realInvocation) async => successMockResponse);
      final response = await repository.getAddressByZipcodeAndHouseNumber(
        "mock-token",
        "mock-zipcode",
        "mock-houseNumber",
      );
      expect(response.fold(id, id), successMockResponse);
    });

    test("getAddressByStreetName", () async {
      when(() => datasource.getAddressByStreetName(any(), any(), any(), any(), any(), any())).thenAnswer((realInvocation) async => successMockResponse);
      final response = await repository.getAddressByStreetName(
        "mock-token",
        "mock-country",
        "mock-city",
        "mock-state",
        "mock-streetName",
        "mock-houseNumber",
      );
      expect(response.fold(id, id), successMockResponse);
    });
  });
}
