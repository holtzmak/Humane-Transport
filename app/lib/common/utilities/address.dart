import 'package:flutter/material.dart';

@immutable
class Address {
  final String streetAddress;
  final String city;
  final String provinceOrState;
  final String country;
  final String postalCode;

  Address(
      {@required String streetAddress,
      @required String city,
      @required String provinceOrState,
      @required String country,
      @required String postalCode})
      : streetAddress = streetAddress,
        city = city,
        provinceOrState = provinceOrState,
        country = country,
        postalCode = postalCode;
}
