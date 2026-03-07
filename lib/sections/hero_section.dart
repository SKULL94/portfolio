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
  late AnimationController _scrollIndicatorController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _scrollIndicatorController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 0, end: 12).animate(
      CurvedAnimation(
        parent: _scrollIndicatorController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _scrollIndicatorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Container(
      height: r.height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.darkBg,
            AppTheme.darkBg.withValues(alpha: 0.95),
            AppTheme.primaryColor.withValues(alpha: 0.1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          // Animated background circles
          ...List.generate(5, (index) => _buildFloatingCircle(index, r)),

          // Main content - wrapped in SafeArea and scrollable for small screens
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: r.horizontalPadding,
                        vertical: r.spacing(40),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Greeting
                          Text(
                            'Hello, I\'m',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: AppTheme.secondaryColor,
                                  letterSpacing: 2,
                                  fontSize: r.fontSize(18),
                                ),
                          ),
                          SizedBox(height: r.spacing(16)),

                          // Name
                          ShaderMask(
                            shaderCallback: (bounds) =>
                                AppTheme.primaryGradient.createShader(bounds),
                            child: Text(
                              AppConstants.name,
                              style: Theme.of(context).textTheme.displayLarge
                                  ?.copyWith(
                                    fontSize: r.value(
                                      mobile: 32,
                                      smallPhone: 26,
                                      tablet: 44,
                                      desktop: 56,
                                    ),
                                    color: Colors.white,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: r.spacing(16)),

                          // Static role info
                          Text(
                            'Frontend Mobile & Web Application Developer',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: AppTheme.lightText,
                                  fontWeight: FontWeight.w500,
                                  fontSize: r.fontSize(18),
                                ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: r.spacing(8)),
                          Text(
                            'Android | iOS | WebApp',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: AppTheme.subtleText,
                                  fontSize: r.fontSize(14),
                                ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: r.spacing(24)),

                          // Animated role text
                          SizedBox(
                            height: r.value(
                              mobile: 36,
                              smallPhone: 30,
                              desktop: 50,
                            ),
                            child: DefaultTextStyle(
                              style: Theme.of(context).textTheme.headlineMedium!
                                  .copyWith(
                                    color: AppTheme.subtleText,
                                    fontSize: r.fontSize(22),
                                  ),
                              child: AnimatedTextKit(
                                repeatForever: true,
                                animatedTexts: AppConstants.animatedTexts
                                    .map(
                                      (text) => TypewriterAnimatedText(
                                        text,
                                        speed: const Duration(
                                          milliseconds: 100,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                          SizedBox(height: r.spacing(16)),

                          // Subtitle
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: r.spacing(20),
                              vertical: r.spacing(10),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppTheme.primaryColor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              AppConstants.subtitle,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: AppTheme.primaryColor,
                                    fontSize: r.fontSize(14),
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: r.spacing(40)),

                          // Social links
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildSocialButton(
                                icon: FontAwesomeIcons.linkedin,
                                url: AppConstants.linkedIn,
                                tooltip: 'LinkedIn',
                                r: r,
                              ),
                              SizedBox(width: r.spacing(20)),
                              _buildSocialButton(
                                icon: FontAwesomeIcons.github,
                                url: AppConstants.github,
                                tooltip: 'GitHub',
                                r: r,
                              ),
                              SizedBox(width: r.spacing(20)),
                              _buildSocialButton(
                                icon: FontAwesomeIcons.envelope,
                                url: 'mailto:${AppConstants.email}',
                                tooltip: 'Email',
                                r: r,
                              ),
                            ],
                          ),
                          SizedBox(height: r.spacing(40)),

                          // CTA buttons - full width on mobile
                          if (r.isMobile)
                            Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () => widget.onScrollToSection
                                        ?.call('contact'),
                                    style: ElevatedButton.styleFrom(
                                      padding: r.buttonPadding,
                                    ),
                                    icon: const Icon(Icons.mail_outline),
                                    label: Text(
                                      'Contact Me',
                                      style: TextStyle(
                                        fontSize: r.fontSize(14),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: r.spacing(16)),
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton.icon(
                                    onPressed: () => widget.onScrollToSection
                                        ?.call('projects'),
                                    style: OutlinedButton.styleFrom(
                                      padding: r.buttonPadding,
                                    ),
                                    icon: const Icon(Icons.work_outline),
                                    label: Text(
                                      'View Personal Projects',
                                      style: TextStyle(
                                        fontSize: r.fontSize(14),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          else
                            Wrap(
                              spacing: 20,
                              runSpacing: 16,
                              alignment: WrapAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () =>
                                      widget.onScrollToSection?.call('contact'),
                                  icon: const Icon(Icons.mail_outline),
                                  label: const Text('Contact Me'),
                                ),
                                OutlinedButton.icon(
                                  onPressed: () => widget.onScrollToSection
                                      ?.call('projects'),
                                  icon: const Icon(Icons.work_outline),
                                  label: const Text('View Personal Projects'),
                                ),
                              ],
                            ),
                          // Extra space for scroll indicator
                          SizedBox(height: r.isMobile ? 100 : 80),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Scroll indicator
          Positioned(
            bottom: r.value(mobile: 16, desktop: 40),
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _bounceAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _bounceAnimation.value),
                  child: child,
                );
              },
              child: Center(
                child: GestureDetector(
                  onTap: () => widget.onScrollToSection?.call('about'),
                  child: _buildScrollIndicator(r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingCircle(int index, Responsive r) {
    final positions = [
      const Offset(0.1, 0.2),
      const Offset(0.85, 0.15),
      const Offset(0.75, 0.7),
      const Offset(0.15, 0.75),
      const Offset(0.5, 0.5),
    ];
    final baseSizes = [100.0, 150.0, 80.0, 120.0, 200.0];
    // Scale down circles on mobile
    final scale = r.value(
      mobile: 0.5,
      smallPhone: 0.4,
      tablet: 0.7,
      desktop: 1.0,
    );
    final sizes = baseSizes.map((s) => s * scale).toList();

    final colors = [
      AppTheme.primaryColor.withValues(alpha: 0.1),
      AppTheme.secondaryColor.withValues(alpha: 0.08),
      AppTheme.accentColor.withValues(alpha: 0.1),
      AppTheme.primaryColor.withValues(alpha: 0.06),
      AppTheme.secondaryColor.withValues(alpha: 0.05),
    ];

    return Positioned(
      left: r.width * positions[index].dx,
      top: r.height * positions[index].dy,
      child: Container(
        width: sizes[index],
        height: sizes[index],
        decoration: BoxDecoration(shape: BoxShape.circle, color: colors[index]),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String url,
    required String tooltip,
    required Responsive r,
  }) {
    final size = r.value(mobile: 44.0, smallPhone: 40.0, desktop: 50.0);
    final iconSize = r.value(mobile: 18.0, smallPhone: 16.0, desktop: 20.0);

    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: () => _launchUrl(url),
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.subtleText.withValues(alpha: 0.3),
            ),
          ),
          child: Center(
            child: FaIcon(icon, color: AppTheme.lightText, size: iconSize),
          ),
        ),
      ),
    );
  }

  Widget _buildScrollIndicator(Responsive r) {
    final width = r.value(mobile: 24.0, desktop: 28.0);
    final height = r.value(mobile: 36.0, desktop: 44.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Scroll Down',
          style: TextStyle(
            color: AppTheme.subtleText.withValues(alpha: 0.6),
            fontSize: r.fontSize(12),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppTheme.primaryColor.withValues(alpha: 0.5),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: AnimatedBuilder(
                animation: _scrollIndicatorController,
                builder: (context, child) {
                  return Container(
                    width: 6,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withValues(
                            alpha:
                                0.3 + (_scrollIndicatorController.value * 0.4),
                          ),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
