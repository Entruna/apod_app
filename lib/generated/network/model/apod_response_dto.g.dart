// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../network/model/apod_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApodResponseDto _$ApodResponseDtoFromJson(Map<String, dynamic> json) =>
    ApodResponseDto(
      title: json['title'] as String?,
      date: json['date'] as String?,
      hdUrl: json['hdurl'] as String?,
    );

Map<String, dynamic> _$ApodResponseDtoToJson(ApodResponseDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'date': instance.date,
      'hdurl': instance.hdUrl,
    };
