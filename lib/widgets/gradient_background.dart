import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Animated gradient background with floating particles
class GradientBackground extends StatefulWidget {
  final Widget child;
  final bool showParticles;
  
  const GradientBackground({
    super.key,
    required this.child,
    this.showParticles = true,
  });

  @override
  State<GradientBackground> createState() => _GradientBackgroundState();
}

class _GradientBackgroundState extends State<GradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradient background
        Container(
          decoration: const BoxDecoration(
            gradient: AppTheme.backgroundGradient,
          ),
        ),
        
        // Animated particles (coins, dice)
        if (widget.showParticles)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: ParticlesPainter(
                  animation: _controller,
                ),
                size: Size.infinite,
              );
            },
          ),
        
        // Content
        widget.child,
      ],
    );
  }
}

class ParticlesPainter extends CustomPainter {
  final Animation<double> animation;
  
  ParticlesPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Draw floating circles (coins)
    for (int i = 0; i < 15; i++) {
      final offset = Offset(
        (size.width * 0.1 * i) % size.width,
        (size.height * 0.15 * i + animation.value * size.height) % size.height,
      );
      canvas.drawCircle(offset, 8 + (i % 3) * 4, paint);
    }
    
    // Draw confetti-like shapes
    final confettiPaint = Paint()
      ..color = AppTheme.accentOrange.withOpacity(0.2)
      ..style = PaintingStyle.fill;
      
    for (int i = 0; i < 10; i++) {
      final offset = Offset(
        (size.width * 0.15 * i + animation.value * 50) % size.width,
        (size.height * 0.2 * i) % size.height,
      );
      canvas.drawRect(
        Rect.fromCenter(center: offset, width: 6, height: 12),
        confettiPaint,
      );
    }
  }

  @override
  bool shouldRepaint(ParticlesPainter oldDelegate) => true;
}
