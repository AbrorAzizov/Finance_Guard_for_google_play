import 'package:finance_guard/core/constants/app_colors.dart';
import 'package:finance_guard/features/budget/pages/budget_tab.dart';
import 'package:flutter/material.dart';

import '../../categories/presentation/pages/category_tab.dart';
import '../pages/main_tab_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;


  final _pages = [

    const MainTabScreen(),

    const CategoryTab(),

    const BudgetTab(),


  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        currentIndex: _currentIndex,
        backgroundColor: AppColors.cardBackground,
        selectedItemColor: Colors.lightBlueAccent,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Main",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: "Budgets",
          ),


        ],
      ),
    );
  }
}
