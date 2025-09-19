import 'package:flutter/material.dart';
import '../main.dart';
import 'package:nebula_app/screens/subscreens/notifications_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ---- Couleurs ----
    const yellow = Color(0xFFFFF25A);
    const blue = Color(0xFF1C15BC);
    const lightBlue = Color(0xFF36A3DB);
    const bg = Color(0xFFF8F8FF);

    // ---- INVESTS DÉMO ----
    final invests = [
      _InvestProgressCard(
        company: "Green Future Solutions",
        progress: 0.72,
        amount: "420 €",
        onTap: () {},
        progressColor: Colors.blue,
      ),
      _InvestProgressCard(
        company: "EcoTrack",
        progress: 0.37,
        amount: "2 100 €",
        onTap: () {},
        progressColor: Colors.green,
      ),
    ];

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // ---- HEADER ----
            SizedBox(
              height: 56,
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: FractionallySizedBox(
                        heightFactor: 0.7,
                        child: Image.asset(
                          "assets/images/fundly_nb.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: IconButton(
                        icon: const Icon(Icons.notifications_none, color: Colors.black, size: 32),
                        splashRadius: 22,
                        onPressed: () => pushPeerSlide(context, const NotificationsScreen()),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ---- BLOC FLAGSHIP ----
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/company_placeholder.png",
                      height: 340,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      left: 0, right: 0, bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.50),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Startup à la une",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Découvrez la levée de fonds en cours pour Green Future Solutions",
                                    style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: yellow,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 0,
                              ),
                              onPressed: () {},
                              child: Text(
                                "Découvrir",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ---- DERNIERS SUCCÈS ----- (scroll horizontal)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Derniers succès",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _SuccessCard(
                          title: "Levée complétée !",
                          subtitle: "EcoTrack a réuni 700k€",
                          color: lightBlue,
                        ),
                        const SizedBox(width: 12),
                        _SuccessCard(
                          title: "Record d'investisseurs",
                          subtitle: "FutureAI a séduit 350 personnes",
                          color: yellow,
                          textColor: Colors.black,
                        ),
                        const SizedBox(width: 12),
                        _SuccessCard(
                          title: "Startup de la semaine",
                          subtitle: "GreenGen s'envole",
                          color: Colors.greenAccent,
                          textColor: Colors.black,
                        ),
                        const SizedBox(width: 12),
                        _SeeMoreCard(
                          onTap: () {
                            Navigator.pushNamed(context, "/feed");
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ---- MES INVESTISSEMENTS (et performances) ----
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mes investissements",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20,
                      color: blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...invests,
                  const SizedBox(height: 14),
                  _MiniPerformanceChart(
                    values: [0.3, 0.7, 0.6, 0.83, 0.86, 0.57, 0.9],
                  ),
                ],
              ),
            ),

            // ---- FUNDLY : Article & Chiffres-clés ----
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fundly",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20,
                      color: blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _DataVizCard(),
                  const SizedBox(height: 5),
                  ArticleCard(
                    title: "Article du jour",
                    subtitle: "Comment investir dans les startups et réduire ses impôts ?",
                    imagePath: "assets/images/fundly_logo.png",
                    onTap: () {
                        // TODO: Page de l'article
                    },
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---- Widgets ----
class _SeeMoreCard extends StatelessWidget {
  final VoidCallback onTap;
  const _SeeMoreCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_forward, color: Colors.deepPurple, size: 32),
              const SizedBox(height: 4),
              Text("Voir\nplus",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.deepPurple,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class _SuccessCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final Color textColor;

  const _SuccessCard({
    required this.title,
    required this.subtitle,
    required this.color,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 120,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: textColor,
              )),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 12,
              color: textColor.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniPerformanceChart extends StatelessWidget {
  final List<double> values;

  const _MiniPerformanceChart({
    this.values = const [0.7, 0.9, 0.6, 1.0, 0.8],
  });

  @override
  Widget build(BuildContext context) {
    const double chartHeight = 80;
    const double pointRadius = 6;
    const double lineWidth = 2.0;

    final double minValue = values.reduce((a, b) => a < b ? a : b);
    final double maxValue = values.reduce((a, b) => a > b ? a : b);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              "Performances du portefeuille",
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 11,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          SizedBox(
            height: chartHeight,
            width: double.infinity,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return CustomPaint(
                  size: Size(constraints.maxWidth, chartHeight),
                  painter: _PerformancePainter(
                    values: values,
                    minValue: minValue,
                    maxValue: maxValue,
                    pointRadius: pointRadius,
                    lineWidth: lineWidth,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class _PerformancePainter extends CustomPainter {
  final List<double> values;
  final double minValue, maxValue;
  final double pointRadius, lineWidth;

  _PerformancePainter({
    required this.values,
    required this.minValue,
    required this.maxValue,
    required this.pointRadius,
    required this.lineWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke;

    final Paint dotPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final Paint axisPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1.0;

    final int n = values.length;
    if (n < 2) return;

    // Position horizontale des points
    final double spacing = size.width / (n - 1);

    List<Offset> points = List.generate(n, (i) {
      double x = i * spacing;
      // Inversé pour avoir maxValue en haut (coord y descend vers le bas)
      double y = size.height * (1 - (values[i] - minValue) / (maxValue - minValue + 0.001));
      return Offset(x, y);
    });

    // Traits reliant les points
    for (int i = 0; i < n - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], linePaint);
    }

    // Traits verticaux vers l'axe des abscisses
    for (final pt in points) {
      canvas.drawLine(pt, Offset(pt.dx, size.height), axisPaint);
    }

    // Points ronds
    for (final pt in points) {
      canvas.drawCircle(pt, pointRadius, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


class _InvestProgressCard extends StatelessWidget {
  final String company;
  final double progress;
  final String amount;
  final Color progressColor;
  final VoidCallback? onTap;

  const _InvestProgressCard({
    required this.company,
    required this.progress,
    required this.amount,
    this.progressColor = const Color(0xFF1C15BC),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap ?? () {},
        child: Container(
          margin: const EdgeInsets.only(bottom: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFF8F8FF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage("assets/images/fundly_logo.png"),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      company,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 5),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey[300],
                        color: progressColor,
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                amount,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DataVizCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 5,
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            "Montant total levé via la plateforme",
            style: TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "2 100 000 €",
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text("Startups",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 13,
                          color: Colors.black54)),
                  const SizedBox(height: 4),
                  Text("32",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black)),
                ],
              ),
              Column(
                children: [
                  Text("Investisseurs",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 13,
                          color: Colors.black54)),
                  const SizedBox(height: 4),
                  Text("244",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class ArticleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final VoidCallback? onTap;

  const ArticleCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.imagePath = "assets/images/fundly_logo.png",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF8F8FF),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        highlightColor: Colors.transparent,
        splashColor: Colors.grey.withOpacity(0.12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 66,
                height: 66,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 13,
                        color: Colors.black87,
                      ),
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




