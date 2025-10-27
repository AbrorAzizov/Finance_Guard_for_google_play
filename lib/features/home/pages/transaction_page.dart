
import 'package:finance_guard/core/constants/text_styles.dart';
import 'package:finance_guard/core/widgets/back_button.dart';
import 'package:finance_guard/features/home/bloc/transaction_bloc/transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_tab_bar.dart';
import '../bloc/transaction_bloc/transaction_cubit.dart';
import '../view/transaction/expense_tab.dart';
import '../view/transaction/income_tab.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ArrowBackButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(height: 20.h),
                        Text('Add Transaction', style: AppTextStyles.screenTitle),
                        SizedBox(height: 20.h),
                        Container(
                          height: 40.h,
                          width: 300.w,
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
                              TabItem(title: 'Expense'),
                              TabItem(title: 'Income'),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h),


                      ],
                    ),
                  ),
                ),
                BlocConsumer<TransactionCubit, TransactionState>(
                  listener: (context, state) {

                    if (state is TransactionStateError) {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Error'),
                          content: Text(state.message),
                        ),
                      );
                    }

                    if (state is TransactionStateCreated) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Transaction saved!')),
                      );
                      context.read<TransactionCubit>().getAllData();
                      Navigator.of(context).pop();

                    }
                  },
                  builder: (context, state) {
                    return Expanded(
                      child: TabBarView(
                        children: [
                          ExpenseTab(),
                          IncomeTab(),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      );

  }
}
