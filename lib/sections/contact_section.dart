import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/constants.dart';
import '../core/theme.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.getHorizontalPadding(context),
        vertical: 100,
      ),
      child: Column(
        children: [
          _buildSectionTitle(context, 'Get In Touch'),
          const SizedBox(height: 20),
          Text(
            'Have a project in mind? Let\'s work together!',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: isMobile
                ? Column(
                    children: [
                      _buildContactCard(
                        context,
                        icon: Icons.email_outlined,
                        title: 'Email',
                        value: AppConstants.email,
                        onTap: () => _launchUrl('mailto:${AppConstants.email}'),
                      ),
                      const SizedBox(height: 20),
                      _buildContactCard(
                        context,
                        icon: Icons.phone_outlined,
                        title: 'Phone',
                        value: AppConstants.phone,
                        onTap: () => _launchUrl('tel:${AppConstants.phone}'),
                      ),
                      const SizedBox(height: 20),
                      _buildContactCard(
                        context,
                        icon: Icons.location_on_outlined,
                        title: 'Location',
                        value: AppConstants.location,
                        onTap: null,
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: _buildContactCard(
                          context,
                          icon: Icons.email_outlined,
                          title: 'Email',
                          value: AppConstants.email,
                          onTap: () =>
                              _launchUrl('mailto:${AppConstants.email}'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildContactCard(
                          context,
                          icon: Icons.phone_outlined,
                          title: 'Phone',
                          value: AppConstants.phone,
                          onTap: () => _launchUrl('tel:${AppConstants.phone}'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildContactCard(
                          context,
                          icon: Icons.location_on_outlined,
                          title: 'Location',
                          value: AppConstants.location,
                          onTap: null,
                        ),
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 60),
          // Social links
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialButton(
                icon: FontAwesomeIcons.linkedin,
                url: AppConstants.linkedIn,
                label: 'LinkedIn',
              ),
              const SizedBox(width: 20),
              _buildSocialButton(
                icon: FontAwesomeIcons.github,
                url: AppConstants.github,
                label: 'GitHub',
              ),
            ],
          ),
          const SizedBox(height: 60),
          // CTA Button
          ElevatedButton(
            onPressed: () => _launchUrl('mailto:${AppConstants.email}'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.send),
                SizedBox(width: 12),
                Text(
                  'Send Me a Message',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 16),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildContactCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppTheme.primaryColor.withValues(alpha: 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: onTap != null
                        ? AppTheme.secondaryColor
                        : AppTheme.subtleText,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String url,
    required String label,
  }) {
    return OutlinedButton.icon(
      onPressed: () => _launchUrl(url),
      icon: FaIcon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
