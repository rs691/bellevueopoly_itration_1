import 'package:flutter/material.dart';
import '../models/business.dart';
import '../theme/app_theme.dart';

/// Floating business card for displaying businesses in a list
/// Matches the mockup design with pink accent and white content area
class BusinessCard extends StatelessWidget {
  final Business business;
  final VoidCallback onTap;
  final bool showCheckInBadge;
  
  const BusinessCard({
    super.key,
    required this.business,
    required this.onTap,
    this.showCheckInBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 15,
              spreadRadius: 2,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pink header with company name
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFE91E63), // Hot pink
                    Color(0xFFD81B60), // Slightly darker pink
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      business.name.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  // Logo placeholder
                  Container(
                    width: 50,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        'LOGO',
                        style: TextStyle(
                          color: AppTheme.darkPurple,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // White content area
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Call to action section
                  Text(
                    '• CALL TO ACTION: "Check in (Future: QR scan / geofence trigger)"',
                    style: TextStyle(
                      color: AppTheme.darkPurple,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '• Description / promo message',
                    style: TextStyle(
                      color: AppTheme.darkPurple,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '• Sponsor info (optional ad space)',
                    style: TextStyle(
                      color: AppTheme.darkPurple,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '• Rules',
                    style: TextStyle(
                      color: AppTheme.darkPurple,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Description text
                  Text(
                    business.pitch,
                    style: TextStyle(
                      color: AppTheme.darkPurple.withOpacity(0.8),
                      fontSize: 11,
                      height: 1.5,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  // Read More link
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: onTap,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Read More',
                        style: TextStyle(
                          color: Color(0xFF00BCD4), // Cyan
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Animated version with scale effect
class AnimatedBusinessCard extends StatefulWidget {
  final Business business;
  final VoidCallback onTap;
  final bool showCheckInBadge;
  
  const AnimatedBusinessCard({
    super.key,
    required this.business,
    required this.onTap,
    this.showCheckInBadge = false,
  });

  @override
  State<AnimatedBusinessCard> createState() => _AnimatedBusinessCardState();
}

class _AnimatedBusinessCardState extends State<AnimatedBusinessCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: BusinessCard(
          business: widget.business,
          onTap: () {}, // Handled by gesture detector
          showCheckInBadge: widget.showCheckInBadge,
        ),
      ),
    );
  }
}
