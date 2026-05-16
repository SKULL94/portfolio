import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/theme.dart';

class NavBar extends StatelessWidget {
  final Function(String) onNavTap;
  final String currentSection;

  const NavBar({
    super.key,
    required this.onNavTap,
    required this.currentSection,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: r.horizontalPadding,
            vertical: r.spacing(12),
          ),
          decoration: BoxDecoration(
            color: AppTheme.darkBg.withValues(alpha: 0.8),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                GestureDetector(
                  onTap: () => onNavTap('home'),
                  child: ShaderMask(
                    shaderCallback: (bounds) =>
                        AppTheme.primaryGradient.createShader(bounds),
                    child: Text(
                      'MZH',
                      style: TextStyle(
                        fontSize: r.fontSize(24),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Nav items
                if (!r.isMobile)
                  Row(
                    children: [
                      _buildNavItem('Home', 'home', r),
                      _buildNavItem('About', 'about', r),
                      _buildNavItem('Skills', 'skills', r),
                      _buildNavItem('Experience', 'experience', r),
                      _buildNavItem('Works', 'bestworks', r),
                      _buildNavItem('Projects', 'projects', r),
                      _buildNavItem('Contact', 'contact', r),
                    ],
                  )
                else
                  _buildMobileMenuButton(context, r),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String label, String section, Responsive r) {
    final isActive = currentSection == section;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.spacing(10)),
      child: InkWell(
        onTap: () => onNavTap(section),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: r.spacing(8),
            vertical: r.spacing(6),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? AppTheme.primaryColor : AppTheme.subtleText,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              fontSize: r.fontSize(13),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileMenuButton(BuildContext context, Responsive r) {
    return InkWell(
      onTap: () => _showMobileMenu(context, r),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.all(r.spacing(8)),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Icon(
          Icons.menu_rounded,
          color: AppTheme.lightText,
          size: r.fontSize(22),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context, Responsive r) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: EdgeInsets.all(r.spacing(24)),
            decoration: BoxDecoration(
              color: AppTheme.cardBg.withValues(alpha: 0.95),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle bar
                  Container(
                    width: 40,
                    height: 4,
                    margin: EdgeInsets.only(bottom: r.spacing(20)),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  // Menu items
                  _buildMobileNavItem(context, 'Home', 'home', Icons.home_rounded, r),
                  _buildMobileNavItem(context, 'About', 'about', Icons.person_rounded, r),
                  _buildMobileNavItem(context, 'Skills', 'skills', Icons.code_rounded, r),
                  _buildMobileNavItem(context, 'Experience', 'experience', Icons.work_rounded, r),
                  _buildMobileNavItem(context, 'Best Works', 'bestworks', Icons.star_rounded, r),
                  _buildMobileNavItem(context, 'Projects', 'projects', Icons.folder_rounded, r),
                  _buildMobileNavItem(context, 'Contact', 'contact', Icons.mail_rounded, r),
                  SizedBox(height: r.spacing(16)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileNavItem(
    BuildContext context,
    String label,
    String section,
    IconData icon,
    Responsive r,
  ) {
    final isActive = currentSection == section;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: r.spacing(4)),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          onNavTap(section);
        },
        borderRadius: BorderRadius.circular(r.cardRadius),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: r.spacing(16),
            vertical: r.spacing(14),
          ),
          decoration: BoxDecoration(
            color: isActive
                ? AppTheme.primaryColor.withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(r.cardRadius),
            border: isActive
                ? Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.3))
                : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isActive ? AppTheme.primaryColor : AppTheme.subtleText,
                size: r.fontSize(20),
              ),
              SizedBox(width: r.spacing(14)),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? AppTheme.primaryColor : AppTheme.lightText,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  fontSize: r.fontSize(15),
                ),
              ),
              const Spacer(),
              if (isActive)
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppTheme.primaryColor,
                  size: r.fontSize(14),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
