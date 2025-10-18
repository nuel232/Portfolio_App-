import 'package:flutter/material.dart';

class ProjectModel {
  final String title;
  final String description;
  final String tech;
  final IconData icon;

  ProjectModel({
    required this.title,
    required this.description,
    required this.tech,
    required this.icon,
  });
}
