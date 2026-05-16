import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/constants.dart';
import '../core/theme.dart';

class BestWorksSection extends StatefulWidget {
  const BestWorksSection({super.key});

  @override
  State<BestWorksSection> createState() => _BestWorksSectionState();
}

class _BestWorksSectionState extends State<BestWorksSection> {
  int _selectedWorkIndex = 0;
  int _currentScreenshotIndex = 0;

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: r.horizontalPadding,
        vertical: r.sectionVerticalPadding,
      ),
      decoration: BoxDecoration(color: AppTheme.cardBg.withValues(alpha: 0.3)),
      child: Column(
        children: [
          _buildSectionHeader(r),
          SizedBox(height: r.spacing(40)),
          _buildWorkSelector(r),
          SizedBox(height: r.spacing(30)),
          _buildWorkDetailCard(bestWorks[_selectedWorkIndex], r),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(Responsive r) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppTheme.primaryGradient.createShader(bounds),
          child: Text(
            'Some of the Best Works',
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
          'Featured projects showcasing my expertise',
          style: TextStyle(
            color: AppTheme.subtleText,
            fontSize: r.fontSize(14),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildWorkSelector(Responsive r) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(bestWorks.length, (index) {
          final work = bestWorks[index];
          final isSelected = _selectedWorkIndex == index;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: r.spacing(6)),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedWorkIndex = index;
                  _currentScreenshotIndex = 0;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(
                  horizontal: r.spacing(16),
                  vertical: r.spacing(10),
                ),
                decoration: BoxDecoration(
                  gradient: isSelected ? AppTheme.primaryGradient : null,
                  color: isSelected
                      ? null
                      : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (work.status == 'In Progress')
                      Container(
                        width: 6,
                        height: 6,
                        margin: EdgeInsets.only(right: r.spacing(6)),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    Text(
                      work.name,
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppTheme.subtleText,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                        fontSize: r.fontSize(12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildWorkDetailCard(BestWork work, Responsive r) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(r.cardRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(r.cardRadius),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Column(
            children: [
              _buildCardHeader(work, r),
              Padding(
                padding: EdgeInsets.all(r.spacing(24)),
                child: r.isMobile
                    ? Column(
                        children: [
                          _buildScreenshotArea(work, r),
                          SizedBox(height: r.spacing(24)),
                          _buildInfoArea(work, r),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: _buildScreenshotArea(work, r),
                          ),
                          SizedBox(width: r.spacing(30)),
                          Expanded(flex: 6, child: _buildInfoArea(work, r)),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardHeader(BestWork work, Responsive r) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(r.spacing(20)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor.withValues(alpha: 0.15),
            AppTheme.secondaryColor.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(r.cardRadius)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Badges
          Wrap(
            alignment: WrapAlignment.center,
            spacing: r.spacing(8),
            runSpacing: r.spacing(8),
            children: [
              _buildBadge(work.category, AppTheme.secondaryColor, r),
              _buildBadge(
                work.status,
                work.status == 'In Progress'
                    ? Colors.greenAccent
                    : AppTheme.secondaryColor,
                r,
                showDot: work.status == 'In Progress',
              ),
            ],
          ),
          SizedBox(height: r.spacing(14)),
          Text(
            work.name,
            style: TextStyle(
              color: AppTheme.lightText,
              fontSize: r.fontSize(22),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: r.spacing(4)),
          Text(
            work.tagline,
            style: TextStyle(
              color: AppTheme.secondaryColor,
              fontSize: r.fontSize(13),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(
    String text,
    Color color,
    Responsive r, {
    bool showDot = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: r.spacing(10),
        vertical: r.spacing(5),
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot)
            Container(
              width: 5,
              height: 5,
              margin: EdgeInsets.only(right: r.spacing(5)),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: r.fontSize(10),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScreenshotArea(BestWork work, Responsive r) {
    return Column(
      children: [
        // Image with arrows outside
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Left arrow
            if (work.screenshots.length > 1)
              _buildNavArrow(Icons.chevron_left, -1, work, r)
            else
              SizedBox(width: r.spacing(40)),

            SizedBox(width: r.spacing(12)),

            // Main image
            Flexible(
              child: GestureDetector(
                onTap: () => _showFullScreenImage(
                  work.screenshots[_currentScreenshotIndex],
                  r,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: r.value(mobile: 350.0, desktop: 420.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(r.cardRadius - 4),
                      border: Border.all(
                        color: AppTheme.primaryColor.withValues(alpha: 0.2),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(r.cardRadius - 5),
                      child: Stack(
                        children: [
                          Image.asset(
                            work.screenshots[_currentScreenshotIndex],
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => SizedBox(
                              height: 200,
                              child: Center(
                                child: Icon(
                                  Icons.image_outlined,
                                  size: r.fontSize(40),
                                  color: AppTheme.subtleText,
                                ),
                              ),
                            ),
                          ),
                          // Counter badge
                          Positioned(
                            bottom: 8,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: r.spacing(10),
                                  vertical: r.spacing(4),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.zoom_in,
                                      color: Colors.white,
                                      size: r.fontSize(12),
                                    ),
                                    SizedBox(width: r.spacing(4)),
                                    Text(
                                      '${_currentScreenshotIndex + 1}/${work.screenshots.length}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: r.fontSize(10),
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
                  ),
                ),
              ),
            ),

            SizedBox(width: r.spacing(12)),

            // Right arrow
            if (work.screenshots.length > 1)
              _buildNavArrow(Icons.chevron_right, 1, work, r)
            else
              SizedBox(width: r.spacing(40)),
          ],
        ),
        // Thumbnail strip
        if (work.screenshots.length > 1) ...[
          SizedBox(height: r.spacing(12)),
          SizedBox(
            height: r.value(mobile: 50.0, desktop: 60.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(work.screenshots.length, (index) {
                final isActive = index == _currentScreenshotIndex;
                return GestureDetector(
                  onTap: () => setState(() => _currentScreenshotIndex = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: isActive
                        ? r.value(mobile: 50.0, desktop: 60.0)
                        : r.value(mobile: 40.0, desktop: 50.0),
                    height: isActive
                        ? r.value(mobile: 45.0, desktop: 55.0)
                        : r.value(mobile: 38.0, desktop: 45.0),
                    margin: EdgeInsets.symmetric(horizontal: r.spacing(4)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isActive
                            ? AppTheme.primaryColor
                            : Colors.white.withValues(alpha: 0.2),
                        width: isActive ? 2 : 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.asset(
                        work.screenshots[index],
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Container(color: AppTheme.cardBg),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ],
    );
  }

  void _showFullScreenImage(String imagePath, Responsive r) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.9),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(r.spacing(16)),
        child: Stack(
          children: [
            // Zoomable image
            InteractiveViewer(
              minScale: 0.5,
              maxScale: 4.0,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(r.cardRadius),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppTheme.cardBg,
                      child: Icon(
                        Icons.image_outlined,
                        color: AppTheme.subtleText,
                        size: 60,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Close button
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: EdgeInsets.all(r.spacing(12)),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: r.fontSize(24),
                  ),
                ),
              ),
            ),
            // Hint text
            Positioned(
              bottom: r.spacing(20),
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: r.spacing(16),
                    vertical: r.spacing(8),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Pinch to zoom',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: r.fontSize(12),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavArrow(
    IconData icon,
    int direction,
    BestWork work,
    Responsive r,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentScreenshotIndex =
              (_currentScreenshotIndex + direction + work.screenshots.length) %
              work.screenshots.length;
        });
      },
      child: Container(
        padding: EdgeInsets.all(r.spacing(6)),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: r.fontSize(18)),
      ),
    );
  }

  Widget _buildInfoArea(BestWork work, Responsive r) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Description with better spacing
        Text(
          work.description,
          style: TextStyle(
            color: AppTheme.subtleText,
            fontSize: r.fontSize(13),
            height: 1.7,
          ),
        ),
        SizedBox(height: r.spacing(28)),

        // Tech Stack
        _buildInfoSection(
          'Tech Stack',
          Icons.code_rounded,
          r,
          child: Wrap(
            spacing: r.spacing(8),
            runSpacing: r.spacing(8),
            children: work.techStack
                .map(
                  (tech) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: r.spacing(12),
                      vertical: r.spacing(6),
                    ),
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      tech,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: r.fontSize(11),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: r.spacing(28)),

        // Key Features
        _buildInfoSection(
          'Key Features',
          Icons.star_rounded,
          r,
          child: Column(
            children: work.keyFeatures
                .map(
                  (feature) => Padding(
                    padding: EdgeInsets.only(bottom: r.spacing(10)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: r.spacing(5)),
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            gradient: AppTheme.primaryGradient,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: r.spacing(8)),
                        Expanded(
                          child: Text(
                            feature,
                            style: TextStyle(
                              color: AppTheme.subtleText,
                              fontSize: r.fontSize(11),
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),

        // Links
        if (work.githubLink != null || work.playStoreLink != null) ...[
          SizedBox(height: r.spacing(28)),
          Row(
            children: [
              if (work.githubLink != null)
                _buildLinkButton(
                  FontAwesomeIcons.github,
                  'GitHub',
                  work.githubLink!,
                  r,
                ),
              if (work.githubLink != null && work.playStoreLink != null)
                SizedBox(width: r.spacing(12)),
              if (work.playStoreLink != null)
                _buildLinkButton(
                  FontAwesomeIcons.googlePlay,
                  'Play Store',
                  work.playStoreLink!,
                  r,
                ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildInfoSection(
    String title,
    IconData icon,
    Responsive r, {
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: r.fontSize(14), color: AppTheme.secondaryColor),
            SizedBox(width: r.spacing(6)),
            Text(
              title,
              style: TextStyle(
                color: AppTheme.lightText,
                fontSize: r.fontSize(13),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: r.spacing(10)),
        child,
      ],
    );
  }

  Widget _buildLinkButton(
    IconData icon,
    String label,
    String url,
    Responsive r,
  ) {
    return InkWell(
      onTap: () => _launchUrl(url),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: r.spacing(12),
          vertical: r.spacing(8),
        ),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(icon, color: AppTheme.lightText, size: r.fontSize(14)),
            SizedBox(width: r.spacing(8)),
            Text(
              label,
              style: TextStyle(
                color: AppTheme.lightText,
                fontSize: r.fontSize(11),
              ),
            ),
          ],
        ),
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
