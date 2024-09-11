import 'package:flutter/material.dart';
import 'package:redius_admin/core/utils/app_colors.dart';
import 'package:redius_admin/core/utils/app_constraints.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({
    super.key,
    required this.count,
    required this.title,
    required this.icon,
    this.onlineTotal = 0,
    this.expiredUsersCount = 0,
    this.activeUsers = 0,
    this.isReport = false,
  });

  final int count;
  final String title;
  final IconData icon;
  final int onlineTotal;
  final int expiredUsersCount;
  final int activeUsers;
  final bool isReport;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: AppColors.itemBackground,
      child: Padding(
        padding: EdgeInsets.all(context.width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon section with shadow
            CircleAvatar(
              radius: context.width * 0.08,
              backgroundColor: AppColors.buttonBackground,
              child: Icon(
                icon,
                color: AppColors.primaryText,
                size: context.width * 0.08,
              ),
            ),
            SizedBox(height: context.height * 0.02),

            // Count text with bold style
            Text(
              "$count",
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: context.height * 0.01),

            // Title with improved style
            Text(
              title,
              style: TextStyle(
                color: AppColors.placeholderText,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: context.height * 0.03),

            // Additional information section with better styling
            isReport
                ? Container()
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoItem(
                  context,
                  label: 'الاونلاين',
                  value: onlineTotal,
                  color: AppColors.primaryText,
                ),
                _buildInfoItem(
                  context,
                  label: 'الغير مفعلين',
                  value: expiredUsersCount,
                  color: AppColors.error,
                ),
                _buildInfoItem(
                  context,
                  label: 'الفعالين',
                  value: activeUsers,
                  color: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(
      BuildContext context, {
        required String label,
        required int value,
        required Color color,
      }) {
    return Column(
      children: [
        Text(
          "$value",
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: context.height * 0.005),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
