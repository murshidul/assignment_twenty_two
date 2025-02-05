import 'package:assignment_twenty_two/home_controller.dart';
import 'package:assignment_twenty_two/product_model.dart';
import 'package:assignment_twenty_two/product_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsviewByCategory extends StatelessWidget {
  String category = "";
  ProductsviewByCategory(this.category);

  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: Container(
        child: GetBuilder<HomeController>(
          builder: (_) {
            return homeController.isProductsByCategoryLoading
                ? ProductShimmer()
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    shrinkWrap: true,
                    itemCount: homeController.productsByCategory.length,
                    itemBuilder: (context, index) {
                      ProductModel product =
                          homeController.productsByCategory[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.network(
                                product.image!,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                product.title!,
                                style: TextStyle(
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Price: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        product.price.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 18.0,
                                      ),
                                      Text(
                                        product.rating!.rate.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
          },
        ),
      ),
    );
  }
}
