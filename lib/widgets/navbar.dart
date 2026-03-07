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

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: r.horizontalPadding,
        vertical: r.spacing(16),
      ),
      decoration: BoxDecoration(
        color: AppTheme.darkBg.withValues(alpha: 0.95),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 10),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          ShaderMask(
            shaderCallback: (bounds) =>
                AppTheme.primaryGradient.createShader(bounds),
            child: Text(
              'MZH',
              style: TextStyle(
                fontSize: r.fontSize(28),
                fontWeight: FontWeight.bold,
                color: Colors.white,
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
                _buildNavItem('Best Works', 'bestworks', r),
                _buildNavItem('Projects', 'projects', r),
                _buildNavItem('Contact', 'contact', r),
              ],
            )
          else
            IconButton(
              onPressed: () => _showMobileMenu(context, r),
              icon: Icon(
                Icons.menu,
                color: AppTheme.lightText,
                size: r.iconSize + 2,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, String section, Responsive r) {
    final isActive = currentSection == section;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.spacing(14)),
      child: InkWell(
        onTap: () => onNavTap(section),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isActive ? AppTheme.primaryColor : AppTheme.lightText,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                fontSize: r.fontSize(14),
              ),
            ),
            SizedBox(height: r.spacing(4)),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: isActive ? 20 : 0,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context, Responsive r) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(r.cardRadius)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(r.spacing(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMobileNavItem(context, 'Home', 'home', r),
            _buildMobileNavItem(context, 'About', 'about', r),
            _buildMobileNavItem(context, 'Skills', 'skills', r),
            _buildMobileNavItem(context, 'Experience', 'experience', r),
            _buildMobileNavItem(context, 'Best Works', 'bestworks', r),
            _buildMobileNavItem(context, 'Projects', 'projects', r),
            _buildMobileNavItem(context, 'Contact', 'contact', r),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNavItem(
    BuildContext context,
    String label,
    String section,
    Responsive r,
  ) {
    final isActive = currentSection == section;
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        onNavTap(section);
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: r.spacing(8),
        vertical: r.spacing(4),
      ),
      title: Text(
        label,
        style: TextStyle(
          color: isActive ? AppTheme.primaryColor : AppTheme.lightText,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          fontSize: r.fontSize(16),
        ),
      ),
      trailing: isActive
          ? Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.primaryColor,
              size: r.fontSize(16),
            )
          : null,
    );
  }
}
