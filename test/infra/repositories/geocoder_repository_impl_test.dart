import 'package:maplink/src/domain/models/zipcode_address_model.dart';
import 'package:maplink/src/infra/datasources/geocoder_datasource.dart';
import 'package:maplink/src/infra/repositories/geocoder_repository_impl.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockGeocoderDatasource extends Mock implements GeocoderDatasource {}

void main() {
  MockGeocoderDatasource datasource;
  GeocoderRepositoryImpl repository;

  setUp(() {
    datasource = MockGeocoderDatasource();
    repository = GeocoderRepositoryImpl(datasource);
  });

  group("Sucesso", () {
    test("", () async {
      final token = "mock-token";
      final zipcode = "mock-zipcode";
      final houseNumber = "mock-houseNumber";
      final mockResponse = [
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

      when(datasource.getAddressByZipcodeAndHouseNumber(
        token,
        zipcode,
        houseNumber,
      )).thenAnswer((realInvocation) async => mockResponse);

      final response = await repository.getAddressByZipcodeAndHouseNumber(
        token,
        zipcode,
        houseNumber,
      );

      expect(response | null, mockResponse);
    });
  });
}
