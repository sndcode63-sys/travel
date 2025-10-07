import 'package:flutter/material.dart';
import 'package:travell_booking_app/presentation/addmetting/visitList/widgets/custom_tab_Bar.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_listview_builder.dart';

class VehicleListScreen extends StatelessWidget {
  const VehicleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CustomListView(
            scrollDirection: Axis.vertical,
            itemCount: 20,
            itemBuilder: (context, index, item) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          color: Colors.grey,
                        ),
                        Text("Registration Number:"),
                        Text("Model Name:"),
                        Text("Brand Name:"),
                        Text("Color:"),
                        Container
                          (
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.green),
                          child: Text("Approved"),)
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.green),
                            child: Text("4 wheeler"))
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
