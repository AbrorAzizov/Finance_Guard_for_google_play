


import 'package:finance_guard/features/budget/pages/edit_goal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/text_styles.dart';
import '../data/entity/goal_entity.dart';
import 'edit_button.dart';

class GoalCard extends StatelessWidget {
  final double totalPercentage;
  final GoalEntity goal;
  final double total;

  const GoalCard({
    super.key,
    required this.totalPercentage,
    required this.goal,
    required this.total,
  }) ;

  @override
  Widget build(BuildContext context) {
    return  Padding(
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
            // --- Заголовок ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      goal.title,
                      style: AppTextStyles.widgetLabel,
                    ),
                    SizedBox(height: 8.h),

                    // --- Текст с расходами ---
                    Text(
                      "\$${total.toStringAsFixed(0)}  of \$${goal.targetAmount.toStringAsFixed(0)}",
                      style: AppTextStyles.whiteWidgetLabel.copyWith(fontSize:16),
                    ),
                    SizedBox(height: 14.h),
                  ],
                ),
                SizedBox(
                  width: 90.w,
                  height: 40,
                  child: EditButton(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) =>  EditGoal(id: goal.id)),
                    );
                  },),
                ),
              ],
            ),

            SizedBox(height: 4.h),

            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: totalPercentage.clamp(0.0, 1.0)),
              duration: const Duration(milliseconds: 2000),
              curve: Curves.easeInOut,
              builder: (context, animatedValue, child) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10.r), // rounded ends
                  child: LinearProgressIndicator(
                    backgroundColor: AppColors.buttonColor.withOpacity(0.3), // keep semi-transparent background
                    valueColor: AlwaysStoppedAnimation(AppColors.buttonColor),
                    minHeight: 15.h,
                    value: animatedValue,
                  ),
                );
              },
            ),


            SizedBox(height: 8.h),

            // --- Кнопка Edit ---

          ],
        ),
      ),
    );
  }
}
