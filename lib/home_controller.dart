import 'dart:convert';

import 'package:assignment_twenty_two/home_service.dart';
import 'package:assignment_twenty_two/product_model.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  // HomeService homeService = HomeService();

  late HomeService homeService;

  List<ProductModel> products = [];
  List<String> categories = [];
  List<ProductModel> productsByCategory = [];

  bool isCategoryLoading = false;
  bool isLoading = false;

  bool isProductsByCategoryLoading = false;

  @override
  void onInit() {
    homeService = HomeService();
    getCategories();
    getProducts();
    super.onInit();
  }

  void getProducts() async {
    try {
      isLoading = true;
      update();
      http.Response response = await homeService.getProducts();
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        for (int i = 0; i < data.length; i++) {
          products.add(ProductModel.fromJson(data[i]));
        }
        isLoading = false;
        update();
        print(products);
      }
    } catch (e) {
      print(e);
    }
  }

  void getProductsByCategory(String category) async {
    try {
      isProductsByCategoryLoading = true;
      update();
      http.Response response =
          await homeService.getProductsByCategory(category);

      var data = jsonDecode(response.body);

      for (int i = 0; i < data.length; i++) {
        productsByCategory.add(ProductModel.fromJson(data[i]));
      }
      isProductsByCategoryLoading = false;
      update();
    } catch (e) {
      isProductsByCategoryLoading = false;
      update();
    }
  }

  void getCategories() async {
    try {
      isCategoryLoading = true;
      update();
      http.Response response = await homeService.getCategories();
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        for (int i = 0; i < data.length; i++) {
          categories.add(data[i]);
          isCategoryLoading = false;
          update();
        }
      } else {
        print("Somethin Wroing");
        isCategoryLoading = false;
        update();
      }
    } catch (e) {
      isCategoryLoading = false;
      update();
      print(e);
    }
  }
}
