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
    final isMobile = Responsive.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.getHorizontalPadding(context),
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: AppTheme.darkBg.withValues(alpha: 0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          ShaderMask(
            shaderCallback: (bounds) =>
                AppTheme.primaryGradient.createShader(bounds),
            child: const Text(
              'ZH',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          // Nav items
          if (!isMobile)
            Row(
              children: [
                _buildNavItem('Home', 'home'),
                _buildNavItem('About', 'about'),
                _buildNavItem('Skills', 'skills'),
                _buildNavItem('Experience', 'experience'),
                _buildNavItem('Best Works', 'bestworks'),
                _buildNavItem('Projects', 'projects'),
                _buildNavItem('Contact', 'contact'),
              ],
            )
          else
            IconButton(
              onPressed: () => _showMobileMenu(context),
              icon: const Icon(Icons.menu, color: AppTheme.lightText),
            ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, String section) {
    final isActive = currentSection == section;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
              ),
            ),
            const SizedBox(height: 4),
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

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMobileNavItem(context, 'Home', 'home'),
            _buildMobileNavItem(context, 'About', 'about'),
            _buildMobileNavItem(context, 'Skills', 'skills'),
            _buildMobileNavItem(context, 'Experience', 'experience'),
            _buildMobileNavItem(context, 'Best Works', 'bestworks'),
            _buildMobileNavItem(context, 'Projects', 'projects'),
            _buildMobileNavItem(context, 'Contact', 'contact'),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNavItem(BuildContext context, String label, String section) {
    final isActive = currentSection == section;
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        onNavTap(section);
      },
      title: Text(
        label,
        style: TextStyle(
          color: isActive ? AppTheme.primaryColor : AppTheme.lightText,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          fontSize: 18,
        ),
      ),
      trailing: isActive
          ? Icon(Icons.arrow_forward_ios, color: AppTheme.primaryColor, size: 16)
          : null,
    );
  }
}
