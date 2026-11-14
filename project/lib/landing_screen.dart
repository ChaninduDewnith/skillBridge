import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

import 'package:material_ui/material_ui.dart';

// ═══════════════════════════════════════════════════════════════
//  Worker Booking App – Landing Screen
//  Save as lib/landing_screen.dart
// ═══════════════════════════════════════════════════════════════

const String appName = 'Hirely'; // TODO: your app name

class LC {
  static const bg = Color(0xFF0A0A12);
  static const surface = Color(0xFF12121D);
  static const violet = Color(0xFF7C5CFF);
  static const cyan = Color(0xFF22D3EE);
  static const amber = Color(0xFFFFB84D);
  static const green = Color(0xFF34D399);
  static const text = Color(0xFFF4F4FA);
  static const muted = Color(0xFF9A9AB0);
  static const gradient = LinearGradient(
    colors: [violet, cyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// ───────────────────────── Landing screen ─────────────────────────

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  final _pages = PageController();
  late final AnimationController _loop = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 12),
  )..repeat();
  int _i = 0;

  static const _copy = [
    (
      'Find trusted\nworkers nearby',
      'Verified plumbers, electricians, cleaners and more, just minutes away.',
    ),
    (
      'Book in under\na minute',
      'Compare ratings and upfront prices, then lock in a time that suits you.',
    ),
    (
      'Track live,\npay securely',
      'Watch your pro arrive in real time and pay only when the job is done.',
    ),
  ];

  @override
  void dispose() {
    _pages.dispose();
    _loop.dispose();
    super.dispose();
  }

  // TODO: navigate to your sign-up / login screen here.
  void _getStarted() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Get started tapped')));
    // Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpScreen()));
  }

  void _login() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Log in tapped')));
  }

  Widget _glow(Color c, double size) => IgnorePointer(
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [c.withOpacity(0.3), c.withOpacity(0)],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    Widget visual(Widget child) => FittedBox(
      fit: BoxFit.scaleDown,
      child: SizedBox(width: 340, height: 400, child: child),
    );

    return Scaffold(
      backgroundColor: LC.bg,
      body: Stack(
        children: [
          Positioned(top: -160, left: -140, child: _glow(LC.violet, 520)),
          Positioned(bottom: -180, right: -160, child: _glow(LC.cyan, 520)),
          SafeArea(
            child: Column(
              children: [
                // Top bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 14, 24, 0),
                  child: Row(
                    children: const [
                      IconTile(Icons.handyman_rounded, size: 36),
                      SizedBox(width: 10),
                      Text(
                        appName,
                        style: TextStyle(
                          color: LC.text,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // Swipeable visuals
                Expanded(
                  child: PageView(
                    controller: _pages,
                    onPageChanged: (v) => setState(() => _i = v),
                    children: [
                      visual(_OrbitVisual(_loop)),
                      visual(_CardStackVisual(_loop)),
                      visual(_RouteVisual(_loop)),
                    ],
                  ),
                ),

                // Text + indicator + buttons
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 350),
                        transitionBuilder: (child, anim) => FadeTransition(
                          opacity: anim,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.12),
                              end: Offset.zero,
                            ).animate(anim),
                            child: child,
                          ),
                        ),
                        child: Column(
                          key: ValueKey(_i),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _copy[_i].$1,
                              style: const TextStyle(
                                color: LC.text,
                                fontSize: 34,
                                height: 1.1,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -1,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _copy[_i].$2,
                              style: const TextStyle(
                                color: LC.muted,
                                fontSize: 15,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                      Row(
                        children: [
                          for (int k = 0; k < _copy.length; k++)
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                              margin: const EdgeInsets.only(right: 6),
                              width: k == _i ? 28 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                gradient: k == _i ? LC.gradient : null,
                                color: k == _i
                                    ? null
                                    : Colors.white.withOpacity(0.18),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      _GetStartedButton(onTap: _getStarted),
                      const SizedBox(height: 6),
                      Center(
                        child: TextButton(
                          onPressed: _login,
                          child: const Text.rich(
                            TextSpan(
                              text: 'Already have an account?  ',
                              style: TextStyle(color: LC.muted, fontSize: 14),
                              children: [
                                TextSpan(
                                  text: 'Log in',
                                  style: TextStyle(
                                    color: LC.cyan,
                                    fontWeight: FontWeight.w700,
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
          ),
        ],
      ),
    );
  }
}

// ───────────────────────── Shared widgets ─────────────────────────

class _GetStartedButton extends StatelessWidget {
  const _GetStartedButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: LC.violet.withOpacity(0.4),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            gradient: LC.gradient,
            borderRadius: BorderRadius.circular(20),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onTap,
            child: const SizedBox(
              height: 58,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Get started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class IconTile extends StatelessWidget {
  const IconTile(this.icon, {super.key, this.size = 48});
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LC.gradient,
        borderRadius: BorderRadius.circular(size * 0.32),
      ),
      child: Icon(icon, color: Colors.white, size: size * 0.5),
    );
  }
}

class Glass extends StatelessWidget {
  const Glass({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.radius = 24,
  });
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: Colors.white.withOpacity(0.12)),
          ),
          child: child,
        ),
      ),
    );
  }
}

// ═══════════════ Slide 1: orbiting services ═══════════════

class _OrbitVisual extends StatelessWidget {
  const _OrbitVisual(this.t);
  final Animation<double> t;

  static const _icons = [
    Icons.plumbing,
    Icons.electrical_services,
    Icons.cleaning_services,
    Icons.format_paint,
    Icons.carpenter,
    Icons.ac_unit,
  ];
  static const _colors = [
    LC.cyan,
    LC.amber,
    LC.green,
    LC.violet,
    LC.amber,
    LC.cyan,
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: t,
      builder: (context, _) {
        const s = 340.0;
        final a = t.value * 2 * math.pi;
        final pulse = (math.sin(a * 3) + 1) / 2;
        return Stack(
          alignment: Alignment.center,
          children: [
            for (final f in const [0.5, 0.78, 1.0])
              Container(
                width: s * f,
                height: s * f,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.07)),
                ),
              ),
            Container(
              width: 110 + 60 * pulse,
              height: 110 + 60 * pulse,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: LC.violet.withOpacity(0.2 * (1 - pulse)),
              ),
            ),
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LC.gradient,
                boxShadow: [
                  BoxShadow(color: LC.violet.withOpacity(0.55), blurRadius: 50),
                ],
              ),
              child: const Icon(
                Icons.handyman_rounded,
                color: Colors.white,
                size: 48,
              ),
            ),
            for (int i = 0; i < _icons.length; i++)
              Transform.translate(
                offset: Offset(
                  math.cos(a + i * 2 * math.pi / 6) * s * 0.39,
                  math.sin(a + i * 2 * math.pi / 6) * s * 0.39,
                ),
                child: Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: LC.surface,
                    border: Border.all(color: Colors.white.withOpacity(0.12)),
                    boxShadow: [
                      BoxShadow(
                        color: _colors[i].withOpacity(0.25),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Icon(_icons[i], color: _colors[i], size: 26),
                ),
              ),
          ],
        );
      },
    );
  }
}

// ═══════════════ Slide 2: stacked worker cards ═══════════════

class _CardStackVisual extends StatelessWidget {
  const _CardStackVisual(this.t);
  final Animation<double> t;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: t,
      builder: (context, _) {
        final w = math.sin(t.value * 2 * math.pi * 3);
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 40,
              left: 24,
              right: 24,
              child: Opacity(
                opacity: 0.35,
                child: _card(
                  'Ravi D.',
                  'Painter',
                  '4.7',
                  '\$16/h',
                  LC.green,
                  false,
                ),
              ),
            ),
            Positioned(
              top: 74,
              left: 12,
              right: 12,
              child: Opacity(
                opacity: 0.6,
                child: _card(
                  'Sanduni R.',
                  'Cleaner',
                  '5.0',
                  '\$14/h',
                  LC.amber,
                  false,
                ),
              ),
            ),
            Positioned(
              top: 112 + w * 6,
              left: 0,
              right: 0,
              child: _card(
                'Kasun P.',
                'Plumber · 6 yrs',
                '4.9',
                '\$18/h',
                LC.violet,
                true,
              ),
            ),
            Positioned(
              bottom: 36 - w * 8,
              right: 4,
              child: Glass(
                radius: 20,
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: LC.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: LC.green,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Booking confirmed',
                          style: TextStyle(
                            color: LC.text,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Tomorrow · 10:00 AM',
                          style: TextStyle(color: LC.muted, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _card(
    String name,
    String job,
    String rating,
    String price,
    Color color,
    bool front,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: LC.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 30,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  name[0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: LC.text,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      job,
                      style: const TextStyle(color: LC.muted, fontSize: 13),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: LC.amber.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star_rounded, color: LC.amber, size: 16),
                    const SizedBox(width: 3),
                    Text(
                      rating,
                      style: const TextStyle(
                        color: LC.amber,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'From',
                    style: TextStyle(color: LC.muted, fontSize: 12),
                  ),
                  Text(
                    price,
                    style: const TextStyle(
                      color: LC.cyan,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              if (front)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    gradient: LC.gradient,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Text(
                    'Book now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════ Slide 3: live route tracking ═══════════════

class _RouteVisual extends StatelessWidget {
  const _RouteVisual(this.t);
  final Animation<double> t;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: t,
      builder: (context, _) {
        final p = Curves.easeInOut.transform((t.value * 3) % 1);
        return Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(36),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(36),
            child: Stack(
              children: [
                Positioned.fill(child: CustomPaint(painter: _RoutePainter(p))),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: Glass(
                    radius: 24,
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        const IconTile(Icons.directions_walk_rounded, size: 44),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Arriving in 12 min',
                                style: TextStyle(
                                  color: LC.text,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                'Kasun P. · Plumber',
                                style: TextStyle(color: LC.muted, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: LC.green.withOpacity(0.18),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.call_rounded,
                            color: LC.green,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RoutePainter extends CustomPainter {
  _RoutePainter(this.p);
  final double p;

  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1;
    for (double x = 0; x <= size.width; x += 34) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y <= size.height; y += 34) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final w = size.width, h = size.height;
    final path = Path()
      ..moveTo(w * 0.14, h * 0.62)
      ..cubicTo(w * 0.1, h * 0.38, w * 0.55, h * 0.5, w * 0.5, h * 0.3)
      ..cubicTo(w * 0.46, h * 0.12, w * 0.9, h * 0.2, w * 0.84, h * 0.08);

    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round
        ..color = Colors.white.withOpacity(0.1),
    );

    final m = path.computeMetrics().first;
    canvas.drawPath(
      m.extractPath(0, m.length * p),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round
        ..shader = LC.gradient.createShader(Offset.zero & size),
    );

    final end = m.getTangentForOffset(m.length)!.position;
    canvas.drawCircle(end, 18, Paint()..color = LC.cyan.withOpacity(0.2));
    canvas.drawCircle(end, 8, Paint()..color = LC.cyan);

    final pos = m.getTangentForOffset(m.length * p)!.position;
    canvas.drawCircle(pos, 26, Paint()..color = LC.violet.withOpacity(0.28));
    canvas.drawCircle(pos, 12, Paint()..color = Colors.white);
    canvas.drawCircle(pos, 7, Paint()..color = LC.violet);
  }

  @override
  bool shouldRepaint(covariant _RoutePainter old) => old.p != p;
}
