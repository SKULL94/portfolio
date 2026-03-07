import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/theme.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: r.horizontalPadding,
        vertical: r.sectionVerticalPadding,
      ),
      child: Column(
        children: [
          _buildSectionTitle(context, 'About Me', r),
          SizedBox(height: r.spacing(60)),
          r.isMobile
              ? Column(
                  children: [
                    _buildProfileImage(r),
                    SizedBox(height: r.spacing(40)),
                    _buildAboutContent(context, r),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 2, child: _buildProfileImage(r)),
                    SizedBox(width: r.spacing(60)),
                    Expanded(flex: 3, child: _buildAboutContent(context, r)),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, Responsive r) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: r.fontSize(40),
              ),
        ),
        SizedBox(height: r.spacing(16)),
        Container(
          width: r.value(mobile: 60, desktop: 80),
          height: 4,
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage(Responsive r) {
    // Responsive max width based on screen size
    final maxWidth = r.value(
      mobile: r.width * 0.65,
      smallPhone: r.width * 0.6,
      tablet: 300.0,
      desktop: 350.0,
    );

    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(r.cardRadius),
            gradient: AppTheme.primaryGradient,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withValues(alpha: 0.3),
                blurRadius: r.value(mobile: 20, desktop: 30),
                offset: Offset(0, r.value(mobile: 10, desktop: 15)),
              ),
            ],
          ),
          padding: const EdgeInsets.all(4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(r.cardRadius - 2),
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

  Widget _buildAboutContent(BuildContext context, Responsive r) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flutter Developer & Mobile App Specialist',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.primaryColor,
                fontSize: r.fontSize(24),
              ),
        ),
        SizedBox(height: r.spacing(24)),
        Text(
          AppConstants.aboutMe,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.8,
                fontSize: r.fontSize(15),
              ),
        ),
        SizedBox(height: r.spacing(32)),
        // Grid layout for consistent sizing
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: r.isMobile ? 2 : 4,
          crossAxisSpacing: r.spacing(16),
          mainAxisSpacing: r.spacing(16),
          childAspectRatio: r.value(
            mobile: 1.3,
            smallPhone: 1.4,
            tablet: 1.2,
            desktop: 1.2,
          ),
          children: [
            _StatCard(value: '4+', label: 'Years Experience', r: r),
            _StatCard(value: '10K+', label: 'App Downloads', r: r),
            _StatCard(value: '2500+', label: 'Daily Users', r: r),
            _StatCard(value: '5+', label: 'Published Apps', r: r),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Responsive r;

  const _StatCard({
    required this.value,
    required this.label,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: r.spacing(12),
        vertical: r.spacing(12),
      ),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(r.cardRadius * 0.6),
        border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.3)),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppTheme.primaryGradient.createShader(bounds),
              child: Text(
                value,
                style: TextStyle(
                  fontSize: r.fontSize(26),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: r.spacing(4)),
            Text(
              label,
              style: TextStyle(
                fontSize: r.fontSize(11),
                color: AppTheme.subtleText.withValues(alpha: 0.8),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
