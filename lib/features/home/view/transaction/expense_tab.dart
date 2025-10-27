import 'package:finance_guard/features/categories/data/entity/category_entity.dart';
import 'package:finance_guard/features/categories/presentation/bloc/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/widgets/comment_section.dart';
import '../../../../core/widgets/create_button.dart';
import '../../../../core/widgets/date_picker.dart';
import '../../../../core/widgets/enter_amount.dart';
import '../../../../core/widgets/selecting_category.dart';
import '../../../categories/presentation/bloc/category_state.dart';
import '../../bloc/transaction_bloc/transaction_cubit.dart';
import '../../domain/entity/initial_transaction.dart';

class ExpenseTab extends StatefulWidget {
  const ExpenseTab({super.key});

  @override
  State<ExpenseTab> createState() => _ExpenseTabState();
}

class _ExpenseTabState extends State<ExpenseTab> {
  DateTime selectedTime = DateTime.now();
  double moneyAmount = 0;
  String? comment;
  final _uuid = const Uuid(); // make const for efficiency
  CategoryEntity? selectedCategory;

  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().loadCategories();
  }

  Future<void> _createTransaction() async {
    if (moneyAmount == 0 || selectedCategory == null) return;

    final transaction = InitialTransactionEntity(
      id: _uuid.v4(),
      comment: comment,
      categoryId: selectedCategory!.id,
      amount: moneyAmount,
      date: selectedTime,
      type: 'expense',
    );

    context.read<TransactionCubit>().createTransaction(transaction, selectedCategory!);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is! CategoryLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final categories = state.categories;

          return Stack(
            children: [
              // scrollable form
              SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 100), // leave space for button
                child: Column(
                  children: [
                    CurrencyInput(
                      selectedAmount: (value) {
                        final cleaned = value.replaceAll(RegExp(r'[^0-9.]'), '');
                        setState(() {
                          moneyAmount = double.tryParse(cleaned) ?? 0;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    SelectingCategory(
                      selectedCategory: selectedCategory,
                      onSelect: (category) {
                        setState(() {
                          debugPrint('Выбрана категория: ${category.name}');
                          selectedCategory = category;
                        });
                      },
                      categories: categories,
                    ),
                    SizedBox(height: 20.h),
                    DatePicker(
                      onDateSelected: (value) {
                        setState(() {
                          selectedTime = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    CommentInput(
                      onCommentChanged: (text) {
                        setState(() {
                          comment = text;
                        });
                      },
                    ),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),

              // fixed button at bottom
              Positioned(
                left: 0,
                right: 0,
                bottom: 10,
                child: SafeArea(
                  top: false,
                  child: CreateButton(
                    onPressed: _createTransaction,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
