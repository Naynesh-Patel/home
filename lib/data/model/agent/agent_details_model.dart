import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/data/model/auth/user_profile_model.dart';
import 'agent_single_property_model.dart';

class AgentDetailsModel extends Equatable {
  final UserProfileModel? agent;
  final int totalProperty;
  final int totalReview;
  final List<AgentSingleProperty>? properties;

  // "total_property": 1,
  // "total_review": 0,
  const AgentDetailsModel({
    required this.agent,
    required this.totalProperty,
    required this.totalReview,
    required this.properties,
  });

  AgentDetailsModel copyWith({
    UserProfileModel? agent,
    int? totalProperty,
    int? totalReview,
    List<AgentSingleProperty>? properties,
  }) {
    return AgentDetailsModel(
      agent: agent ?? this.agent,
      totalProperty: totalProperty ?? this.totalProperty,
      totalReview: totalReview ?? this.totalReview,
      properties: properties ?? this.properties,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'agent': agent?.toMap(),
      'total_property': totalProperty,
      'total_review': totalReview,
      'properties': properties!.map((x) => x.toMap()).toList(),
    };
  }

  factory AgentDetailsModel.fromMap(Map<String, dynamic> map) {
    return AgentDetailsModel(
      agent: map['agent'] != null
          ? UserProfileModel.fromMap(map['agent'] as Map<String, dynamic>)
          : null,
      totalProperty: map['total_property'] != null
          ? int.parse(map['total_property'].toString())
          : 0,
      totalReview: map['total_review'] != null
          ? int.parse(map['total_review'].toString())
          : 0,
      properties: map['properties']['data'] != null
          ? List<AgentSingleProperty>.from(
              (map['properties']['data'] as List<dynamic>)
                  .map<AgentSingleProperty?>(
                (x) => AgentSingleProperty.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory AgentDetailsModel.fromJson(String source) =>
      AgentDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        agent!,
        properties!,
        totalProperty,
        totalReview,
      ];
}
