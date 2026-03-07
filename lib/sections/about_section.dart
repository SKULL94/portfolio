import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/theme.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
          _buildSectionTitle(context, 'About Me'),
          const SizedBox(height: 60),
          isMobile
              ? Column(
                  children: [
                    _buildProfileImage(),
                    const SizedBox(height: 40),
                    _buildAboutContent(context),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 2, child: _buildProfileImage()),
                    const SizedBox(width: 60),
                    Expanded(flex: 3, child: _buildAboutContent(context)),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Column(
      children: [
        Text(title, style: Theme.of(context).textTheme.displayMedium),
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

  Widget _buildProfileImage() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 350),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: AppTheme.primaryGradient,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withValues(alpha: 0.3),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          padding: const EdgeInsets.all(4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              'assets/profilepic.JPG',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAboutContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flutter Developer & Mobile App Specialist',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(color: AppTheme.primaryColor),
        ),
        const SizedBox(height: 24),
        Text(
          AppConstants.aboutMe,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.8),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 24,
          runSpacing: 16,
          children: [
            _buildStatCard('4+', 'Years Experience'),
            _buildStatCard('10K+', 'App Downloads'),
            _buildStatCard('2500+', 'Daily Users'),
            _buildStatCard('4+', 'Published Apps'),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) =>
                AppTheme.primaryGradient.createShader(bounds),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.subtleText.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
