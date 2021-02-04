import 'package:flutter/material.dart';

@immutable
class Address {
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

  String toString() => '''
  $streetAddress
  $city, $provinceOrState, $country, $postalCode
  ''';
}
