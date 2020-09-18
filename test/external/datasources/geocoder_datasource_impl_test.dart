import 'package:http/http.dart';
import 'package:maplink/src/external/datasources/geocoder_datasource_impl.dart';
import 'package:maplink/src/external/errors/geocoder_errors.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'geocoder_mock.dart';

class MockClient extends Mock implements Client {}

void main() {
  MockClient client;
  GeocoderDatasourceImpl datasource;
  setUp(() {
    client = MockClient();
    datasource = GeocoderDatasourceImpl(client);
  });

  test("success", () async {
    final zipcode = "mock-search";
    final number = "mock-number";
    final token = "mock-token";
    when(client.get(any)).thenAnswer((realInvocation) async => successResponse);
    final content = await datasource.getAddressByZipcodeAndHouseNumber(
      token,
      zipcode,
      number,
    );
    expect(content?.length, 1);
    // expect(content, isA<List<ZipcodeAddressModel>>());
  });
  test("invalid token error", () async {
    final zipcode = "mock-search";
    final number = "mock-number";
    final token = "mock-token";
    final error = ErrorsMaplinkFailure([
      ErrorsMaplinkMessage(
        code: "INVALID_APP_CODE_OR_TOKEN",
        errorMessage:
            "The informed token or application code [your-token] is not valid",
      )
    ]);
    when(client.get(any))
        .thenAnswer((realInvocation) async => unauthorizedErrorResponse);
    final content = datasource.getAddressByZipcodeAndHouseNumber(
      token,
      zipcode,
      number,
    );
    expect(content, throwsA(error));
  });
}
