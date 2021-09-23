import 'package:maplink/src/domain/models/auth_user.dart';

class AuthUserMapper {
  static AuthUser fromMap(Map<dynamic, dynamic> map) {
    return AuthUser(
      refreshTokenExpiresIn: map['refresh_token_expires_in'],
      accessToken: map['access_token'],
      organizationName: map['organization_name'],
      developerEmail: map['developer.email'],
      tokenType: map['token_type'],
      issuedAt: map['issued_at'],
      clientId: map['client_id'],
      scope: map['scope'],
      applicationName: map['application_name'],
      expiresIn: map['expires_in'],
      refreshCount: map['refresh_count'],
      status: map['status'],
      apiProductList: map['api_product_list'],
    );
  }
}
