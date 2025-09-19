import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class MatchHeaderButton extends StatelessWidget {
  final VoidCallback onTap;
  final int newCount;
  final double height;

  const MatchHeaderButton({
    super.key,
    required this.onTap,
    this.newCount = 0,
    this.height = 100,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final border = BorderRadius.circular(18);

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
        // Contenu clippé
          Container(
          margin: const EdgeInsets.fromLTRB(12, 12, 12, 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: SizedBox(
              height: height,
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF6D28D9),
                          Color(0xFF2563EB),
                          Color(0xFFEC4899),
                          Color(0xFFF87171),
                        ],
                        stops: [0.0, 0.4, 0.75, 1.0],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  // Arc rouge
                  Positioned.fill(child: CustomPaint(painter: _RightArcPainter())),

                  // Texte
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18, right: 80),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Mes matchs",
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),

                  if (newCount > 0)
                    Positioned(
                      right: -1,
                      top: height / 2 - 26,
                      child: Text(
                        '$newCount',
                        style: const TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 6,
                              color: Color(0x66000000),
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
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

class _RightArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double d = size.height * 1.4;
    final Offset center = Offset(size.width - d * 0.35, size.height / 2);

    final Rect rect = Rect.fromCircle(center: center, radius: d / 2);
    final Paint p = Paint()
      ..shader = ui.Gradient.linear(
        Offset(rect.left, rect.center.dy),
        Offset(rect.right, rect.center.dy),
        const [
          Color(0xFF991B1B),
          Color(0xFFF87171),
        ],
      );
    canvas.drawCircle(center, d / 2, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BigCount extends StatelessWidget {
  final int count;
  const _BigCount({required this.count});

  @override
  Widget build(BuildContext context) {
    final text = count > 99 ? '99+' : '$count';
    return Stack(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white,
            shadows: [Shadow(blurRadius: 6, color: Color(0x66000000), offset: Offset(0, 2))],
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 28, fontWeight: FontWeight.w900,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 0.6
              ..color = Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
