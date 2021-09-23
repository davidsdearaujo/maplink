class ZipcodeAddressModel {
  final String? state;
  final String? city;
  final String? district;
  final String? streetName;
  final String? houseNumber;
  final String? latitude;
  final String? longitude;

  ZipcodeAddressModel({
    this.state,
    this.city,
    this.district,
    this.streetName,
    this.houseNumber,
    this.latitude,
    this.longitude,
  });

  @override
  String toString() {
    return 'ZipcodeAddressModel( state: $state, city: $city, district: $district, streetName: $streetName, houseNumber: $houseNumber, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ZipcodeAddressModel &&
        o.state == state &&
        o.city == city &&
        o.district == district &&
        o.streetName == streetName &&
        o.houseNumber == houseNumber &&
        o.latitude == latitude &&
        o.longitude == longitude;
  }

  @override
  int get hashCode {
    return state.hashCode ^
        city.hashCode ^
        district.hashCode ^
        streetName.hashCode ^
        houseNumber.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}
