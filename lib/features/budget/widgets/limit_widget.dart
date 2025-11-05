import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/text_styles.dart';
import 'edit_button.dart';

class LimitCard extends StatelessWidget {
  final String title;
  final double expense;
  final double limit;
  final double value;
  final VoidCallback onEdit;

  const LimitCard({
    super.key,
    required this.title,
    required this.expense,
    required this.limit,
    required this.value,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    // Fix progress when limit is 0 or invalid
    final double safeValue = value.isFinite ? value.clamp(0.0, 1.0) : 0.0;

    return Container(
      height: 185.h,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.widgetLabel),
          SizedBox(height: 8.h),

          Text(
            "\$${expense.toStringAsFixed(0)} Spent of \$${limit.toStringAsFixed(0)}",
            style: AppTextStyles.statsTitle.copyWith(fontSize: 14),
          ),
          SizedBox(height: 8.h),

          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: safeValue),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            builder: (context, animatedValue, child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(15.h / 2), // fully rounded ends
                child: LinearProgressIndicator(
                  backgroundColor: AppColors.buttonColor.withOpacity(0.3),
                  valueColor: AlwaysStoppedAnimation(AppColors.buttonColor),
                  minHeight: 15.h,
                  value: animatedValue,
                ),
              );
            },
          ),

          SizedBox(height: 8.h),

          SizedBox(
            width: double.infinity,
            child: EditButton(onPressed: onEdit),
          ),
        ],
      ),
    );
  }
}
