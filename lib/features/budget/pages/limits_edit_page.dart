import 'package:finance_guard/core/widgets/create_button.dart';
import 'package:finance_guard/features/budget/domain/repo/limits_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../servise_locator.dart';
import '../widgets/enter_limit.dart';



class LimitsEditPage extends StatefulWidget {
  const LimitsEditPage({super.key});

  @override
  State<LimitsEditPage> createState() => _LimitsEditPageState();
}

class _LimitsEditPageState extends State<LimitsEditPage> {

  final _limitRepo = sl<LimitsRepo>();
  String? limit;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              ArrowBackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 30.h),
              Text('Edit monthly limits', style: AppTextStyles.screenTitle),
              SizedBox(height: 30.h),


              EnterLimit(
                selectedAmount: (value) {
                  limit = value;
                },
              ),
              Spacer(),



              SizedBox(height: 100.h),
              CreateButton(
                  onPressed: () {
                    if(limit != null ){
                      _limitRepo.saveMonthlyLimit(double.parse(limit!));
                      Navigator.pop(context,true);
                    }
                  }

              ),
            ],
          ),
        ),
      ),
    );
  }
}



