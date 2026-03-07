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
    final isMobile = Responsive.isMobile(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight,
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
          ...List.generate(5, (index) => _buildFloatingCircle(index, context)),

          // Main content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.getHorizontalPadding(context),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Greeting
                  Text(
                    'Hello, I\'m',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.secondaryColor,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Name
                  ShaderMask(
                    shaderCallback: (bounds) =>
                        AppTheme.primaryGradient.createShader(bounds),
                    child: Text(
                      AppConstants.name,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: isMobile ? 36 : 56,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Static role info
                  Text(
                    'Frontend Mobile Application Developer',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.lightText,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Android | iOS | WebApp',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: AppTheme.subtleText),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  //       decoration: BoxDecoration(
                  //         color: AppTheme.primaryColor.withValues(alpha: 0.15),
                  //         borderRadius: BorderRadius.circular(20),
                  //       ),
                  //       child: Text(
                  //         'Flutter & Dart',
                  //         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  //               color: AppTheme.primaryColor,
                  //             ),
                  //       ),
                  //     ),
                  //     const SizedBox(width: 12),
                  //     Container(
                  //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  //       decoration: BoxDecoration(
                  //         color: AppTheme.secondaryColor.withValues(alpha: 0.15),
                  //         borderRadius: BorderRadius.circular(20),
                  //       ),
                  //       child: Text(
                  //         '4+ Years Experience',
                  //         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  //               color: AppTheme.secondaryColor,
                  //             ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 24),

                  // Animated role text
                  SizedBox(
                    height: 50,
                    child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.headlineMedium!
                          .copyWith(color: AppTheme.subtleText),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: AppConstants.animatedTexts
                            .map(
                              (text) => TypewriterAnimatedText(
                                text,
                                speed: const Duration(milliseconds: 100),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Subtitle
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.primaryColor),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      AppConstants.subtitle,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Social links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialButton(
                        icon: FontAwesomeIcons.linkedin,
                        url: AppConstants.linkedIn,
                        tooltip: 'LinkedIn',
                      ),
                      const SizedBox(width: 20),
                      _buildSocialButton(
                        icon: FontAwesomeIcons.github,
                        url: AppConstants.github,
                        tooltip: 'GitHub',
                      ),
                      const SizedBox(width: 20),
                      _buildSocialButton(
                        icon: FontAwesomeIcons.envelope,
                        url: 'mailto:${AppConstants.email}',
                        tooltip: 'Email',
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // CTA buttons
                  Wrap(
                    spacing: 20,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => widget.onScrollToSection?.call('contact'),
                        icon: const Icon(Icons.mail_outline),
                        label: const Text('Contact Me'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => widget.onScrollToSection?.call('projects'),
                        icon: const Icon(Icons.work_outline),
                        label: const Text('View Personal Projects'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Scroll indicator with bounce animation
          Positioned(
            bottom: 40,
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
                  child: _buildScrollIndicator(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingCircle(int index, BuildContext context) {
    final positions = [
      const Offset(0.1, 0.2),
      const Offset(0.85, 0.15),
      const Offset(0.75, 0.7),
      const Offset(0.15, 0.75),
      const Offset(0.5, 0.5),
    ];
    final sizes = [100.0, 150.0, 80.0, 120.0, 200.0];
    final colors = [
      AppTheme.primaryColor.withValues(alpha: 0.1),
      AppTheme.secondaryColor.withValues(alpha: 0.08),
      AppTheme.accentColor.withValues(alpha: 0.1),
      AppTheme.primaryColor.withValues(alpha: 0.06),
      AppTheme.secondaryColor.withValues(alpha: 0.05),
    ];

    return Positioned(
      left: MediaQuery.of(context).size.width * positions[index].dx,
      top: MediaQuery.of(context).size.height * positions[index].dy,
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
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: () => _launchUrl(url),
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.subtleText.withValues(alpha: 0.3),
            ),
          ),
          child: Center(
            child: FaIcon(icon, color: AppTheme.lightText, size: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildScrollIndicator() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Scroll Down',
          style: TextStyle(
            color: AppTheme.subtleText.withValues(alpha: 0.6),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 28,
          height: 44,
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
                            alpha: 0.3 + (_scrollIndicatorController.value * 0.4),
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
