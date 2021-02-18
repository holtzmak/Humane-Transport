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

  String toString() =>
      '$streetAddress\n$city, $provinceOrState, $country, $postalCode';
}
