import 'package:flutter/material.dart';

@immutable
class Address {
  // TODO: Make the address from known countries, states, cities
  // https://pub.dev/packages/country_state_city_picker
  final String streetAddress;
  final String city;
  final String provinceOrState;
  final String country;
  final String postalCode;

  Address(
      {@required this.streetAddress,
      @required this.city,
      @required this.provinceOrState,
      @required this.country,
      @required this.postalCode});

  Address.fromJSON(Map<String, dynamic> json)
      : streetAddress = json['streetAddress'],
        city = json['city'],
        provinceOrState = json['provinceOrState'],
        postalCode = json['postalCode'],
        country = json['country'];

  Map<String, dynamic> toJSON() => {
        'streetAddress': streetAddress,
        'city': city,
        'provinceOrState': provinceOrState,
        'country': country,
        'postalCode': postalCode
      };

  @override
  int get hashCode =>
      streetAddress.hashCode ^
      city.hashCode ^
      provinceOrState.hashCode ^
      country.hashCode ^
      postalCode.hashCode;

  @override
  bool operator ==(other) {
    return (other is Address) &&
        other.streetAddress == streetAddress &&
        other.city == city &&
        other.provinceOrState == provinceOrState &&
        other.country == country &&
        other.postalCode == postalCode;
  }

  String toString() =>
      '$streetAddress\n$city, $provinceOrState, $country, $postalCode';
}
