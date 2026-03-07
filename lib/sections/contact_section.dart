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
      padding: EdgeInsets.symmetric(
        horizontal: r.horizontalPadding,
        vertical: r.sectionVerticalPadding,
      ),
      child: Column(
        children: [
          _buildSectionTitle(context, 'Get In Touch', r),
          SizedBox(height: r.spacing(20)),
          Text(
            'Have a project in mind? Let\'s work together!',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: r.fontSize(14),
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: r.spacing(60)),
          Container(
            constraints: BoxConstraints(maxWidth: r.value(mobile: 400, desktop: 800)),
            child: r.isMobile
                ? Column(
                    children: [
                      _buildContactCard(
                        context,
                        r: r,
                        icon: Icons.email_outlined,
                        title: 'Email',
                        value: AppConstants.email,
                        onTap: _launchEmail,
                      ),
                      SizedBox(height: r.spacing(20)),
                      _buildContactCard(
                        context,
                        r: r,
                        icon: Icons.phone_outlined,
                        title: 'Phone',
                        value: AppConstants.phone,
                        onTap: () => _launchUrl('tel:${AppConstants.phone}'),
                      ),
                      SizedBox(height: r.spacing(20)),
                      _buildContactCard(
                        context,
                        r: r,
                        icon: Icons.location_on_outlined,
                        title: 'Location',
                        value: AppConstants.location,
                        onTap: null,
                      ),
                    ],
                  )
                : IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: _buildContactCard(
                            context,
                            r: r,
                            icon: Icons.email_outlined,
                            title: 'Email',
                            value: AppConstants.email,
                            onTap: _launchEmail,
                          ),
                        ),
                        SizedBox(width: r.spacing(20)),
                        Expanded(
                          child: _buildContactCard(
                            context,
                            r: r,
                            icon: Icons.phone_outlined,
                            title: 'Phone',
                            value: AppConstants.phone,
                            onTap: () => _launchUrl('tel:${AppConstants.phone}'),
                          ),
                        ),
                        SizedBox(width: r.spacing(20)),
                        Expanded(
                          child: _buildContactCard(
                            context,
                            r: r,
                            icon: Icons.location_on_outlined,
                            title: 'Location',
                            value: AppConstants.location,
                            onTap: null,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          SizedBox(height: r.spacing(60)),
          // Social links
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialButton(
                icon: FontAwesomeIcons.linkedin,
                url: AppConstants.linkedIn,
                label: 'LinkedIn',
                r: r,
              ),
              SizedBox(width: r.spacing(20)),
              _buildSocialButton(
                icon: FontAwesomeIcons.github,
                url: AppConstants.github,
                label: 'GitHub',
                r: r,
              ),
            ],
          ),
          SizedBox(height: r.spacing(60)),
          // CTA Button
          SizedBox(
            width: r.isMobile ? double.infinity : null,
            child: ElevatedButton(
              onPressed: _launchEmail,
              style: ElevatedButton.styleFrom(
                padding: r.buttonPadding,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.send, size: r.iconSize),
                  SizedBox(width: r.spacing(12)),
                  Text(
                    'Send Me a Message',
                    style: TextStyle(fontSize: r.fontSize(14)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(
      BuildContext context, String title, Responsive r) {
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

  Widget _buildContactCard(
    BuildContext context, {
    required Responsive r,
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(r.cardRadius),
      child: Container(
        padding: EdgeInsets.all(r.spacing(20)),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(r.cardRadius),
          border: Border.all(
            color: AppTheme.primaryColor.withValues(alpha: 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: r.value(mobile: 12, desktop: 20),
              offset: Offset(0, r.value(mobile: 6, desktop: 10)),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: r.value(mobile: 50, desktop: 60),
              height: r.value(mobile: 50, desktop: 60),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(r.cardRadius * 0.7),
              ),
              child: Icon(icon, color: Colors.white, size: r.iconSize + 2),
            ),
            SizedBox(height: r.spacing(16)),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: r.fontSize(18),
                  ),
            ),
            SizedBox(height: r.spacing(6)),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: onTap != null
                        ? AppTheme.secondaryColor
                        : AppTheme.subtleText,
                    fontSize: r.fontSize(12),
                  ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
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
    required Responsive r,
  }) {
    return OutlinedButton.icon(
      onPressed: () => _launchUrl(url),
      icon: FaIcon(icon, size: r.fontSize(18)),
      label: Text(label, style: TextStyle(fontSize: r.fontSize(14))),
      style: OutlinedButton.styleFrom(
        padding: r.buttonPadding,
      ),
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _launchEmail() async {
    final gmailUrl = Uri.parse(
      'https://mail.google.com/mail/?view=cm&fs=1&to=${AppConstants.email}&su=Hello%20from%20Portfolio',
    );
    final mailtoUrl = Uri.parse(
      'mailto:${AppConstants.email}?subject=Hello%20from%20Portfolio',
    );

    // Try Gmail web first, fallback to mailto
    if (await canLaunchUrl(gmailUrl)) {
      await launchUrl(gmailUrl, mode: LaunchMode.externalApplication);
    } else if (await canLaunchUrl(mailtoUrl)) {
      await launchUrl(mailtoUrl, mode: LaunchMode.externalApplication);
    }
  }
}
