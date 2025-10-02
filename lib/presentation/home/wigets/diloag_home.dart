import 'package:flutter/material.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';

void showActivityPopup(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: UColors.primary.withOpacity(0.3),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) {
      return const SizedBox.shrink();
    },
    transitionBuilder: (context, anim1, anim2, child) {
      final curvedValue =
      Curves.easeInOut.transform(anim1.value);
      return Transform.translate(
        offset: Offset(0, (1 - curvedValue) * 200),
        child: Opacity(
          opacity: anim1.value,
          child: const ActivityPopup(),
        ),
      );
    },
  );
}

class ActivityPopup extends StatelessWidget {
  const ActivityPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "All Activity List",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  buildMenuItem(Icons.people, "Add Visit"),
                  buildMenuItem(Icons.meeting_room, "Add Meeting"),
                  buildMenuItem(Icons.person_add, "Add Associate"),
                  buildMenuItem(Icons.list, "Visit List"),
                  buildMenuItem(Icons.view_list, "Meeting List"),
                  buildMenuItem(Icons.group, "My Associate"),
                  buildMenuItem(Icons.directions_car, "Add Vehicle"),
                  buildMenuItem(Icons.car_rental, "My Vehicle"),
                  buildMenuItem(Icons.search, "Search Vehicle"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(IconData icon, String title) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: UColors.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 6),
        Text(title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
