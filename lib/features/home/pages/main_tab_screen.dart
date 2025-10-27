import 'package:finance_guard/core/constants/app_colors.dart';

import 'package:finance_guard/features/home/bloc/transaction_bloc/transaction_cubit.dart';
import 'package:finance_guard/features/home/pages/transaction_page.dart';
import 'package:finance_guard/features/home/view/day_statistics.dart';
import 'package:finance_guard/features/home/view/month_statistics.dart';
import 'package:finance_guard/features/home/view/week_statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/text_styles.dart';
import '../../../core/widgets/add_button.dart';
import '../../../core/widgets/custom_tab_bar.dart';

import '../../../servise_locator.dart';
import '../../welcome & balance cubit/repo/balance_repo.dart';
import '../bloc/transaction_bloc/transaction_state.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  late double total;

  @override
  void initState() {
    super.initState();
    context.read<TransactionCubit>().getAllData();
     total = sl<BalanceRepo>().getTotal();
  }

  void _updateTotal() {
    setState(() {
      total = sl<BalanceRepo>().getTotal();
    });
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {

        if (state is TransactionStateSummary) {
          return DefaultTabController(
            length: 3,
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(17.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Main', style: AppTextStyles.screenTitle),
                            Row(
                              children: [
                                AddCircleButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const TransactionPage()),
                                    ).then((value) {
                                      _updateTotal();
                                    },);
                                  },
                                ),
                                SizedBox(width: 8.w),

                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 40.h),


                        Container(
                          height: 40.h,
                          width: MediaQuery.of(context).size.width * 0.75 ,
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8.r)),
                            color: AppColors.cardBackground,
                          ),
                          child: TabBar(
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerColor: Colors.transparent,
                            indicator: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.all(Radius.circular(8.r)),
                            ),
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.white,
                            tabs: const [
                              TabItem(title: 'Day'),
                              TabItem(title: 'Week'),
                              TabItem(title: 'Month'),
                            ],
                          ),
                        ),




                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        DayStatistics(total: total,),
                        WeekStatistics(total:  total,),
                        MonthStatistics(total:  total,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is TransactionStateLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Container();
      },
    );


  }
}

