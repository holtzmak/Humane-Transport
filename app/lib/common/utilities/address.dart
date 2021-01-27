import 'package:flutter/material.dart';

@immutable
class Address {
  final String streetAddress;
  final String city;
  final String provinceOrState;
  final String country;
  final String postalCode;

  Address(this.streetAddress, this.city, this.provinceOrState, this.country,
      this.postalCode);
}
