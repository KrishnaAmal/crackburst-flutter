import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/cart/cart_page.dart';

import '../../values.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key, required this.firework});

  final Firework firework;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: firework.id,
                child: Image.asset(
                  firework.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Text(
                            firework.name,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "€ ${firework.price}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.shopping_cart),
                            color: cart.contains(firework)
                                ? Colors.green
                                : Colors.grey,
                            onPressed: () {
                              if (!cart.contains(firework)) {
                                cart.add(firework);
                              }

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CartPage(),
                                ),
                              );
                            },
                          )),
                      const SizedBox(height: 20),
                      Text(
                        firework.description,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
