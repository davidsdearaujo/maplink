//import 'package:http/http.dart';
import 'package:dio/dio.dart';

Response get successResponse => Response(
      data: _responseMockString,
      requestOptions: RequestOptions(path: ''),
      statusCode: 200,
      headers: Headers()..add("Content-Type", "application/json"),
    );
Response get unauthorizedErrorResponse => Response(
      data: _multipleErrorsResponseString,
      requestOptions: RequestOptions(path: ''),
      statusCode: 401,
      headers: Headers()..add("Content-Type", "application/json; charset=utf-8"),
    );
Response get invalidCountryErrorResponse => Response(
      data: _singleErrorResponseString,
      requestOptions: RequestOptions(path: ''),
      statusCode: 401,
      headers: Headers()..add("Content-Type", "application/json; charset=utf-8"),
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
    "state": {
        "code": "SP",
        "name": "São Paulo"
    },
    "city":  "São Paulo",    
    "district": "Jardim Paulista",    
    "number": "365",
    "mainLocation": {     
      "lat": -46.652355,
      "lon":   -23.564986        
    },
    "road": "Alameda Campinas",  
    "matchingScore": 100.0,
    "matchLevel": "approximatedAddress",
    "consideredFields": "state,city,district,streetName,houseNumber,postalCode"
}''';
