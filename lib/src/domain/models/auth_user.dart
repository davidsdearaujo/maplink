class AuthUser {
  AuthUser({
    required this.refreshTokenExpiresIn,
    required this.apiProductList,
    required this.organizationName,
    required this.developerEmail,
    required this.tokenType,
    required this.issuedAt,
    required this.clientId,
    required this.accessToken,
    required this.applicationName,
    required this.scope,
    required this.expiresIn,
    required this.refreshCount,
    required this.status,
  });

  String refreshTokenExpiresIn;
  String apiProductList;
  String organizationName;
  String developerEmail;
  String tokenType;
  String issuedAt;
  String clientId;
  String accessToken;
  String applicationName;
  String scope;
  String expiresIn;
  String refreshCount;
  String status;
}
