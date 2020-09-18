class Failure implements Exception {
  final String code;
  final String message;
  final Exception innerException;

  Failure(this.code, {this.message, this.innerException});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is Failure && o.code == code;
  }

  @override
  int get hashCode => code.hashCode ^ message.hashCode;

  @override
  String toString() => 'Failure(code: $code, message: $message)';

  Failure copyWith({
    String code,
    String message,
    Exception innerException,
  }) {
    return Failure(
      code ?? this.code,
      message: message ?? this.message,
      innerException: innerException ?? this.innerException,
    );
  }
}
