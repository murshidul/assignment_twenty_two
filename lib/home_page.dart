import 'package:assignment_twenty_two/home_controller.dart';
import 'package:assignment_twenty_two/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get API Integration"),
      ),
      body: GetBuilder<HomeController>(
        builder: (_) {
          return homeController.isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: homeController.products.length,
                  itemBuilder: (context, index) {
                    ProductModel product = homeController.products[index];
                    return Card(
                      child: ListTile(
                        leading: Image.network(product.image!),
                        title: Text(
                          product.title!,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(product.description!),
                      ),
                    );
                  });
        },
      ),
    );
  }
}
