import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/buy/buy_page.dart';

import '../../values.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Visibility(
        visible: cart.length > 0,
        replacement: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Your cart is empty.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final item = cart[index];

                  return ListTile(
                    leading: Hero(
                      tag: item.id,
                      child: Image.asset(
                        item.image,
                        width: 70,
                        height: 70,
                      ),
                    ),
                    title: Text(item.name),
                    subtitle: Text('€ ${item.price}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          cart.remove(item);
                        });
                      },
                    ),
                  );
                },
              ),
              const Divider(
                endIndent: 15,
                indent: 15,
              ),
              ListTile(
                title: const Text('Total'),
                trailing: Text(
                  '€ ${cart.fold(0, (total, item) => total + int.parse(item.price))}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const Divider(
                endIndent: 15,
                indent: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: cart.length > 0
                      ? () {
                          cart.clear();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BuyPage(),
                            ),
                          );
                        }
                      : null,
                  child: const Text('Checkout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
