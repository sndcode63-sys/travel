import 'package:get/get.dart';

class VehiclerController extends GetxController{

  RxString searchQuery = "".obs;

  void updateSearch ( String query){
    searchQuery.value = query.toLowerCase();

  }

  void clearSearch (){
    searchQuery.value = "";
  }



}