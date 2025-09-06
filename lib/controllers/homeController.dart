import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHomeController extends GetxController{
  var username = "Guest".obs;
  var gettingS ="Good Morning".obs;
  final hour = DateTime.now().hour;

  @override
  void onInit() {
    // TODO: implement onInit
    getName();
   gettingS.value=_calculateGreeting();
    super.onInit();
  }
  getName() async {
    var prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString("UserName") ?? "Guest";
  }
  @override
  void onReady() {
    ever(username, (_) => getName()); // reload if changed
    ever(username, (_) => _calculateGreeting()); // reload if changed
    super.onReady();
  }

  String _calculateGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return "Good Morning";
    } else if (hour >= 12 && hour < 17) {
      return "Good Afternoon";
    } else if (hour >= 17 && hour < 21) {
      return "Good Evening";
    } else {
      return "Good Night";
    }
  }

}