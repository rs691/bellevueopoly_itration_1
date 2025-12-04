import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/index.dart';
import '../widgets/particle_painter.dart';

class WelcomeBackScreen extends ConsumerStatefulWidget {
  const WelcomeBackScreen({super.key});

  @override
  ConsumerState<WelcomeBackScreen> createState() => _WelcomeBackScreenState();
}

class _WelcomeBackScreenState extends ConsumerState<WelcomeBackScreen>
    with TickerProviderStateMixin {
  late AnimationController _gradientController;
  late AnimationController _contentController;

  @override
  void initState() {
    super.initState();
    _gradientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      _contentController.forward();
    });
  }

  @override
  void dispose() {
    _gradientController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final player = ref.watch(playerProvider);
    final playerName = player?.name ?? 'Explorer';

    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _gradientController,
            builder: (context, child) {
              final animation = _gradientController.value;
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-1 + animation * 2, -1),
                    end: Alignment(1 - animation * 2, 1),
                    colors: const [
                      Color(0xFF5a3a7e),
                      Color(0xFF764ba2),
                      Color(0xFFb565d8),
                      Color(0xFF5a3a7e),
                    ],
                    stops: const [0.0, 0.3, 0.6, 1.0],
                  ),
                ),
              );
            },
          ),
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
          SafeArea(
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: _contentController,
                  curve: Curves.easeIn,
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.emoji_emotions,
                            size: 48,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'BELLEVUEOPOLY',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),
                    Column(
                      children: [
                        Text(
                          'WELCOME BACK',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 2.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$playerName!',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: const Offset(2, 2),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 56),
                    Text(
                      'STOP HUB PARTNERS',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _PartnerButton(
                      companyName: 'Boulevard Company Name',
                      offerDetails: 'offer details',
                      icon: Icons.card_giftcard,
                      onTap: () => context.go('/'),
                    ),
                    const SizedBox(height: 12),
                    _PartnerButton(
                      companyName: 'Boulevard Company Name',
                      offerDetails: 'offer details',
                      icon: Icons.card_giftcard,
                      onTap: () => context.go('/'),
                    ),
                    const SizedBox(height: 12),
                    _PartnerButton(
                      companyName: 'Boulevard Company Name',
                      offerDetails: 'offer details',
                      icon: Icons.card_giftcard,
                      onTap: () => context.go('/'),
                    ),
                    const SizedBox(height: 12),
                    _PartnerButton(
                      companyName: 'Boulevard Company Name',
                      offerDetails: 'offer details',
                      icon: Icons.card_giftcard,
                      onTap: () => context.go('/'),
                    ),
                    const SizedBox(height: 12),
                    _PartnerButton(
                      companyName: 'Boulevard Company Name',
                      offerDetails: 'offer details',
                      icon: Icons.card_giftcard,
                      onTap: () => context.go('/'),
                    ),
                    const SizedBox(height: 48),
                    Column(
                      children: [
                        Text(
                          'TIME REMAINING',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '45 days, 13 hours, 24 minutes',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PartnerButton extends StatefulWidget {
  final String companyName;
  final String offerDetails;
  final IconData icon;
  final VoidCallback onTap;

  const _PartnerButton({
    required this.companyName,
    required this.offerDetails,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_PartnerButton> createState() => _PartnerButtonState();
}

class _PartnerButtonState extends State<_PartnerButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) {
        _scaleController.forward();
        setState(() => _isHovered = true);
      },
      onTapUp: (_) {
        _scaleController.reverse();
        setState(() => _isHovered = false);
      },
      onTapCancel: () {
        _scaleController.reverse();
        setState(() => _isHovered = false);
      },
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 0.98).animate(
          CurvedAnimation(parent: _scaleController, curve: Curves.easeOut),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: const Color(0xFF764ba2).withOpacity(0.5),
            border: Border.all(
              color: Colors.white.withOpacity(_isHovered ? 0.6 : 0.3),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  widget.icon,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.companyName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.offerDetails,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
