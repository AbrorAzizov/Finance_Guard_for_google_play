import 'package:finance_guard/core/dialog/loading_dialog.dart';
import 'package:finance_guard/core/widgets/add_button.dart';
import 'package:finance_guard/features/budget/bloc/goal/goal_cubit.dart';

import 'package:finance_guard/features/budget/pages/limits_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/text_styles.dart';
import '../../../servise_locator.dart';
import '../../home/bloc/transaction_bloc/transaction_cubit.dart';
import '../../home/bloc/transaction_bloc/transaction_state.dart';
import '../../welcome & balance cubit/repo/balance_repo.dart';
import '../bloc/goal/goals_state.dart';

import '../widgets/goal_card.dart';
import '../widgets/limit_widget.dart';
import 'add_goal_page.dart';

class BudgetTab extends StatefulWidget {
  const BudgetTab({super.key});

  @override
  State<BudgetTab> createState() => _BudgetTabState();
}

class _BudgetTabState extends State<BudgetTab> {

  @override
  void initState() {
    super.initState();
    sl<GoalsCubit>().loadGoals();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Budgets', style: AppTextStyles.screenTitle),

              ],
            ),
            SizedBox(height: 30.h),

            Text('Limits', style: AppTextStyles.statsTitle),
            SizedBox(height: 12.h),

            // ---- Limits Section ----
            BlocBuilder<GoalsCubit, GoalsState>(
              builder: (context, state) {
                if (state is GoalsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GoalsLoaded) {
                  if (state.goals.isEmpty) {
                    return const Center(child: Text("No goals yet"));
                  }
                  return BlocBuilder<TransactionCubit, TransactionState>(
                    builder: (context, tState) {
                      if (tState is TransactionStateSummary) {
                        final limits = state.limitsEntity;
                        final monthExpenses = tState.monthData.totalExpenses;
                        final weekExpenses = tState.weekData.totalExpenses;

                        final monthPercentage = limits.monthlyLimit > 0
                            ? (monthExpenses / limits.monthlyLimit)
                            .clamp(0.0, 1.0)
                            : 0.0;

                        final weekLimit = limits.monthlyLimit / 4;
                        final weekPercentage = weekLimit > 0
                            ? (weekExpenses / weekLimit).clamp(0.0, 1.0)
                            : 0.0;

                        return Row(
                          children: [
                            Expanded(
                              child: LimitCard(
                                title: "Monthly",
                                expense: monthExpenses,
                                limit: limits.monthlyLimit,
                                value: monthPercentage,
                                onEdit: () async {
                                  final updated = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LimitsEditPage(),
                                    ),
                                  );
                                  if (updated == true) {
                                    sl<GoalsCubit>().loadGoals();
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: LimitCard(
                                title: "Weekly",
                                expense: weekExpenses,
                                limit: weekLimit,
                                value: weekPercentage,
                                onEdit: () async {
                                  final updated = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LimitsEditPage(),
                                    ),
                                  );
                                  if (updated == true) {
                                    sl<GoalsCubit>().loadGoals();
                                  }
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Center(child: Loading());
                      }
                    },
                  );
                } else if (state is GoalsError) {
                  return Center(child: Text("Error: ${state.message}"));
                }
                return const SizedBox.shrink();
              },
            ),
            SizedBox(height: 20.h),

            // ---- Goals Section ----
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Goals', style: AppTextStyles.statsTitle),
                AddCircleButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AddGoalPage()),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 12.h),


            // ... BudgetTab (Goals Section) ...

            Expanded(
              child: BlocBuilder<GoalsCubit, GoalsState>(
                builder: (context, state) {
                  if (state is GoalsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GoalsLoaded) {
                    if (state.goals.isEmpty) {
                      return const Center(child: Text("No goals yet"));
                    }
                    return ListView.builder(
                      itemCount: state.goals.length,
                      itemBuilder: (context, index) {
                        final goal = state.goals[index];

                        // 1. Get the actual saved amount for THIS goal
                        // *** ⚠️ Replace 'goal.currentSavedAmount' with your real field name (e.g., goal.savedTotal) ⚠️ ***
                        final double currentProgress = sl<BalanceRepo>().getTotal();

                        // 2. Calculate the standard progress ratio (Progress / Target)
                        // This ratio is the INPUT for the GoalCard
                        final double progressRatio = goal.targetAmount > 0
                            ? (currentProgress / goal.targetAmount)
                            : 0.0;

                        final totalPercentage = progressRatio.clamp(0.0, 1.0);

                        return GoalCard(
                          totalPercentage: totalPercentage, // Now correctly (Saved / Target)
                          goal: goal,
                          total: currentProgress,           // Now correctly the saved amount
                        );
                      },
                    );
                  } else if (state is GoalsError) {
                    return Center(child: Text("Error: ${state.message}"));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
// ...
// ...
          ],
        ),
      ),
    );
  }
}
