import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grub_monkeys/widgets/bottom_navigation.dart';
import 'package:grub_monkeys/widgets/common_topbar.dart';

class AppColors {
  static const primary = Color(0xFFF47C2E);
  static const primaryLight = Color(0xFFFFF0E6);
  static const background = Color(0xFFF8F8F8);
  static const white = Color(0xFFFFFFFF);
  static const textDark = Color(0xFF1A1A1A);
  static const textMedium = Color(0xFF555555);
  static const textLight = Color(0xFF9E9E9E);
  static const border = Color(0xFFEEEEEE);
  static const divider = Color(0xFFF2F2F2);
  static const cardShadow = Color(0x0A000000);
  static const chartBlue = Color(0xFF3B6FE8);
  static const chartBlueFill = Color(0x183B6FE8);
  static const positiveGreen = Color(0xFF22C55E);
  static const negativeRed = Color(0xFFEF4444);
  static const purpleBg = Color(0xFFF0EFFE);
  static const purpleFg = Color(0xFF7C6FE8);
  static const greenBg = Color(0xFFE8F8EE);
  static const greenFg = Color(0xFF22A05E);
  static const orangeBg = Color(0xFFFFF0E6);
  static const orangeFg = Color(0xFFF47C2E);
  static const blueBg = Color(0xFFE6F1FB);
  static const blueFg = Color(0xFF3B82F6);
  static const redBg = Color(0xFFFFEEEE);
  static const redFg = Color(0xFFEF4444);
  static const infoBannerBg = Color(0xFFEFF4FF);
  static const infoBannerIcon = Color(0xFF3B6FE8);
  static const barBlue = Color(0xFF3B6FE8);
  static const barPurple = Color(0xFF7C6FE8);
  static const barGrey = Color(0xFFE0E0E0);
  static const navActive = Color(0xFFF47C2E);
  static const navInactive = Color(0xFF9E9E9E);
}

class StatCardData {
  final IconData icon;
  final Color iconBg;
  final Color iconFg;
  final String label;
  final String value;
  final double changePercent;
  final bool positiveIsGood;

  const StatCardData({
    required this.icon,
    required this.iconBg,
    required this.iconFg,
    required this.label,
    required this.value,
    required this.changePercent,
    this.positiveIsGood = true,
  });
}

class BarRowData {
  final String label;
  final double fraction;
  final String displayValue;
  final Color barColor;
  final String? flagCode;

  const BarRowData({
    required this.label,
    required this.fraction,
    required this.displayValue,
    required this.barColor,
    this.flagCode,
  });
}

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});
  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String selectedRange = 'Last 7 Days';
  static const List<double> _chartData = [0, 0, 2, 36, 39, 21, 16, 35];
  static const List<StatCardData> _stats = [
    StatCardData(
      icon: Icons.person_outline_rounded,
      iconBg: AppColors.purpleBg,
      iconFg: AppColors.purpleFg,
      label: 'Visitors',
      value: '144',
      changePercent: 12.5,
    ),
    StatCardData(
      icon: Icons.insert_drive_file_outlined,
      iconBg: AppColors.greenBg,
      iconFg: AppColors.greenFg,
      label: 'Pageviews',
      value: '214',
      changePercent: 8.3,
    ),
    StatCardData(
      icon: Icons.remove_red_eye_outlined,
      iconBg: AppColors.orangeBg,
      iconFg: AppColors.orangeFg,
      label: 'Views Per Visit',
      value: '1.49',
      changePercent: -4.2,
    ),
    StatCardData(
      icon: Icons.access_time_rounded,
      iconBg: AppColors.blueBg,
      iconFg: AppColors.blueFg,
      label: 'Visit Duration',
      value: '1m 27s',
      changePercent: 6.1,
    ),
    StatCardData(
      icon: Icons.arrow_forward_rounded,
      iconBg: AppColors.redBg,
      iconFg: AppColors.redFg,
      label: 'Bounce Rate',
      value: '82%',
      changePercent: 3.7,
      positiveIsGood: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
    );
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            CommonTopBar(
              title: 'Reports',
              subtitle: 'Track your website performance',
              action: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.calendar_today_outlined, size: 14),
                      SizedBox(width: 6),
                      Text('Last 30 Days'),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildStatCards(),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Text('vs previous 7 days', style: TextStyle(fontSize: 11.5, color: AppColors.textLight)),
                    ),
                    const SizedBox(height: 14),
                    _buildLineChartCard(),
                    const SizedBox(height: 14),
                    _buildSourcePageRow(),
                    const SizedBox(height: 14),
                    _buildCountryDeviceRow(),
                    const SizedBox(height: 14),
                    _buildInfoBanner(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CommonBottomNav(currentIndex: 0),
    );
  }

  Widget _buildStatCards() {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _stats.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (_, i) => _StatCard(data: _stats[i]),
      ),
    );
  }

  Widget _buildLineChartCard() {
    return _SectionCard(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Visitors Over Time',
            style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: AppColors.textDark),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: CustomPaint(
              size: const Size(double.infinity, 200),
              painter: _LineChartPainter(data: _chartData),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourcePageRow() {
    return Row(
      children: [
        Expanded(
          child: _SectionCard(
            padding: const EdgeInsets.all(14),
            child: _BarListPanel(
              title: 'Source',
              viewAllLabel: 'View all sources',
              rows: const [
                BarRowData(label: 'Direct', fraction: 1.0, displayValue: '119', barColor: AppColors.barBlue),
                BarRowData(label: 'google.com', fraction: 0.21, displayValue: '25', barColor: AppColors.barBlue),
                BarRowData(label: 'facebook.com', fraction: 0.01, displayValue: '1', barColor: AppColors.barBlue),
                BarRowData(label: 'bing.com', fraction: 0.01, displayValue: '1', barColor: AppColors.barBlue),
                BarRowData(label: 'instagram.com', fraction: 0.01, displayValue: '1', barColor: AppColors.barBlue),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SectionCard(
            padding: const EdgeInsets.all(14),
            child: _BarListPanel(
              title: 'Page',
              viewAllLabel: 'View all pages',
              rows: const [BarRowData(label: '/', fraction: 1.0, displayValue: '142', barColor: AppColors.barPurple)],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCountryDeviceRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _SectionCard(
            padding: const EdgeInsets.all(14),
            child: _BarListPanel(
              title: 'Country',
              viewAllLabel: 'View all countries',
              rows: const [
                BarRowData(
                  label: 'India',
                  fraction: 1.0,
                  displayValue: '79',
                  barColor: AppColors.barPurple,
                  flagCode: 'IN',
                ),
                BarRowData(
                  label: 'United States',
                  fraction: 0.23,
                  displayValue: '18',
                  barColor: AppColors.barPurple,
                  flagCode: 'US',
                ),
                BarRowData(
                  label: 'Thailand',
                  fraction: 0.01,
                  displayValue: '1',
                  barColor: AppColors.barPurple,
                  flagCode: 'TH',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SectionCard(
            padding: const EdgeInsets.all(14),
            child: _BarListPanel(
              title: 'Device',
              viewAllLabel: 'View all devices',
              rows: const [
                BarRowData(label: 'Mobile', fraction: 0.611, displayValue: '61.1%', barColor: AppColors.barBlue),
                BarRowData(label: 'Desktop', fraction: 0.389, displayValue: '38.9%', barColor: AppColors.barBlue),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(color: AppColors.infoBannerBg, borderRadius: BorderRadius.circular(16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.info_outline_rounded, color: AppColors.infoBannerIcon, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Understand Your Audience',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark),
                ),
                const SizedBox(height: 5),
                Text(
                  'Track how visitors find and interact with your restaurant website.',
                  style: TextStyle(fontSize: 12.5, color: AppColors.textMedium, height: 1.45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final StatCardData data;
  const _StatCard({required this.data});
  @override
  Widget build(BuildContext context) {
    final isPositive = data.changePercent >= 0;
    final isGood = data.positiveIsGood ? isPositive : !isPositive;
    final color = isGood ? AppColors.positiveGreen : AppColors.negativeRed;
    final arrow = isPositive ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded;
    final pctStr = '${data.changePercent.abs().toStringAsFixed(1)}%';
    return Container(
      width: 108,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 6, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: data.iconBg, borderRadius: BorderRadius.circular(10)),
            child: Icon(data.icon, size: 18, color: data.iconFg),
          ),
          const SizedBox(height: 8),
          // Label
          Text(
            data.label,
            style: const TextStyle(fontSize: 10.5, color: AppColors.textLight),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            data.value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.textDark,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          // Change
          Row(
            children: [
              Icon(arrow, size: 11, color: color),
              const SizedBox(width: 2),
              Text(
                pctStr,
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BarListPanel extends StatelessWidget {
  final String title;
  final String viewAllLabel;
  final List<BarRowData> rows;
  const _BarListPanel({required this.title, required this.viewAllLabel, required this.rows});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textDark),
            ),
            Text('Visitors', style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
          ],
        ),
        const SizedBox(height: 10),
        ...rows.map(
          (r) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _BarRow(data: r),
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              Text(
                viewAllLabel,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.chartBlue),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right_rounded, size: 16, color: AppColors.chartBlue),
            ],
          ),
        ),
      ],
    );
  }
}

class _BarRow extends StatelessWidget {
  final BarRowData data;
  const _BarRow({required this.data});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (data.flagCode != null) ...[_FlagBadge(code: data.flagCode!), const SizedBox(width: 5)],
            Expanded(
              child: Text(
                data.label,
                style: const TextStyle(fontSize: 11.5, color: AppColors.textDark),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              data.displayValue,
              style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: AppColors.textDark),
            ),
          ],
        ),
        const SizedBox(height: 5),
        LayoutBuilder(
          builder: (_, c) {
            final fullW = c.maxWidth;
            final barW = max(4.0, fullW * data.fraction);
            return Stack(
              children: [
                Container(
                  height: 4,
                  width: fullW,
                  decoration: BoxDecoration(color: AppColors.barGrey, borderRadius: BorderRadius.circular(4)),
                ),
                Container(
                  height: 4,
                  width: barW,
                  decoration: BoxDecoration(color: data.barColor, borderRadius: BorderRadius.circular(4)),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _FlagBadge extends StatelessWidget {
  final String code;
  const _FlagBadge({required this.code});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(3)),
      child: Text(
        code,
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: AppColors.textMedium,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<double> data;
  static const double _maxY = 40;
  static const double _leftPad = 36;
  static const double _rightPad = 8;
  static const double _topPad = 8;
  static const double _botPad = 28;
  static const List<int> _labelIndices = [0, 2, 4, 6, 7];
  static const List<String> _xLabels = ['20 May', '22 May', '24 May', '26 May', '27 May'];
  static const List<double> _yGridLines = [0, 10, 20, 30, 40];
  const _LineChartPainter({required this.data});
  @override
  void paint(Canvas canvas, Size size) {
    final cW = size.width - _leftPad - _rightPad;
    final cH = size.height - _topPad - _botPad;
    final gridPaint = Paint()
      ..color = const Color(0xFFEEEEEE)
      ..strokeWidth = 0.8;
    final linePaint = Paint()
      ..color = AppColors.chartBlue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final dotFill = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.fill;
    final dotStroke = Paint()
      ..color = AppColors.chartBlue
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke;
    final n = data.length;
    final List<Offset> pts = List.generate(n, (i) {
      final x = _leftPad + (i / (n - 1)) * cW;
      final y = _topPad + cH * (1 - data[i] / _maxY);
      return Offset(x, y);
    });
    for (final yVal in _yGridLines) {
      final yPos = _topPad + cH * (1 - yVal / _maxY);
      canvas.drawLine(Offset(_leftPad, yPos), Offset(_leftPad + cW, yPos), gridPaint);
      _drawText(
        canvas,
        '${yVal.toInt()}',
        Offset(0, yPos - 7),
        fontSize: 10,
        color: const Color(0xFFBBBBBB),
        textAlign: TextAlign.right,
        width: _leftPad - 6,
      );
    }
    final fillPath = Path()..moveTo(_leftPad, _topPad + cH); // bottom-left
    for (final p in pts) {
      fillPath.lineTo(p.dx, p.dy);
    }
    fillPath
      ..lineTo(_leftPad + cW, _topPad + cH)
      ..close();
    final fillPaint = Paint()
      ..shader = ui.Gradient.linear(Offset(0, _topPad), Offset(0, _topPad + cH), [
        AppColors.chartBlue.withValues(alpha: 0.18),
        AppColors.chartBlue.withValues(alpha: 0.02),
      ])
      ..style = PaintingStyle.fill;
    canvas.drawPath(fillPath, fillPaint);
    final linePath = Path()..moveTo(pts[0].dx, pts[0].dy);
    for (int i = 1; i < pts.length; i++) {
      linePath.lineTo(pts[i].dx, pts[i].dy);
      canvas.drawPath(linePath, linePaint);
      for (final p in pts) {
        canvas.drawCircle(p, 4, dotFill);
        canvas.drawCircle(p, 4, dotStroke);
      }
      for (int i = 0; i < _labelIndices.length; i++) {
        final idx = _labelIndices[i];
        final xPos = _leftPad + (idx / (n - 1)) * cW;
        _drawText(
          canvas,
          _xLabels[i],
          Offset(xPos, _topPad + cH + 9),
          fontSize: 9.5,
          color: const Color(0xFFBBBBBB),
          centered: true,
        );
      }
    }
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset offset, {
    double fontSize = 11,
    Color color = const Color(0xFF999999),
    bool centered = false,
    TextAlign textAlign = TextAlign.left,
    double? width,
  }) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: fontSize, color: color, fontFamily: 'SF Pro Display'),
      ),
      textDirection: TextDirection.ltr,
      textAlign: textAlign,
    )..layout(maxWidth: width ?? 120);
    final dx = centered ? offset.dx - tp.width / 2 : offset.dx;
    tp.paint(canvas, Offset(dx, offset.dy));
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter old) => old.data != data;
}

class _SectionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const _SectionCard({required this.child, this.padding = const EdgeInsets.all(16)});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: child,
    );
  }
}
