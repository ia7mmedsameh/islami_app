import 'package:freezed_annotation/freezed_annotation.dart';

part 'radio_response_model.g.dart';

@JsonSerializable(createToJson: false)
class RadioResponseModel {
  List<RadioData>? radios;

  RadioResponseModel({this.radios});

  factory RadioResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RadioResponseModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class RadioData {
  int? id;
  String? name;
  String? url;
  @JsonKey(name: 'recent_date')
  String? recentDate;

  RadioData({
    this.id,
    this.name,
    this.url,
    this.recentDate,
  });

  factory RadioData.fromJson(Map<String, dynamic> json) =>
      _$RadioDataFromJson(json);
}
