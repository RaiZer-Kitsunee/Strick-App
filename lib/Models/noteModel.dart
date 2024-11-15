// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class Note {
  String title;
  String note;
  String image;
  Color color;
  Note({
    required this.title,
    required this.note,
    this.image = "",
    required this.color,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'note': note,
        'image': image,
        'color': color.value,
      };

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json['title'] as String,
      note: json['note'] as String,
      image: json['image'] as String,
      color: Color(json['color']),
    );
  }
}
