import 'dart:ui';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/constants.dart';
import '../core/theme.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: r.horizontalPadding,
        vertical: r.sectionVerticalPadding,
      ),
      decoration: BoxDecoration(
        color: AppTheme.cardBg.withValues(alpha: 0.3),
      ),
      child: Column(
        children: [
          _buildSectionHeader(r),
          SizedBox(height: r.spacing(50)),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                // Contact cards
                r.isMobile
                    ? Column(
                        children: [
                          _buildContactCard(Icons.email_rounded, 'Email', AppConstants.email, () => _launchEmail(context), r),
                          SizedBox(height: r.spacing(12)),
                          _buildContactCard(Icons.phone_rounded, 'Phone', AppConstants.phone, () => _launchUrl('tel:${AppConstants.phone}'), r),
                          SizedBox(height: r.spacing(12)),
                          _buildContactCard(Icons.location_on_rounded, 'Location', AppConstants.location, null, r),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(child: _buildContactCard(Icons.email_rounded, 'Email', AppConstants.email, () => _launchEmail(context), r)),
                          SizedBox(width: r.spacing(16)),
                          Expanded(child: _buildContactCard(Icons.phone_rounded, 'Phone', AppConstants.phone, () => _launchUrl('tel:${AppConstants.phone}'), r)),
                          SizedBox(width: r.spacing(16)),
                          Expanded(child: _buildContactCard(Icons.location_on_rounded, 'Location', AppConstants.location, null, r)),
                        ],
                      ),

                SizedBox(height: r.spacing(40)),

                // Social links
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton(FontAwesomeIcons.linkedin, AppConstants.linkedIn, r),
                    SizedBox(width: r.spacing(16)),
                    _buildSocialButton(FontAwesomeIcons.github, AppConstants.github, r),
                  ],
                ),

                SizedBox(height: r.spacing(40)),

                // CTA Button
                SizedBox(
                  width: r.isMobile ? double.infinity : null,
                  child: InkWell(
                    onTap: () => _launchEmail(context),
                    borderRadius: BorderRadius.circular(r.cardRadius),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: r.spacing(32),
                        vertical: r.spacing(16),
                      ),
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        borderRadius: BorderRadius.circular(r.cardRadius),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.send_rounded, color: Colors.white, size: r.fontSize(18)),
                          SizedBox(width: r.spacing(12)),
                          Text(
                            'Send Me a Message',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: r.fontSize(14),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(Responsive r) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
          child: Text(
            'Get In Touch',
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
        SizedBox(height: r.spacing(16)),
        Text(
          "Have a project in mind? Let's work together!",
          style: TextStyle(
            color: AppTheme.subtleText,
            fontSize: r.fontSize(14),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildContactCard(IconData icon, String title, String value, VoidCallback? onTap, Responsive r) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(r.cardRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(r.cardRadius),
          child: Container(
            padding: EdgeInsets.all(r.spacing(20)),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(r.cardRadius),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(r.spacing(12)),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Colors.white, size: r.fontSize(20)),
                ),
                SizedBox(height: r.spacing(14)),
                Text(
                  title,
                  style: TextStyle(
                    color: AppTheme.lightText,
                    fontSize: r.fontSize(14),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: r.spacing(4)),
                Text(
                  value,
                  style: TextStyle(
                    color: onTap != null ? AppTheme.secondaryColor : AppTheme.subtleText,
                    fontSize: r.fontSize(11),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String url, Responsive r) {
    return InkWell(
      onTap: () => _launchUrl(url),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(r.spacing(14)),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: FaIcon(icon, color: AppTheme.lightText, size: r.fontSize(22)),
      ),
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _launchEmail(BuildContext context) async {
    final subject = Uri.encodeComponent("Hey let's connect for work");
    final r = Responsive(context);

    if (r.isMobile) {
      // Mobile: Use mailto which opens Gmail app with prefilled fields
      final mailtoUrl = Uri.parse(
        'mailto:${AppConstants.email}?subject=$subject',
      );
      if (await canLaunchUrl(mailtoUrl)) {
        await launchUrl(mailtoUrl, mode: LaunchMode.externalApplication);
      }
    } else {
      // Desktop: Open Gmail web compose with prefilled fields
      final gmailUrl = Uri.parse(
        'https://mail.google.com/mail/?view=cm&fs=1&to=${AppConstants.email}&su=$subject',
      );
      if (await canLaunchUrl(gmailUrl)) {
        await launchUrl(gmailUrl, mode: LaunchMode.externalApplication);
      }
    }
  }
}
