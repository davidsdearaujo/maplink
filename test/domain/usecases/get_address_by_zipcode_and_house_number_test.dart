import 'package:dartz/dartz.dart';
import 'package:maplink/src/domain/errors/usecases.dart';
import 'package:maplink/src/domain/models/zipcode_address_model.dart';
import 'package:maplink/src/domain/repositories/geocoder_repository.dart';
import 'package:maplink/src/domain/usecases/get_address_by_zipcode_and_house_number.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGeocoderRepository extends Mock implements GeocoderRepository {}

void main() {
  late MockGeocoderRepository repository;
  late GetAddressByZipcodeAndHouseNumber usecase;

  setUp(() {
    repository = MockGeocoderRepository();
    usecase = GetAddressByZipcodeAndHouseNumber(repository);
  });

  group("Sucesso", () {
    test("houseNumber padrão", () async {
      final token = "mock-token";
      final zipcode = "mock-zipcode";
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

      when(() => repository.getAddressByZipcodeAndHouseNumber(any(), any(), any())).thenAnswer((realInvocation) async => Right(mockResponse));

      final response = await usecase(
        token: token,
        zipcode: zipcode,
      );

      expect(response.fold(id, id), mockResponse);
    });
    test("houseNumber null", () async {
      final token = "mock-token";
      final zipcode = "mock-zipcode";
      final houseNumber = null;
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

      when(() => repository.getAddressByZipcodeAndHouseNumber(any(), any(), any())).thenAnswer((realInvocation) async => Right(mockResponse));

      final response = await usecase(
        token: token,
        zipcode: zipcode,
        houseNumber: houseNumber,
      );

      expect(response.fold(id, id), mockResponse);
    });
    test("houseNumber vazio", () async {
      final token = "mock-token";
      final zipcode = "mock-zipcode";
      final houseNumber = "";
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

      when(() => repository.getAddressByZipcodeAndHouseNumber(any(), any(), any())).thenAnswer((realInvocation) async => Right(mockResponse));

      final response = await usecase(
        token: token,
        zipcode: zipcode,
        houseNumber: houseNumber,
      );

      expect(response.fold(id, id), mockResponse);
    });
    test("houseNumber '123'", () async {
      final token = "mock-token";
      final zipcode = "mock-zipcode";
      final houseNumber = "123";
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

      when(() => repository.getAddressByZipcodeAndHouseNumber(any(), any(), any())).thenAnswer((realInvocation) async => Right(mockResponse));

      final response = await usecase(
        token: token,
        zipcode: zipcode,
        houseNumber: houseNumber,
      );

      expect(response.fold(id, id), mockResponse);
    });
  });

  group("Erro", () {
    // Token não pode ser nulo
    // test("NullTokenFailure", () async {
    //   final token = null;
    //   final zipcode = "mock-zipcode";
    //   final houseNumber = "123";
    //   final mockResponse = [
    //     ZipcodeAddressModel(
    //       state: "SP",
    //       city: "São Paulo",
    //       country: "BRA",
    //       district: "Mooca",
    //       streetName: "Rua Guaimbé",
    //       houseNumber: "156",
    //       latitude: "0",
    //       longitude: "0",
    //     )
    //   ];

    //   when(() => repository.getAddressByZipcodeAndHouseNumber(any(), any(), any())).thenAnswer((realInvocation) async => Right(mockResponse));

    //   final response = await usecase(
    //     token: token,
    //     zipcode: zipcode,
    //     houseNumber: houseNumber,
    //   ).then((value) => value.fold(id, id));

    //   expect(response, NullTokenFailure());
    // });
    test("EmptyTokenFailure", () async {
      final token = "";
      final zipcode = "mock-zipcode";
      final houseNumber = "123";
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

      when(() => repository.getAddressByZipcodeAndHouseNumber(any(), any(), any())).thenAnswer((realInvocation) async => Right(mockResponse));

      final response = await usecase(
        token: token,
        zipcode: zipcode,
        houseNumber: houseNumber,
      ).then((value) => value.fold(id, id));

      expect(response, EmptyTokenFailure());
    });
    // Zipcode não pode ser nulo
    // test("NullZipcodeFailure", () async {
    //   final token = "mock-token";
    //   final zipcode = null;
    //   final houseNumber = "123";
    //   final mockResponse = [
    //     ZipcodeAddressModel(
    //       state: "SP",
    //       city: "São Paulo",
    //       country: "BRA",
    //       district: "Mooca",
    //       streetName: "Rua Guaimbé",
    //       houseNumber: "156",
    //       latitude: "0",
    //       longitude: "0",
    //     )
    //   ];

    //   when(() => repository.getAddressByZipcodeAndHouseNumber(any(), any(), any())).thenAnswer((realInvocation) async => Right(mockResponse));

    //   final response = await usecase(
    //     token: token,
    //     zipcode: zipcode,
    //     houseNumber: houseNumber,
    //   ).then((value) => value.fold(id, id));

    //   expect(response, InvalidFieldFailure("zipcode"));
    // });
    test("EmptyZipcodeFailure", () async {
      final token = "mock-token";
      final zipcode = "";
      final houseNumber = "123";
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

      when(() => repository.getAddressByZipcodeAndHouseNumber(any(), any(), any())).thenAnswer((realInvocation) async => Right(mockResponse));

      final response = await usecase(
        token: token,
        zipcode: zipcode,
        houseNumber: houseNumber,
      ).then((value) => value.fold(id, id));

      expect(response, InvalidFieldFailure("zipcode"));
    });
  });
}
