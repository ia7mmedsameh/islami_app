import 'package:freezed_annotation/freezed_annotation.dart';
part 'surahs_response_model.g.dart';

@JsonSerializable(createToJson: false)
class SurahsResponseModel {
  List<SurahsData>? data;

  SurahsResponseModel({this.data});

  factory SurahsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SurahsResponseModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class SurahsData {
  int? number;
  String? name;
  String? englishName;
  String? englishNameTranslation;
  int? numberOfAyahs;
  String? revelationType;

  SurahsData({
    this.number,
    this.name,
    this.englishName,
    this.englishNameTranslation,
    this.numberOfAyahs,
    this.revelationType,
  });

  factory SurahsData.fromJson(Map<String, dynamic> json) =>
      _$SurahsDataFromJson(json);
}
