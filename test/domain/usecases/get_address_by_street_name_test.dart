import 'package:dartz/dartz.dart';
import 'package:maplink/src/domain/errors/usecases.dart';
import 'package:maplink/src/domain/models/zipcode_address_model.dart';
import 'package:maplink/src/domain/repositories/geocoder_repository.dart';
import 'package:maplink/src/domain/usecases/get_address_by_street_name.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGeocoderRepository extends Mock implements GeocoderRepository {}

void main() {
  late MockGeocoderRepository repository;
  late GetAddressByStreetName usecase;

  setUp(() {
    repository = MockGeocoderRepository();
    usecase = GetAddressByStreetName(repository);
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
    test("todos os campos preenchidos", () async {
      when(() => repository.getAddressByStreetName(any(), any(), any(), any(), any(), any())).thenAnswer((realInvocation) async => Right(successMockResponse));

      final response = await usecase(
        token: "mock-token",
        city: "São Paulo",
        state: "SP",
        streetName: "Rua Guaimbé",
        housenumber: "156",
      );

      expect(response.fold(id, id), successMockResponse);
    });
    test("housenumber default", () async {
      when(() => repository.getAddressByStreetName(any(), any(), any(), any(), any(), any())).thenAnswer((realInvocation) async => Right(successMockResponse));

      final response = await usecase(
        token: "mock-token",
        city: "São Paulo",
        state: "SP",
        streetName: "Rua Guaimbé",
      );

      expect(response.fold(id, id), successMockResponse);
    });
    test("housenumber null", () async {
      when(() => repository.getAddressByStreetName(any(), any(), any(), any(), any(), any())).thenAnswer((realInvocation) async => Right(successMockResponse));

      final response = await usecase(
        token: "mock-token",
        city: "São Paulo",
        state: "SP",
        streetName: "Rua Guaimbé",
        housenumber: null,
      );

      expect(response.fold(id, id), successMockResponse);
    });
  });

  group("Erro", () {
    // Token não é nulável
    // test("NullTokenFailure", () async {
    //   when(() => repository.getAddressByStreetName(any(), any(), any(), any(), any(), any())).thenAnswer((realInvocation) async => Right(successMockResponse));

    //   final response = await usecase(
    //     token: null,
    //     city: "São Paulo",
    //     state: "SP",
    //     streetName: "Rua Guaimbé",
    //     housenumber: null,
    //   ).then((value) => value.fold(id, id));

    //   expect(response, NullTokenFailure());
    // });
    test("EmptyTokenFailure", () async {
      when(() => repository.getAddressByStreetName(any(), any(), any(), any(), any(), any())).thenAnswer((realInvocation) async => Right(successMockResponse));

      final response = await usecase(
        token: "",
        city: "São Paulo",
        state: "SP",
        streetName: "Rua Guaimbé",
        housenumber: null,
      ).then((value) => value.fold(id, id));

      expect(response, EmptyTokenFailure());
    });
    group("InvalidFieldFailure -", () {
      // City não é nulável
      //group("city", () {
      // test("default", () async {
      //   when(() => repository.getAddressByStreetName(any(), any(), any(), any(), any(), any())).thenAnswer((realInvocation) async => Right(successMockResponse));

      //   // ignore: missing_required_param
      //   final response = await usecase(
      //     token: "mock-token",
      //     state: "SP",
      //     streetName: "Rua Guaimbé",
      //   ).then((value) => value.fold(id, id));
      //   expect(response, InvalidFieldFailure("city"));
      // });

      // Teste com nulo não é necessário
      //   final _valuesTest = {
      //     "null": null,
      //     "empty": ""
      //   };
      //   for (final currentValueTest in _valuesTest.entries) {
      //     test("${currentValueTest.key}", () async {
      //       when(() => repository.getAddressByStreetName(any(), any(), any(), any(), any(), any())).thenAnswer((realInvocation) async => Right(successMockResponse));

      //       final response = await usecase(
      //         token: "mock-token",
      //         city: currentValueTest.value,
      //         state: "SP",
      //         streetName: "Rua Guaimbé",
      //       ).then((value) => value.fold(id, id));
      //       expect(response, InvalidFieldFailure("city"));
      //     });
      //   }
      // });

      // Teste com nulo não é necessário
      // group("state", () {
      //   test("default", () async {
      //     when(() => repository.getAddressByStreetName(any(), any(), any(), any(), any(), any())).thenAnswer((realInvocation) async => Right(successMockResponse));

      //     // ignore: missing_required_param
      //     final response = await usecase(
      //       token: "mock-token",
      //       city: "São Paulo",
      //       streetName: "Rua Guaimbé",
      //     ).then((value) => value.fold(id, id));
      //     expect(response, InvalidFieldFailure("state"));
      //   });

      //   final _valuesTest = {
      //     "null": null,
      //     "empty": ""
      //   };
      //   for (final currentValueTest in _valuesTest.entries) {
      //     test("${currentValueTest.key}", () async {
      //       when(() => repository.getAddressByStreetName(any(), any(), any(), any(), any(), any())).thenAnswer((realInvocation) async => Right(successMockResponse));

      //       final response = await usecase(
      //         token: "mock-token",
      //         city: "São Paulo",
      //         state: currentValueTest.value,
      //         streetName: "Rua Guaimbé",
      //       ).then((value) => value.fold(id, id));
      //       expect(response, InvalidFieldFailure("state"));
      //     });
      //   }
      // });

      // Rua não é nulável
      // group("streetName", () {
      //   test("default", () async {
      //     when(() => repository.getAddressByStreetName(any(), any(), any(), any(), any(), any())).thenAnswer((realInvocation) async => Right(successMockResponse));

      //     // ignore: missing_required_param
      //     final response = await usecase(
      //       token: "mock-token",
      //       city: "São Paulo",
      //       state: "SP",
      //     ).then((value) => value.fold(id, id));
      //     expect(response, InvalidFieldFailure("streetName"));
      //   });

      //   final _valuesTest = {
      //     "null": null,
      //     "empty": ""
      //   };
      //   for (final currentValueTest in _valuesTest.entries) {
      //     test("${currentValueTest.key}", () async {
      //       when(() => repository.getAddressByStreetName(any(), any(), any(), any(), any(), any())).thenAnswer((realInvocation) async => Right(successMockResponse));

      //       final response = await usecase(
      //         token: "mock-token",
      //         city: "São Paulo",
      //         state: "SP",
      //         streetName: currentValueTest.value,
      //       ).then((value) => value.fold(id, id));
      //       expect(response, InvalidFieldFailure("streetName"));
      //     });
      //   }
      // });
    });
  });
}
