import 'package:finance_guard/core/constants/app_colors.dart';
import 'package:finance_guard/core/constants/text_styles.dart';
import 'package:finance_guard/core/widgets/plus_button.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/home/domain/entity/transaction_entity.dart';
import '../../features/home/pages/transaction_page.dart';
import '../../features/home/useCase/group_expenses_by_name.dart';


class ExpensesPieChartCard extends StatefulWidget {
  final List<TransactionEntity> expenses;

  const ExpensesPieChartCard({super.key, required this.expenses});

  @override
  State<ExpensesPieChartCard> createState() => _ExpensesPieChartCardState();
}

class _ExpensesPieChartCardState extends State<ExpensesPieChartCard> {
  final _groupUseCase = GroupExpensesByName();

  @override
  Widget build(BuildContext context) {
    final data = _groupUseCase.groupByName(widget.expenses);
    final total = data.fold<double>(0, (sum, item) => sum + item.amount);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 156.w,
                height: 156.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      PieChartData(
                        sectionsSpace: 0,
                        centerSpaceRadius: 65.r,
                        sections: data.map(
                              (e) => PieChartSectionData(
                            color: Color(e.categoryColor),
                            value: e.amount,
                            radius: 28.r,
                            showTitle: false,
                          ),
                        ).toList(),
                      ),
                      swapAnimationDuration: const Duration(milliseconds: 800),
                      swapAnimationCurve: Curves.easeInOut,
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Expenses",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          "\$${total.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final item in data)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 14.r,
                            backgroundColor: Color(item.categoryColor),
                            child: Icon(
                              IconData(
                                item.iconCodePoint,
                                fontFamily: item.iconFontFamily,
                              ),
                              size: 16.sp,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            item.name,
                            style: AppTextStyles.whiteExpenseLabel
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
          PlusButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const TransactionPage(),
              ),
            );
          },)
        ],
      ),
    );

  }
}