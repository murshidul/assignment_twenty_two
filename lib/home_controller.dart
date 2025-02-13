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

  bool isProductPostLoading = false;

  bool isProductUpdateLoading = false;

  bool isProductDeleteLoading = false;

  @override
  void onInit() {
    homeService = HomeService();
    getCategories();
    getProducts();
    super.onInit();
  }

  void postProduct(Map<String, dynamic> product) async {
    try {
      isProductPostLoading = true;
      update();
      http.Response response = await homeService.postProduct(product);
      if (response.statusCode == 200) {
        print(response.body);
        isProductPostLoading = false;
        update();
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  void updateProduct(Map<String, dynamic> product, String Id) async {
    try {
      isProductUpdateLoading = true;
      update();
      http.Response response = await homeService.updateProduct(product, Id);
      if (response.statusCode == 200) {
        print(response.body);
        isProductUpdateLoading = false;
        update();
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  void deleteProduct(String Id) async {
    try {
      isProductDeleteLoading = true;
      update();
      http.Response response = await homeService.deleteProduct(Id);
      if (response.statusCode == 200) {
        print(response.body);
        isProductDeleteLoading = false;
        update();
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
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
