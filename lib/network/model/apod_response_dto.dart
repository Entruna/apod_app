import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part '../../generated/network/model/apod_response_dto.g.dart';

///API response data model
@JsonSerializable()
class ApodResponseDto extends Equatable {
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "date")
  final String? date;
  @JsonKey(name: "hdurl")
  final String? hdUrl;

  const ApodResponseDto({this.title, this.date, this.hdUrl});

  factory ApodResponseDto.fromJson(Map<String, dynamic> json) => _$ApodResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ApodResponseDtoToJson(this);

  @override
  List<Object?> get props => [title, date, hdUrl];
}
