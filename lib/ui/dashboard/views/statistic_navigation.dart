import 'package:during/core/extensions/string_extension.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:during/ui/dashboard/controllers/statistic_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StatisticNavigation extends StatelessWidget {
  const StatisticNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<StatisticController>();

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: kToolbarHeight,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: const Border(bottom: BorderSide(color: Colors.black26)),
          ),
          child: GetBuilder<StatisticController>(
            builder: (controller) => Row(
              children: [
                IconButton(
                  onPressed: () => controller.changeMonthStatistic(false),
                  icon: const Icon(Icons.chevron_left),
                ),
                Expanded(
                  child: Text(
                    DateFormat("MMMM yyyy").format(controller.currentDate),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(
                  onPressed: () => controller.changeMonthStatistic(true),
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 8),
                _StatisticSection(
                  title: 'Overview',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _TransactionOverviewSection(
                        title: 'Income',
                        balance: controller.income,
                        color: Colors.green,
                      ),
                      _TransactionOverviewSection(
                        title: 'Expense',
                        balance: controller.expense,
                        color: Colors.red,
                      ),
                      _TransactionOverviewSection(
                        title: 'Total',
                        balance: controller.total,
                        color: Theme.of(context).textTheme.bodyMedium!.color!,
                      ),
                    ],
                  ),
                ),
                _StatisticSection(
                  title: 'Expense Structure',
                  child: TransactionPieStatistic(
                    transactions: controller.expenseTransactions,
                    totalTransaction: controller.expense,
                  ),
                ),
                _StatisticSection(
                  title: 'Income Structure',
                  child: TransactionPieStatistic(
                    transactions: controller.incomeTransactions,
                    totalTransaction: controller.income,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TransactionOverviewSection extends StatelessWidget {
  final String title;
  final RxInt balance;
  final Color color;

  const _TransactionOverviewSection({
    required this.title,
    required this.balance,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(title),
          Obx(
            () => Text(
              'Rp ${balance.value.toPriceFormat()}',
              style: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatisticSection extends StatelessWidget {
  final Widget child;
  final String title;

  const _StatisticSection({
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class TransactionPieStatistic extends StatefulWidget {
  final RxList<TransactionEntity> transactions;
  final RxInt totalTransaction;

  const TransactionPieStatistic({
    super.key,
    required this.transactions,
    required this.totalTransaction,
  });

  @override
  State<StatefulWidget> createState() => TransactionPieStatisticState();
}

class TransactionPieStatisticState extends State<TransactionPieStatistic> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(width: 32),
          Expanded(
            child: Obx(
              () => PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          const SizedBox(width: 32),
          Expanded(
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widget.transactions.isEmpty
                    ? [
                        const Indicator(
                          color: Colors.grey,
                          text: "-",
                          isTouched: false,
                        )
                      ]
                    : widget.transactions
                        .map(
                          (element) => Indicator(
                            color: Color(
                                int.parse('0xff${element.categoryColor}')),
                            text: element.name ?? "-",
                            isTouched: widget.transactions.indexOf(element) ==
                                touchedIndex,
                          ),
                        )
                        .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    if (widget.transactions.isEmpty) {
      return [
        PieChartSectionData(
          color: Colors.grey,
          value: 100,
          radius: 50,
          title: '0',
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ];
    }
    return widget.transactions.map((element) {
      var index = widget.transactions.indexOf(element);
      final isTouched = index == touchedIndex;
      final radius = isTouched ? 60.0 : 50.0;

      var percent = element.nominal! / widget.totalTransaction.value * 100;

      return PieChartSectionData(
        color: Color(int.parse('0xff${element.categoryColor}')),
        value: percent,
        title: isTouched
            ? 'Rp ${element.nominal!.toPriceFormat()}'
            : '${percent.round()} %',
        radius: radius,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      );
    }).toList();
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isTouched,
    this.textColor,
  });

  final Color color;
  final String text;
  final bool isTouched;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          maxLines: 1,
          style: TextStyle(
            fontWeight: isTouched ? FontWeight.bold : FontWeight.w500,
            color: textColor,
            fontSize: isTouched ? 16 : 14,
          ),
        )
      ],
    );
  }
}
