/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class AnimatedPieChart extends StatelessWidget {
  final double? pieRadius;
  final double? stokeWidth;
  final double? padding;
  final int? animatedSpeed;
  final List<PieChartData> segments;

  const AnimatedPieChart({
    super.key,
    this.pieRadius = 60.0,
    this.stokeWidth = 8.0,
    this.padding = 3.0,
    this.animatedSpeed = 800,
    required this.segments,
  });

  @override
  Widget build(BuildContext context) {
    // print('pieData: $pieData');

    return Obx(
      () {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Center(
            child: Stack(
              children: [
                AnimatedRotation(
                  duration: Duration(milliseconds: animatedSpeed!),
                  turns: _ctrl.sectorTurns.value,
                  child: PieChart(
                    data: segments,
                    radius: pieRadius!,
                    padding: padding!,
                    strokeWidth: stokeWidth!,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        amount(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () => _sctrl.orgReceipts(context),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        child: const Text('View Sales',
                            style: TextStyle(fontSize: 11)),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String amount() {
    return NumberFormat('#,##0.00', 'en_US')
        .format(_sctrl.watuTotalSalesInAmount);
  }
}

class WeekTile extends StatelessWidget {
  final Function() onClick;
  final double? circularColorSize;
  final DailySales dailySale;

  const WeekTile({
    super.key,
    required this.onClick,
    required this.dailySale,
    this.circularColorSize,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: onClick,
      child: Container(
        // height: 100,
        padding: const EdgeInsets.only(
          left: 12,
          top: 12,
          bottom: 16,
          right: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: colorScheme.primary.withAlpha(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      NumberFormat('#,##0.00', 'en_US')
                          .format(dailySale.salesAmount),
                      style: bodyBold(textTheme).copyWith(
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      dailySale.fullDayOfTheWeek,
                      style: bodyRegular(textTheme),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  NumberFormat('00').format(dailySale.salesCount),
                  style: bodyBold(textTheme).copyWith(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const Spacer(),
            CircleAvatar(
              radius: 15,
              backgroundColor: dailySale.color,
              child: Icon(
                Icons.arrow_outward,
                color: colorScheme.onPrimary,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _watuOrgTile(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      // height: 100,
      padding: const EdgeInsets.only(
        left: 12,
        top: 12,
        bottom: 16,
        right: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: colorScheme.primary.withAlpha(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    NumberFormat('#,##0.00', 'en_US')
                        .format(dailySale.salesAmount),
                    style: bodyBold(textTheme).copyWith(
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    dailySale.fullDayOfTheWeek,
                    style: bodyRegular(textTheme),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                NumberFormat('00').format(dailySale.salesCount),
                style: bodyBold(textTheme).copyWith(
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const Spacer(),
          CircleAvatar(
            radius: 15,
            backgroundColor: dailySale.color,
            child: Icon(
              Icons.arrow_outward,
              color: colorScheme.onPrimary,
            ),
          )
        ],
      ),
    );
  }
}

// our pie chart widget
class PieChart extends StatelessWidget {
  PieChart({
    required this.data,
    required this.radius,
    this.strokeWidth = 8,
    this.padding = 3,
    this.child,
    super.key,
  }) : // make sure sum of data is never ovr 100 percent
        assert(data.fold<double>(0, (sum, data) => sum + data.percent) <= 100);

  final List<PieChartData> data;

  // radius of chart
  final double radius;

  // width of stroke
  final double strokeWidth;

  final double padding;

  // optional child; can be used for text for example
  final Widget? child;

  @override
  Widget build(context) {
    return CustomPaint(
      painter: _Painter(strokeWidth, data, padding),
      size: Size.square(radius),
      child: SizedBox.square(
        // calc diameter
        dimension: radius * 2.5,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

// responsible for painting our chart
class _PainterData {
  _PainterData(this.paint, this.radians);

  final Paint paint;
  final double radians;
}

class _Painter extends CustomPainter {
  _Painter(double strokeWidth, List<PieChartData> data, double padding) {
    // convert chart data to painter data
    dataList = data
        .map((e) => _PainterData(
              Paint()
                ..color = e.color
                ..style = PaintingStyle.stroke
                ..strokeWidth = strokeWidth
                ..strokeCap = StrokeCap.round,
              // remove padding from stroke
              (e.percent - padding) * _percentInRadians,
            ))
        .toList();
    paddingInRadians = _percentInRadians * padding;
    startAngle = -1.570796 + paddingInRadians / 2;
  }

  static const _percentInRadians = 0.062831853071796;

  late final List<_PainterData> dataList;
  late final double paddingInRadians;
  late final double startAngle;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    // keep track of start angle for next stroke
    double currentAngle = startAngle;

    // draw each stroke
    for (final data in dataList) {
      final path = Path()..addArc(rect, currentAngle, data.radians);

      currentAngle += data.radians + paddingInRadians;

      canvas.drawPath(path, data.paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}


double percentageValue(double percentage, List<MdPieChart> pieChartList) {
    double total = 0;
    for (int i = 0; i < pieChartList.length; i++) {
      total += pieChartList[i].value;
    }

    double p = (percentage / total) * 100;
    return p;
  }

*/