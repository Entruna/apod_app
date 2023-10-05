import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part '../../generated/network/model/apod_response_dto.g.dart';

///API response data model
@JsonSerializable()
class ApodResponseDto extends Equatable {
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "date")
  String? date;
  @JsonKey(name: "hdurl")
  String? hdUrl;
  String? error;

  ApodResponseDto({required this.title, required this.date, required this.hdUrl});

  factory ApodResponseDto.fromJson(Map<String, dynamic> json) => _$ApodResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ApodResponseDtoToJson(this);

  ApodResponseDto.withError(String errorMessage) {
    error = errorMessage;
  }

  @override
  List<Object?> get props => [title, date, hdUrl];
}
