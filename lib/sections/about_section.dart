import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/theme.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: r.horizontalPadding,
        vertical: r.sectionVerticalPadding,
      ),
      child: Column(
        children: [
          _buildSectionHeader(context, r),
          SizedBox(height: r.spacing(50)),
          r.isMobile
              ? _buildMobileLayout(r, context)
              : _buildDesktopLayout(r, context),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, Responsive r) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppTheme.primaryGradient.createShader(bounds),
          child: Text(
            'About Me',
            style: TextStyle(
              fontSize: r.fontSize(32),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: r.spacing(12)),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(Responsive r, BuildContext context) {
    return Column(
      children: [
        // Profile image card
        _buildGlassCard(r, child: Column(children: [_buildProfileImage(r)])),

        SizedBox(height: r.spacing(12)),

        // Bio card
        _buildGlassCard(
          r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person_rounded,
                    color: AppTheme.primaryColor,
                    size: r.fontSize(18),
                  ),
                  SizedBox(width: r.spacing(8)),
                  Text(
                    'Who am I?',
                    style: TextStyle(
                      color: AppTheme.lightText,
                      fontSize: r.fontSize(16),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: r.spacing(14)),
              Text(
                AppConstants.aboutMe,
                style: TextStyle(
                  color: AppTheme.subtleText,
                  fontSize: r.fontSize(13),
                  height: 1.7,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(Responsive r, BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1100),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left column - Profile image
          _buildProfileImage(r),

          SizedBox(width: r.spacing(32)),

          // Right column - Bio card
          Expanded(
            child: _buildGlassCard(
              r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person_rounded,
                        color: AppTheme.primaryColor,
                        size: r.fontSize(20),
                      ),
                      SizedBox(width: r.spacing(10)),
                      Text(
                        'Who am I?',
                        style: TextStyle(
                          color: AppTheme.lightText,
                          fontSize: r.fontSize(18),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: r.spacing(16)),
                  Text(
                    AppConstants.aboutMe,
                    style: TextStyle(
                      color: AppTheme.subtleText,
                      fontSize: r.fontSize(14),
                      height: 1.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassCard(Responsive r, {required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(r.cardRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(r.spacing(24)),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(r.cardRadius),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildProfileImage(Responsive r) {
    final size = r.value(mobile: 200.0, desktop: 320.0);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(r.cardRadius),
        gradient: AppTheme.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(3),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(r.cardRadius - 2),
        child: Image.asset(
          'assets/profilepic.jpg',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: AppTheme.cardBg,
            child: Icon(
              Icons.person_rounded,
              size: size * 0.5,
              color: AppTheme.subtleText,
            ),
          ),
        ),
      ),
    );
  }
}
