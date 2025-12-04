import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _gradientController;
  late AnimationController _titleController;
  late AnimationController _subtitleController;

  @override
  void initState() {
    super.initState();

    // Gradient animation (continuous loop)
    _gradientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    // Title animation (scale + fade in)
    _titleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Subtitle animation (fade in after title)
    _subtitleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Start animations
    _titleController.forward();
    Future.delayed(const Duration(milliseconds: 600), () {
      _subtitleController.forward();
    });

    // Auto-navigate to home after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        context.go('/');
      }
    });
  }

  @override
  void dispose() {
    _gradientController.dispose();
    _titleController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated gradient background
          AnimatedBuilder(
            animation: _gradientController,
            builder: (context, child) {
              final animation = _gradientController.value;
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-1 + animation * 2, -1),
                    end: Alignment(1 - animation * 2, 1),
                    colors: [
                      const Color(0xFF667eea).withOpacity(0.8),
                      const Color(0xFF764ba2).withOpacity(0.8),
                      const Color(0xFFf093fb).withOpacity(0.7),
                      const Color(0xFF4facfe).withOpacity(0.8),
                    ],
                    stops: const [0.0, 0.3, 0.6, 1.0],
                  ),
                ),
              );
            },
          ),

          // Animated particles/dots (optional subtle effect)
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _gradientController,
              builder: (context, child) {
                return CustomPaint(
                  painter: ParticlePainter(
                    animationValue: _gradientController.value,
                  ),
                );
              },
            ),
          ),

          // Center content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated title with scale and fade
                ScaleTransition(
                  scale: Tween<double>(begin: 0.5, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _titleController,
                      curve: Curves.elasticOut,
                    ),
                  ),
                  child: FadeTransition(
                    opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: _titleController,
                        curve: const Interval(0.0, 0.7),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Main title
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white.withOpacity(0.7),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: Text(
                            'BELLEVUEOPOLY',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              fontSize: 56,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 3.5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Subtitle with delayed fade
                        FadeTransition(
                          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                              parent: _subtitleController,
                              curve: Curves.easeIn,
                            ),
                          ),
                          child: Text(
                            'Discover • Earn • Own',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 2.0,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 60),

                // Pulsing play button indicator
                FadeTransition(
                  opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _subtitleController,
                      curve: const Interval(0.3, 1.0),
                    ),
                  ),
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 0.8, end: 1.2).animate(
                      CurvedAnimation(
                        parent: _gradientController,
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.6),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white.withOpacity(0.8),
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Loading text at bottom
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 0.6).animate(
                CurvedAnimation(
                  parent: _subtitleController,
                  curve: const Interval(0.5, 1.0),
                ),
              ),
              child: Text(
                'Loading...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.6),
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for subtle animated particles
class ParticlePainter extends CustomPainter {
  final double animationValue;

  ParticlePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..isAntiAlias = true;

    // Draw a few animated floating particles
    final particles = [
      _Particle(0.2, 0.3, 8),
      _Particle(0.8, 0.2, 6),
      _Particle(0.5, 0.8, 10),
      _Particle(0.1, 0.7, 5),
      _Particle(0.9, 0.6, 7),
    ];

    for (final particle in particles) {
      final dx = size.width * particle.x +
          math.sin(animationValue * math.pi * 2 + particle.phase) * 20;
      final dy = size.height * particle.y +
          math.cos(animationValue * math.pi * 2 + particle.phase) * 20;

      canvas.drawCircle(Offset(dx, dy), particle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}

class _Particle {
  final double x;
  final double y;
  final double radius;
  final double phase = 0;

  _Particle(this.x, this.y, this.radius);
}
