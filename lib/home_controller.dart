import 'package:assignment_twenty_two/home_service.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  // HomeService homeService = HomeService();

  late HomeService homeService;

  @override
  void onInit() {
    homeService = HomeService();
    getCategories();
    super.onInit();
  }

  void getCategories() async {
    try {
      http.Response response = await homeService.getProducts();
      if (response.statusCode == 200) {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
