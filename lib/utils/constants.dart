import 'package:flutter/material.dart';
import 'package:personal_profolio_app/models/skill_model.dart';
import 'package:personal_profolio_app/models/project_model.dart';

class PortfolioConstants {
  // Personal Info
  static const String name = 'Nwankwoala kelechi';
  static const String title = 'Mobile Developer';
  static const String aboutText =
      'I am a passionate mobile developer with experience in building beautiful and functional mobile applications. I love creating intuitive user experiences and solving complex problems through code.';

  static const String education = 'Computer Science Student';
  static const String location = 'Abuja, Nigeria';
  static const String experience = '1+ years in mobile development';

  // Contact Info
  static const String email = 'nwankwoala3@gmail.com';
  static const String phone = '+234   915 641 4321';
  static const String linkedin = 'linkedin.com/in/nwankwoala-kelechi';
  static const String github = 'github.com/nuel232';
  static const String twitter = '@kelechixx_';

  // Skills
  static final List<SkillModel> skills = [
    SkillModel(name: 'Flutter', level: 0.6, icon: Icons.flutter_dash_rounded),
    SkillModel(name: 'Dart', level: 0.5, icon: Icons.code_rounded),

    SkillModel(name: 'UI/UX Design', level: 0.8, icon: Icons.palette_rounded),
    SkillModel(name: 'Firebase', level: 0.7, icon: Icons.cloud_rounded),
    SkillModel(name: 'Git & GitHub', level: 0.85, icon: Icons.source_rounded),
  ];

  // Projects
  static final List<ProjectModel> projects = [
    ProjectModel(
      title: 'E-Commerce App',
      description: 'Full-featured shopping app with payment integration',
      tech: 'Flutter, Firebase, stripe',
      icon: Icons.shopping_cart_rounded,
    ),
    ProjectModel(
      title: 'Task Manager',
      description: 'Productivity app with cloud sync and notifications',
      tech: 'Flutter, Hive, Push Notifications',
      icon: Icons.task_alt_rounded,
    ),
    ProjectModel(
      title: 'Weather App',
      description: 'Real-time weather forecasts with beautiful UI',
      tech: 'Flutter, REST API, Animations',
      icon: Icons.wb_cloudy_rounded,
    ),
  ];
}
