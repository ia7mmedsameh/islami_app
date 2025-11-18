import 'package:freezed_annotation/freezed_annotation.dart';

part 'ahadith_response_model.g.dart';

@JsonSerializable(createToJson: false)
class AhadithResponseModel {
  Hadiths? hadiths;
  AhadithResponseModel({this.hadiths});

  factory AhadithResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AhadithResponseModelFromJson(json);

  Map<String, dynamic> toJson() => {
        'hadiths': hadiths?.toJson(),
      };
}

@JsonSerializable(createToJson: false)
class Hadiths {
  List<Data>? data;
  Hadiths({this.data});

  factory Hadiths.fromJson(Map<String, dynamic> json) =>
      _$HadithsFromJson(json);

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
      };
}

@JsonSerializable(createToJson: false)
class Data {
  int? id;
  String? hadithNumber;
  String? hadithArabic;

  Data({this.id, this.hadithNumber, this.hadithArabic});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => {
        'id': id,
        'hadithNumber': hadithNumber,
        'hadithArabic': hadithArabic,
      };
}
