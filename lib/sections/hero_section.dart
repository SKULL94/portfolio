import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/constants.dart';
import '../core/theme.dart';

class HeroSection extends StatefulWidget {
  final Function(String)? onScrollToSection;

  const HeroSection({super.key, this.onScrollToSection});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: r.height),
      decoration: const BoxDecoration(color: AppTheme.darkBg),
      child: Stack(
        children: [
          // Background gradient orbs
          Positioned.fill(child: _buildBackgroundOrbs(r)),

          // Main content
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: r.horizontalPadding,
                vertical: r.spacing(20),
              ),
              child: Column(
                children: [
                  SizedBox(height: r.value(mobile: 40.0, desktop: 60.0)),
                  r.isMobile ? _buildMobileLayout(r) : _buildDesktopLayout(r),
                  SizedBox(height: r.spacing(40)),
                  _buildScrollIndicator(r),
                  SizedBox(height: r.spacing(30)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundOrbs(Responsive r) {
    return IgnorePointer(
      child: Stack(
        children: [
          // Top right purple orb
          Positioned(
            top: -100,
            right: -100,
            child: AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Container(
                  width: r.value(mobile: 250.0, desktop: 400.0) * _pulseAnimation.value,
                  height: r.value(mobile: 250.0, desktop: 400.0) * _pulseAnimation.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppTheme.primaryColor.withValues(alpha: 0.25),
                        AppTheme.primaryColor.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Bottom left cyan orb
          Positioned(
            bottom: -80,
            left: -80,
            child: Container(
              width: r.value(mobile: 200.0, desktop: 350.0),
              height: r.value(mobile: 200.0, desktop: 350.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppTheme.secondaryColor.withValues(alpha: 0.18),
                    AppTheme.secondaryColor.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // MOBILE LAYOUT - Optimized for Instagram/social media viewing
  Widget _buildMobileLayout(Responsive r) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Main intro card
        _buildGlassCard(
          r,
          padding: r.spacing(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvailableBadge(r),
              SizedBox(height: r.spacing(20)),
              _buildIntroContent(r),
            ],
          ),
        ),

        SizedBox(height: r.spacing(16)),

        // Stats Grid - 2x2
        Row(
          children: [
            Expanded(child: _buildStatCard('4+', 'Years Exp', r)),
            SizedBox(width: r.spacing(12)),
            Expanded(child: _buildStatCard('10K+', 'Downloads', r)),
          ],
        ),
        SizedBox(height: r.spacing(12)),
        Row(
          children: [
            Expanded(child: _buildStatCard('2500+', 'Users', r)),
            SizedBox(width: r.spacing(12)),
            Expanded(child: _buildStatCard('5+', 'Apps', r)),
          ],
        ),

        SizedBox(height: r.spacing(12)),

        // Social links
        _buildGlassCard(
          r,
          padding: r.spacing(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSocialIcon(FontAwesomeIcons.linkedin, AppConstants.linkedIn, r),
              _buildSocialIcon(FontAwesomeIcons.github, AppConstants.github, r),
              _buildSocialIcon(FontAwesomeIcons.envelope, 'mailto:${AppConstants.email}', r),
            ],
          ),
        ),

        SizedBox(height: r.spacing(12)),

        // CTA Button
        _buildCtaButton(r),
      ],
    );
  }

  // DESKTOP LAYOUT - Clean, no outer card
  Widget _buildDesktopLayout(Responsive r) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Available badge
            _buildAvailableBadge(r),
            SizedBox(height: r.spacing(32)),

            // Name
            ShaderMask(
              shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
              child: Text(
                AppConstants.name,
                style: TextStyle(
                  fontSize: r.fontSize(52),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: r.spacing(16)),

            // Animated title
            SizedBox(
              height: 40,
              child: DefaultTextStyle(
                style: TextStyle(
                  color: AppTheme.lightText,
                  fontSize: r.fontSize(20),
                  fontWeight: FontWeight.w500,
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: AppConstants.animatedTexts
                      .map((text) => TypewriterAnimatedText(
                            text,
                            speed: const Duration(milliseconds: 80),
                          ))
                      .toList(),
                ),
              ),
            ),
            SizedBox(height: r.spacing(24)),

            // Description
            Text(
              'Crafting beautiful, performant mobile & web experiences with Flutter.',
              style: TextStyle(
                color: AppTheme.subtleText,
                fontSize: r.fontSize(16),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: r.spacing(36)),

            // Service tags
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildServiceTag(Icons.phone_android_rounded, 'Mobile Apps', 'Android & iOS', r),
                SizedBox(width: r.spacing(20)),
                _buildServiceTag(Icons.web_rounded, 'Web Apps', 'Website!', r),
              ],
            ),
            SizedBox(height: r.spacing(40)),

            // Stats strip
            Container(
              padding: EdgeInsets.symmetric(vertical: r.spacing(24)),
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(child: _buildStatItem('4+', 'Years Exp', r)),
                  _buildStatDivider(r),
                  Expanded(child: _buildStatItem('10K+', 'Downloads', r)),
                  _buildStatDivider(r),
                  Expanded(child: _buildStatItem('2500+', 'Users', r)),
                  _buildStatDivider(r),
                  Expanded(child: _buildStatItem('5+', 'Apps', r)),
                ],
              ),
            ),
            SizedBox(height: r.spacing(36)),

            // Social links
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialButton(FontAwesomeIcons.linkedin, AppConstants.linkedIn, 'LinkedIn', r),
                SizedBox(width: r.spacing(28)),
                _buildSocialButton(FontAwesomeIcons.github, AppConstants.github, 'GitHub', r),
                SizedBox(width: r.spacing(28)),
                _buildSocialButton(FontAwesomeIcons.envelope, 'mailto:${AppConstants.email}', 'Email', r),
              ],
            ),
            SizedBox(height: r.spacing(36)),

            // CTA button
            _buildCtaButton(r),
          ],
        ),
      ),
    );
  }

  // GLASS CARD WRAPPER
  Widget _buildGlassCard(Responsive r, {required Widget child, double? padding}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(r.cardRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: EdgeInsets.all(padding ?? r.spacing(24)),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(r.cardRadius),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  // AVAILABLE BADGE
  Widget _buildAvailableBadge(Responsive r) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: r.spacing(12),
        vertical: r.spacing(6),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF10B981).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFF10B981),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF10B981).withValues(alpha: 0.5),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
          SizedBox(width: r.spacing(8)),
          Text(
            'Available for work',
            style: TextStyle(
              color: const Color(0xFF10B981),
              fontSize: r.fontSize(11),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // INTRO CONTENT
  Widget _buildIntroContent(Responsive r) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hello, I'm",
          style: TextStyle(
            color: AppTheme.subtleText,
            fontSize: r.fontSize(14),
            letterSpacing: 1,
          ),
        ),
        SizedBox(height: r.spacing(6)),
        ShaderMask(
          shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
          child: Text(
            AppConstants.name,
            style: TextStyle(
              fontSize: r.value(mobile: 28.0, smallPhone: 24.0, tablet: 38.0, desktop: 46.0),
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.1,
            ),
          ),
        ),
        SizedBox(height: r.spacing(12)),
        SizedBox(
          height: r.value(mobile: 28.0, desktop: 36.0),
          child: DefaultTextStyle(
            style: TextStyle(
              color: AppTheme.lightText,
              fontSize: r.fontSize(18),
              fontWeight: FontWeight.w500,
            ),
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: AppConstants.animatedTexts
                  .map((text) => TypewriterAnimatedText(
                        text,
                        speed: const Duration(milliseconds: 80),
                      ))
                  .toList(),
            ),
          ),
        ),
        SizedBox(height: r.spacing(16)),
        Text(
          'Crafting beautiful, performant mobile & web experiences with Flutter.',
          style: TextStyle(
            color: AppTheme.subtleText,
            fontSize: r.fontSize(13),
            height: 1.6,
          ),
        ),
        SizedBox(height: r.spacing(20)),
        // Service tags
        Wrap(
          spacing: r.spacing(12),
          runSpacing: r.spacing(8),
          children: [
            _buildServiceTag(Icons.phone_android_rounded, 'Mobile Apps', 'Android & iOS', r),
            _buildServiceTag(Icons.web_rounded, 'Web Apps', 'Website!', r),
          ],
        ),
      ],
    );
  }

  // SERVICE TAG (prominent card style)
  Widget _buildServiceTag(IconData icon, String label, String subtitle, Responsive r) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: r.spacing(20),
        vertical: r.spacing(14),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor.withValues(alpha: 0.25),
            AppTheme.secondaryColor.withValues(alpha: 0.15),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.secondaryColor.withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(r.spacing(8)),
            decoration: BoxDecoration(
              color: AppTheme.secondaryColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppTheme.secondaryColor, size: r.fontSize(20)),
          ),
          SizedBox(width: r.spacing(12)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: AppTheme.lightText,
                  fontSize: r.fontSize(14),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: r.spacing(2)),
              Text(
                '($subtitle)',
                style: TextStyle(
                  color: AppTheme.subtleText,
                  fontSize: r.fontSize(11),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // STATS STRIP - horizontal row of all stats
  Widget _buildStatsStrip(Responsive r) {
    return _buildGlassCard(
      r,
      padding: r.spacing(20),
      child: Row(
        children: [
          Expanded(child: _buildStatItem('4+', 'Years Exp', r)),
          _buildStatDivider(r),
          Expanded(child: _buildStatItem('10K+', 'Downloads', r)),
          _buildStatDivider(r),
          Expanded(child: _buildStatItem('2500+', 'Users', r)),
          _buildStatDivider(r),
          Expanded(child: _buildStatItem('5+', 'Apps', r)),
        ],
      ),
    );
  }

  Widget _buildStatDivider(Responsive r) {
    return Container(
      width: 1,
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: r.spacing(8)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            AppTheme.primaryColor.withValues(alpha: 0.3),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Responsive r) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
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
            color: AppTheme.subtleText,
            fontSize: r.fontSize(12),
          ),
        ),
      ],
    );
  }

  // STAT CARD (4+, 10K+, etc.) - for mobile
  Widget _buildStatCard(String value, String label, Responsive r) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(r.cardRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: EdgeInsets.all(r.spacing(12)),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(r.cardRadius),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: r.fontSize(22),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: r.spacing(2)),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.subtleText,
                    fontSize: r.fontSize(10),
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // SOCIAL ICON (Mobile)
  Widget _buildSocialIcon(IconData icon, String url, Responsive r) {
    return InkWell(
      onTap: () => _launchUrl(url),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(r.spacing(12)),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: FaIcon(icon, color: AppTheme.lightText, size: r.fontSize(18)),
      ),
    );
  }

  // SOCIAL BUTTON (Desktop - with label)
  Widget _buildSocialButton(IconData icon, String url, String label, Responsive r) {
    return InkWell(
      onTap: () => _launchUrl(url),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: r.spacing(12)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(r.spacing(10)),
              decoration: BoxDecoration(
                color: AppTheme.cardBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: FaIcon(icon, color: AppTheme.lightText, size: r.fontSize(16)),
            ),
            SizedBox(width: r.spacing(10)),
            Text(
              label,
              style: TextStyle(color: AppTheme.lightText, fontSize: r.fontSize(13)),
            ),
          ],
        ),
      ),
    );
  }

  // CTA BUTTON
  Widget _buildCtaButton(Responsive r) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(r.cardRadius),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => widget.onScrollToSection?.call('contact'),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: r.spacing(24),
              vertical: r.spacing(18),
            ),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(r.cardRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.rocket_launch_rounded, color: Colors.white, size: r.fontSize(20)),
                SizedBox(width: r.spacing(12)),
                Text(
                  "Let's Build Something",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: r.fontSize(14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: r.spacing(8)),
                Icon(Icons.arrow_forward_rounded, color: Colors.white, size: r.fontSize(18)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // SCROLL INDICATOR
  Widget _buildScrollIndicator(Responsive r) {
    return GestureDetector(
      onTap: () => widget.onScrollToSection?.call('about'),
      child: Column(
        children: [
          Text(
            'Scroll to explore',
            style: TextStyle(
              color: AppTheme.subtleText.withValues(alpha: 0.6),
              fontSize: r.fontSize(11),
            ),
          ),
          SizedBox(height: r.spacing(8)),
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _pulseAnimation.value * 6),
                child: child,
              );
            },
            child: Container(
              padding: EdgeInsets.all(r.spacing(8)),
              decoration: BoxDecoration(
                color: AppTheme.cardBg,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppTheme.primaryColor,
                size: r.fontSize(18),
              ),
            ),
          ),
        ],
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
