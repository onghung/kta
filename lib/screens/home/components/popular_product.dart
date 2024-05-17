import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../components/product_card.dart';
import '../../../constants.dart';
import '../../products/products_screen.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Sản phẩm phổ biến",
            press: () {
              Navigator.pushNamed(context, ProductsScreen.routeName);
            },
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*2.2,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('/ltuddd/5I19DY1GyC83pHREVndb/Product')
                .snapshots(),
            builder: (ctx, streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final documents = streamSnapshot.data?.docs;
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Số cột
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.85,
                ),
                itemCount: documents?.length,
                itemBuilder: (ctx, index) {
                  // Extract information from the document
                  String productId = documents?[index]['id'];
                  String title = documents?[index]['title'];
                  String description = documents?[index]['description'];
                  int rating = documents?[index]['rating'];
                  int price = documents?[index]['price'];
                  bool isFavourite = documents?[index]['isFavourite'];
                  String imageUrl = documents?[index]['imageUrl'];
                  String collectionId = documents?[index].id ?? '';

                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: ProductCard(
                      width: 140, // Set your desired width
                      aspectRetio: 1.02,
                      productId: productId,
                      title: title,
                      description: description,
                      rating: rating,
                      price: price,
                      isFavourite: isFavourite,
                      imageUrl: imageUrl,
                      collectionId: collectionId,
                      onPress: () {
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
