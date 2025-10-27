import 'package:finance_guard/core/constants/text_styles.dart';
import 'package:finance_guard/features/categories/data/entity/icon_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';

class SelectingIcon extends StatelessWidget {
  final IconEntity? selectedIcon;
  final ValueChanged<IconEntity> onSelect;

  const SelectingIcon({
    super.key,
    required this.selectedIcon,
    required this.onSelect,
  });

  int colorToInt(Color color) {
    final int a = color.a.toInt();
    final int r = color.r.toInt();
    final int g = color.g.toInt();
    final int b = color.b.toInt();
    return (a << 24) | (r << 16) | (g << 8) | b;
  }

  @override
  Widget build(BuildContext context) {
    final List<IconEntity> iconEntities = [
      IconEntity.withColor(id: 'travel', icon: Icons.flight_takeoff, color: Colors.blue),
      IconEntity.withColor(id: 'health', icon: Icons.local_hospital, color: Colors.redAccent),
      IconEntity.withColor(id: 'gift', icon: Icons.card_giftcard, color: Colors.pink),
      IconEntity.withColor(id: 'pets', icon: Icons.pets, color: Colors.brown),
      IconEntity.withColor(id: 'education', icon: Icons.school, color: Colors.cyan),
      IconEntity.withColor(id: 'bills', icon: Icons.receipt_long, color: Colors.orangeAccent),
      IconEntity.withColor(id: 'savings', icon: Icons.savings, color: Colors.greenAccent),
      IconEntity.withColor(id: 'technology', icon: Icons.devices, color: Colors.blueGrey),
      IconEntity.withColor(id: 'fitness', icon: Icons.fitness_center, color: Colors.deepOrange),
      IconEntity.withColor(id: 'beauty', icon: Icons.brush, color: Colors.purpleAccent),
      IconEntity.withColor(id: 'communication', icon: Icons.phone_android, color: Colors.lightBlue),
      IconEntity.withColor(id: 'food', icon: Icons.restaurant, color: Colors.orange),
      IconEntity.withColor(id: 'drink', icon: Icons.local_drink, color: Colors.red),
      IconEntity.withColor(id: 'rent', icon: Icons.home_work_outlined, color: Colors.purple),
      IconEntity.withColor(id: 'car', icon: Icons.directions_car, color: Colors.indigo),
      IconEntity.withColor(id: 'shopping', icon: Icons.shopping_cart, color: Colors.teal),
      IconEntity.withColor(id: 'salary', icon: Icons.attach_money, color: Colors.green),
      IconEntity.withColor(id: 'entertainment', icon: Icons.movie, color: Colors.deepPurple),
      IconEntity.withColor(id: 'transport', icon: Icons.train, color: Colors.indigoAccent),
      IconEntity.withColor(id: 'insurance', icon: Icons.security, color: Colors.tealAccent),
      IconEntity.withColor(id: 'kids', icon: Icons.toys, color: Colors.yellow),
      IconEntity.withColor(id: 'music', icon: Icons.music_note, color: Colors.pinkAccent),
      IconEntity.withColor(id: 'groceries', icon: Icons.local_grocery_store, color: Colors.lime),
      IconEntity.withColor(id: 'party', icon: Icons.celebration, color: Colors.deepPurpleAccent),
      IconEntity.withColor(id: 'charity', icon: Icons.volunteer_activism, color: Colors.red),
      IconEntity.withColor(id: 'taxes', icon: Icons.account_balance, color: Colors.blueAccent),
      IconEntity.withColor(id: 'other', icon: Icons.more_horiz, color: Colors.grey),
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 18.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select Icon', style: AppTextStyles.widgetLabel),
          SizedBox(height: 8.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: iconEntities.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              childAspectRatio: 1.3,
            ),
            itemBuilder: (context, index) {
              final category = iconEntities[index];
              final isSelected = selectedIcon?.id == category.id;

              return GestureDetector(
                onTap: () => onSelect(category),
                child: Container(
                  width: 60.h,
                  height: 60.h,
                  decoration: BoxDecoration(
                    border: isSelected
                        ? Border.all(width: 4, color: AppColors.primary)
                        : null,
                    shape: BoxShape.circle,
                    color: Color(category.color),
                  ),
                  child: Center(
                    child: Icon(
                      IconData(
                        category.iconCodePoint,
                        fontFamily: category.iconFontFamily,
                      ),
                      size: 28.h,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
