// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ahadith_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AhadithResponseModel _$AhadithResponseModelFromJson(
  Map<String, dynamic> json,
) => AhadithResponseModel(
  hadiths: json['hadiths'] == null
      ? null
      : Hadiths.fromJson(json['hadiths'] as Map<String, dynamic>),
);

Hadiths _$HadithsFromJson(Map<String, dynamic> json) => Hadiths(
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  id: (json['id'] as num?)?.toInt(),
  hadithNumber: json['hadithNumber'] as String?,
  hadithArabic: json['hadithArabic'] as String?,
);
