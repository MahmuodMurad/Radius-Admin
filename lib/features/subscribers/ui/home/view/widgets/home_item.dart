import 'package:flutter/material.dart';
import 'package:redius_admin/core/utils/app_colors.dart';
import 'package:redius_admin/core/utils/app_constraints.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({super.key, required this.count, required this.title, required this.icon});
final int count ;
final String title;
final IconData icon ;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.width * 0.03),
        color: AppColors.itemBackground,
      ),
      child: Padding(
        padding:  EdgeInsets.all(context.width * 0.03),
        child: Column(
          children: [
            CircleAvatar(
              radius: context.width * 0.06,
              backgroundColor: AppColors.buttonBackground,
              child: Icon(
                icon,
                color: AppColors.primaryText,
                size: context.width * 0.06,
              ),
            ),
            SizedBox(height: context.height * 0.01),
             Text(
                "$count",
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 24,)),
            SizedBox(height: context.height * 0.01),
             Text(
                title,
                style: const TextStyle(
                  color: AppColors.placeholderText,
                  fontSize: 24,)),
          ],
        ),
      ),
    );
  }
}
