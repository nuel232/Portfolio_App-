import 'package:flutter/material.dart';
import 'package:personal_profolio_app/services/theme/theme_prodiver.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          // Animated App Bar
          SliverAppBar(
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
                        Hero(
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
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Your Name',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSecondary,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Mobile Developer',
                            style: TextStyle(
                              fontSize: 16,
                              color: colorScheme.onSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
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
                      onChanged: (value) => themeProvider.toggleThemem(),
                      activeColor: colorScheme.tertiary,
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 24),

                // About Section
                _AnimatedSection(
                  delay: 200,
                  child: _buildAboutSection(colorScheme),
                ),

                // Skills Section
                _AnimatedSection(
                  delay: 400,
                  child: _buildSkillsSection(colorScheme),
                ),

                // Projects Section
                _AnimatedSection(
                  delay: 600,
                  child: _buildProjectsSection(colorScheme),
                ),

                // Contact Section
                _AnimatedSection(
                  delay: 800,
                  child: _buildContactSection(colorScheme),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Scroll to contact section or open email
        },
        backgroundColor: colorScheme.tertiary,
        icon: const Icon(Icons.mail_rounded, color: Colors.white),
        label: const Text(
          'Get in Touch',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildAboutSection(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colorScheme.tertiary.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colorScheme.tertiary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.person_pin_rounded,
                      color: colorScheme.tertiary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'About Me',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'I am a passionate mobile developer with experience in building beautiful and functional mobile applications. I love creating intuitive user experiences and solving complex problems through code.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 24),
              _buildInfoRow(
                Icons.school_rounded,
                'Education',
                'Computer Science Student',
                colorScheme,
              ),
              const SizedBox(height: 16),
              _buildInfoRow(
                Icons.location_on_rounded,
                'Location',
                'Lagos, Nigeria',
                colorScheme,
              ),
              const SizedBox(height: 16),
              _buildInfoRow(
                Icons.work_rounded,
                'Experience',
                '2+ years in mobile development',
                colorScheme,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value,
    ColorScheme colorScheme,
  ) {
    return Row(
      children: [
        Icon(icon, color: colorScheme.tertiary, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsSection(ColorScheme colorScheme) {
    final skills = [
      {'name': 'Flutter', 'level': 0.9, 'icon': Icons.flutter_dash_rounded},
      {'name': 'Dart', 'level': 0.85, 'icon': Icons.code_rounded},
      {'name': 'React Native', 'level': 0.75, 'icon': Icons.javascript_rounded},
      {'name': 'UI/UX Design', 'level': 0.8, 'icon': Icons.palette_rounded},
      {'name': 'Firebase', 'level': 0.7, 'icon': Icons.cloud_rounded},
      {'name': 'Git & GitHub', 'level': 0.85, 'icon': Icons.source_rounded},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colorScheme.tertiary.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colorScheme.tertiary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.psychology_rounded,
                      color: colorScheme.tertiary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Skills',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ...skills.map(
                (skill) => _buildSkillItem(
                  skill['name'] as String,
                  skill['level'] as double,
                  skill['icon'] as IconData,
                  colorScheme,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillItem(
    String skill,
    double level,
    IconData icon,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: colorScheme.tertiary, size: 20),
              const SizedBox(width: 10),
              Text(
                skill,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onPrimary,
                ),
              ),
              const Spacer(),
              Text(
                '${(level * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.tertiary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 1500),
              curve: Curves.easeOutCubic,
              tween: Tween<double>(begin: 0, end: level),
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  value: value,
                  minHeight: 8,
                  backgroundColor: colorScheme.surface,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colorScheme.tertiary,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsSection(ColorScheme colorScheme) {
    final projects = [
      {
        'title': 'E-Commerce App',
        'description': 'Full-featured shopping app with payment integration',
        'tech': 'Flutter, Firebase, Stripe',
        'icon': Icons.shopping_cart_rounded,
      },
      {
        'title': 'Task Manager',
        'description': 'Productivity app with cloud sync and notifications',
        'tech': 'Flutter, SQLite, Push Notifications',
        'icon': Icons.task_alt_rounded,
      },
      {
        'title': 'Weather App',
        'description': 'Real-time weather forecasts with beautiful UI',
        'tech': 'Flutter, REST API, Animations',
        'icon': Icons.wb_cloudy_rounded,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colorScheme.tertiary.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colorScheme.tertiary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.rocket_launch_rounded,
                      color: colorScheme.tertiary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Projects',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ...projects.map(
                (project) => _buildProjectCard(project, colorScheme),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCard(
    Map<String, dynamic> project,
    ColorScheme colorScheme,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.tertiary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.tertiary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  project['icon'] as IconData,
                  color: colorScheme.tertiary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project['title'] as String,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      project['description'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              project['tech'] as String,
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colorScheme.tertiary.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colorScheme.tertiary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.connect_without_contact_rounded,
                      color: colorScheme.tertiary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Contact Me',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildContactItem(
                Icons.email_rounded,
                'Email',
                'your.email@example.com',
                colorScheme,
              ),
              _buildContactItem(
                Icons.phone_rounded,
                'Phone',
                '+234 915 641 4321',
                colorScheme,
              ),
              _buildContactItem(
                Icons.language_rounded,
                'LinkedIn',
                'linkedin.com/in/',
                colorScheme,
              ),
              _buildContactItem(
                Icons.code_rounded,
                'GitHub',
                'github.com/yourusername',
                colorScheme,
              ),
              _buildContactItem(
                Icons.alternate_email_rounded,
                'Twitter/X',
                '@yourhandle',
                colorScheme,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(
    IconData icon,
    String title,
    String value,
    ColorScheme colorScheme,
  ) {
    // Define the actual URLs/actions
    String getUrl() {
      switch (title) {
        case 'Email':
          return 'mailto:$value';
        case 'Phone':
          return 'tel:$value';
        case 'LinkedIn':
          return 'https://$value';
        case 'GitHub':
          return 'https://$value';
        case 'Twitter/X':
          return 'https://twitter.com/${value.replaceAll('@', '')}';
        default:
          return '';
      }
    }

    // Function to launch URL
    Future<void> launchURL() async {
      final url = getUrl();
      if (url.isNotEmpty) {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      }
    }

    return InkWell(
      // ← Make it tappable
      onTap: launchURL,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colorScheme.tertiary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: colorScheme.tertiary, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 15,
                      color: colorScheme
                          .onSecondary, // ← Changed from onPrimary for better visibility
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: colorScheme.tertiary, // ← Changed color for visibility
            ),
          ],
        ),
      ),
    );
  }
}

// Animated Section Widget
class _AnimatedSection extends StatefulWidget {
  final Widget child;
  final int delay;

  const _AnimatedSection({required this.child, required this.delay});

  @override
  State<_AnimatedSection> createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<_AnimatedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: widget.child,
        ),
      ),
    );
  }
}
