import 'package:finance_guard/features/budget/pages/edit_goal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/text_styles.dart';
import '../data/entity/goal_entity.dart';
import 'edit_button.dart';

class GoalCard extends StatelessWidget {
  final double totalPercentage; // Saved / Target
  final GoalEntity goal;
  final double total;

  const GoalCard({
    super.key,
    required this.totalPercentage,
    required this.goal,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final clampedProgress = totalPercentage.clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        height: 120.h,
        padding: EdgeInsets.all(9.w),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      goal.title,
                      style: AppTextStyles.widgetLabel,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "\$${total.toStringAsFixed(0)} of \$${goal.targetAmount.toStringAsFixed(0)}",
                      style: AppTextStyles.whiteWidgetLabel.copyWith(fontSize: 16),
                    ),
                    SizedBox(height: 14.h),
                  ],
                ),
                SizedBox(
                  width: 90.w,
                  height: 40,
                  child: EditButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => EditGoal(id: goal.id)),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),

            // --- Corrected Progress Bar ---
            SizedBox(
              width: double.infinity,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: clampedProgress),
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeOutCubic,
                builder: (context, animatedValue, child) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Stack(
                      children: [
                        // Background track (remaining part)
                        Container(
                          height: 15.h,
                          color: AppColors.buttonColor.withOpacity(0.3),
                        ),
                        // Filled portion (achieved progress)
                        FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: animatedValue,
                          child: Container(
                            height: 15.h,
                            color: AppColors.buttonColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
