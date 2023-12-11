// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class PropertyLocationDto extends Equatable {
  final int cityId;
  final String address;
  final String addressDescription;
  final String googleMap;
  const PropertyLocationDto({
    required this.cityId,
    required this.address,
    required this.addressDescription,
    required this.googleMap,
  });

  PropertyLocationDto copyWith({
    int? cityId,
    String? address,
    String? addressDescription,
    String? googleMap,
  }) {
    return PropertyLocationDto(
      cityId: cityId ?? this.cityId,
      address: address ?? this.address,
      addressDescription: addressDescription ?? this.addressDescription,
      googleMap: googleMap ?? this.googleMap,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'city_id': cityId,
      'address': address,
      'address_description': addressDescription,
      'google_map': googleMap,
    };
  }

  factory PropertyLocationDto.fromMap(Map<String, dynamic> map) {
    return PropertyLocationDto(
      cityId: map['city_id'] as int,
      address: map['address'] as String,
      addressDescription: map['address_description'] as String,
      googleMap: map['google_map'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PropertyLocationDto.fromJson(String source) =>
      PropertyLocationDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [cityId, address, addressDescription, googleMap];
}
