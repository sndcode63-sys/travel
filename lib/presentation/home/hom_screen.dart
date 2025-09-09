import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travell_booking_app/utlis/constents/img_constants.dart';

class HomScreen extends StatelessWidget {
  const HomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          color: Colors.blue.withOpacity(0.5),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 1,
              leading: Container(
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),
                child: Icon(Icons.menu),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Chart Group",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "test@gmail.com",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_rounded, color: Colors.white,size: 26,),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.white,size: 26,),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      body:
      Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.18,
            width: double.infinity,
            child: Image.asset(
              AppImages.banner, // apna banner yaha
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              padding: const EdgeInsets.all(16),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildItem(Icons.group, "Add Visit", Colors.purple),
                _buildItem(Icons.meeting_room, "Add Meeting", Colors.orange),
                _buildItem(Icons.library_books, "Library", Colors.teal),
                _buildItem(Icons.calendar_month, "Plot", Colors.pink),
              ],
            ),
          ),

        ],
      ),

    );
  }

  Widget _buildItem(IconData icon, String title, Color color) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}






