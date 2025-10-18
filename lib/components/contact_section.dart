import 'package:flutter/material.dart';
import 'package:personal_profolio_app/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  final ColorScheme colorScheme;

  const ContactSection({Key? key, required this.colorScheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                PortfolioConstants.email,
              ),
              _buildContactItem(
                Icons.phone_rounded,
                'Phone',
                PortfolioConstants.phone,
              ),
              _buildContactItem(
                Icons.language_rounded,
                'LinkedIn',
                PortfolioConstants.linkedin,
              ),
              _buildContactItem(
                Icons.code_rounded,
                'GitHub',
                PortfolioConstants.github,
              ),
              _buildContactItem(
                Icons.alternate_email_rounded,
                'Twitter/X',
                PortfolioConstants.twitter,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String title, String value) {
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
                      color: colorScheme.onSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: colorScheme.tertiary,
            ),
          ],
        ),
      ),
    );
  }
}
