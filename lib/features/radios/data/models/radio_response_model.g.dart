// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radio_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadioResponseModel _$RadioResponseModelFromJson(Map<String, dynamic> json) =>
    RadioResponseModel(
      radios: (json['radios'] as List<dynamic>?)
          ?.map((e) => RadioData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

RadioData _$RadioDataFromJson(Map<String, dynamic> json) => RadioData(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  url: json['url'] as String?,
  recentDate: json['recent_date'] as String?,
);
