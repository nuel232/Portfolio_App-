import 'package:flutter/material.dart';
import 'package:personal_profolio_app/components/animated_section.dart';
import 'package:personal_profolio_app/components/about_section.dart';
import 'package:personal_profolio_app/components/skills_section.dart';
import 'package:personal_profolio_app/components/projects_section.dart';
import 'package:personal_profolio_app/components/contact_section.dart';
import 'package:personal_profolio_app/services/theme/theme_prodiver.dart';
import 'package:personal_profolio_app/utils/constants.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(themeProvider, colorScheme),
          _buildContent(colorScheme),
        ],
      ),
      floatingActionButton: _buildFAB(colorScheme),
    );
  }

  SliverAppBar _buildAppBar(
    ThemeProvider themeProvider,
    ColorScheme colorScheme,
  ) {
    return SliverAppBar(
      expandedHeight: 280.0,
      floating: false,
      pinned: true,
      backgroundColor: colorScheme.secondary,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [colorScheme.secondary, colorScheme.tertiary],
            ),
          ),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  _buildProfileAvatar(colorScheme),
                  const SizedBox(height: 16),
                  Text(
                    PortfolioConstants.name,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildTitleChip(colorScheme),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [_buildThemeToggle(themeProvider, colorScheme)],
    );
  }

  Widget _buildProfileAvatar(ColorScheme colorScheme) {
    return Hero(
      tag: 'profile',
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: colorScheme.onSecondary.withOpacity(0.3),
            width: 3,
          ),
        ),
        child: CircleAvatar(
          radius: 55,
          backgroundColor: colorScheme.primary,
          child: Icon(
            Icons.person_rounded,
            size: 70,
            color: colorScheme.tertiary,
          ),
        ),
      ),
    );
  }

  Widget _buildTitleChip(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        PortfolioConstants.title,
        style: TextStyle(
          fontSize: 16,
          color: colorScheme.onSecondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildThemeToggle(
    ThemeProvider themeProvider,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        children: [
          Icon(
            themeProvider.isLightMode
                ? Icons.wb_sunny_rounded
                : Icons.nights_stay_rounded,
            size: 20,
            color: colorScheme.onSecondary,
          ),
          Switch(
            value: !themeProvider.isLightMode,
            onChanged: (value) => themeProvider.toggleTheme(),
            activeColor: colorScheme.tertiary,
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildContent(ColorScheme colorScheme) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(height: 24),
          AnimatedSection(
            delay: 200,
            child: AboutSection(colorScheme: colorScheme),
          ),
          AnimatedSection(
            delay: 400,
            child: SkillsSection(colorScheme: colorScheme),
          ),
          AnimatedSection(
            delay: 600,
            child: ProjectsSection(colorScheme: colorScheme),
          ),
          AnimatedSection(
            delay: 800,
            child: ContactSection(colorScheme: colorScheme),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildFAB(ColorScheme colorScheme) {
    return FloatingActionButton.extended(
      onPressed: () {
        // Could scroll to contact or launch email
      },
      backgroundColor: colorScheme.tertiary,
      icon: const Icon(Icons.mail_rounded, color: Colors.white),
      label: const Text(
        'Get in Touch',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}
