import 'package:http/http.dart';

Response get successResponse => Response(
      _responseMockString,
      200,
      headers: {"Content-Type": "application/json"},
    );
Response get unauthorizedErrorResponse => Response(
      _multipleErrorsResponseString,
      401,
      headers: {"Content-Type": "application/json; charset=utf-8"},
    );
Response get invalidCountryErrorResponse => Response(
      _singleErrorResponseString,
      401,
      headers: {"Content-Type": "application/json; charset=utf-8"},
    );

final _multipleErrorsResponseString =
    r'{"message": "[{\"Code\":\"INVALID_APP_CODE_OR_TOKEN\",\"Message\":\"The informed token or application code [your-token] is not valid\"}]"}';
final _singleErrorResponseString = '''{
    "status": {
        "code": "ERROR",
        "message": "[BRAA] is an invalid ISO 3166-1 alpha-3 country code or there is no geocoding for the country"
    }
}''';
final _responseMockString = '''{"addresses": [$responseMockSingleString]}''';
final responseMockSingleString = '''{
    "country": {
        "countryCode": "BRA"
    },
    "state": {
        "shortName": "SP",
        "name": "São Paulo"
    },
    "city": {
        "name": "São Paulo"
    },
    "citySubdivision": {
        "name": "Jardim Paulista"
    },
    "district": {
        "name": "Jardim Paulista"
    },
    "addressLine": {
        "houseNumber": "365",
        "location": {
            "type": "Point",
            "coordinates": [
                -46.652355,
                -23.564986
            ]
        },
        "name": "Alameda Campinas"
    },
    "matchingScore": 100.0,
    "matchLevel": "approximatedAddress",
    "consideredFields": "state,city,district,streetName,houseNumber,postalCode"
}''';
