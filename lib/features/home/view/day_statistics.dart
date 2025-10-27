import 'package:finance_guard/core/constants/text_styles.dart';
import 'package:finance_guard/core/dialog/loading_dialog.dart';
import 'package:finance_guard/core/widgets/all_button.dart';
import 'package:finance_guard/core/widgets/transaction_card.dart';
import 'package:finance_guard/features/history/pages/transaction_history.dart';
import 'package:finance_guard/features/home/bloc/transaction_bloc/transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/expense_chart.dart';
import '../../../core/widgets/wach_all_button.dart';
import '../bloc/transaction_bloc/transaction_cubit.dart';

class DayStatistics extends StatelessWidget {
  final double total;

  const DayStatistics({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state is TransactionStateSummary) {
          final dayData = state.dayData; // берём именно дневную статистику
          final transactions = state.transactions;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(17.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- My account card ---
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('My account', style: AppTextStyles.widgetLabel),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$${total.toStringAsFixed(2)}",
                              style: AppTextStyles.accountBalance,
                            ),
                            // пока процент фиксированный, но можно связать с dayData.incomePercentageChange
                            Text(
                              dayData.expensesPercentageChange >= 0
                                  ? "+${dayData.incomePercentageChange.toStringAsFixed(2)}%"
                                  : "${dayData.incomePercentageChange.toStringAsFixed(2)}%",
                              style: dayData.incomePercentageChange >= 0
                                  ? AppTextStyles.percentageChangePositive
                                  : AppTextStyles.percentageChangeNegative,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // --- Total amount section ---
                  Text('Total amount', style: AppTextStyles.statsTitle),
                  SizedBox(height: 12.h),

                  Row(
                    children: [
                      // --- Expenses card ---
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: AppColors.cardBackground,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Expenses", style: AppTextStyles.widgetLabel,),
                                  Text(
                                    dayData.expensesPercentageChange >= 0
                                        ? "+${dayData.expensesPercentageChange.toStringAsFixed(2)}%"
                                        : "${dayData.expensesPercentageChange.toStringAsFixed(2)}%",
                                    style: dayData.expensesPercentageChange >= 0
                                        ? AppTextStyles.percentageChangePositive
                                        : AppTextStyles.percentageChangeNegative,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                dayData.totalExpenses.toStringAsFixed(2),
                                style: AppTextStyles.accountBalance.copyWith(fontSize: 20.sp),
                              ),
                              SizedBox(height: 12.h),
                              SizedBox(
                                width: double.infinity,
                                child: WatchAllButton(onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const TransactionHistory()),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),

                      // --- Income card ---
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: AppColors.cardBackground,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Income", style: AppTextStyles.widgetLabel,),
                                  Text(
                                    dayData.incomePercentageChange >= 0
                                        ? "+${dayData.incomePercentageChange.toStringAsFixed(2)}%"
                                        : "${dayData.incomePercentageChange.toStringAsFixed(2)}%",
                                    style: dayData.incomePercentageChange >= 0
                                        ? AppTextStyles.percentageChangePositive
                                        : AppTextStyles.percentageChangeNegative,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                dayData.totalIncome.toStringAsFixed(2),
                                style: AppTextStyles.accountBalance.copyWith(fontSize: 20.sp),
                              ),
                              SizedBox(height: 12.h),
                              SizedBox(
                                width: double.infinity,
                                child: WatchAllButton(onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const TransactionHistory()),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // --- Total amount section ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Expenses', style: AppTextStyles.statsTitle),
                      AllButton(onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const TransactionHistory()),
                        );
                      },)
                    ],
                  ),
                  SizedBox(height: 12.h),
                  ExpensesPieChartCard(expenses: dayData.expenses),
                  SizedBox(height: 12.h),

                  // --- Total amount section ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Transaction History', style: AppTextStyles.statsTitle),
                      AllButton(onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const TransactionHistory()),
                        );
                      },)
                    ],
                  ),
                  SizedBox(height: 12.h),
                  TransactionCard(transactions: transactions)
                ],
              ),
            ),
          );
        } else if (state is TransactionStateLoading) {
          return const Center(child: Loading());
        } else if (state is TransactionStateError) {
          return Center(
            child: Text(state.message,
                style: const TextStyle(color: Colors.red)),
          );
        }
        return const SizedBox();// initial
      },
    );
  }
}
