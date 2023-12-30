import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/cart/cart_page.dart';
import 'package:haptic_feedback/haptic_feedback.dart';

import '../../values.dart';
import '../product/product_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var items = fireworks;

    if (searchController.text.isNotEmpty) {
      items = items.where((item) {
        final name = item.name.toLowerCase();
        final description = item.description.toLowerCase();
        final searchLower = searchController.text.toLowerCase();

        return name.contains(searchLower) || description.contains(searchLower);
      }).toList();
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            stretch: true,
            expandedHeight: 160,
            actions: [
              IconButton(
                icon: Visibility(
                  visible: cart.length > 0,
                  child: Badge(
                    label: Text(
                      cart.length.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                    child: const Icon(Icons.shopping_cart),
                  ),
                  replacement: const Icon(Icons.shopping_cart),
                ),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartPage(),
                    ),
                  );

                  setState(() {});
                },
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
                child: SearchBar(
                  controller: searchController,
                  elevation: MaterialStatePropertyAll(1),
                  hintText: 'Search fireworks',
                  leading: const Icon(Icons.search),
                  trailing: [
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();
                        setState(() {});
                      },
                    ),
                  ],
                  onChanged: _onSearchChanged,
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'main-logo',
                child: Image.asset(
                  'assets/images/splash.png',
                  fit: BoxFit.cover,
                  opacity: AlwaysStoppedAnimation(0.1),
                ),
              ),
            ),
            title: Column(
              children: [
                Text(
                  'Cracker Burst',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Welcome to CrackerBurst Fireworks',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            centerTitle: true,
          ),
          SliverList.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final firework = items[index];
              final isLast = index == items.length - 1;
              final isFirst = index == 0;

              return Card(
                margin: EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: isFirst ? 20 : 12,
                  bottom: isLast ? 20 : 12,
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductPage(firework: firework),
                      ),
                    );

                    setState(() {});
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Hero(
                        tag: firework.id,
                        child: Image.asset(
                          firework.image,
                          fit: BoxFit.cover,
                          height: 220,
                        ),
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        title: Text(
                          firework.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          firework.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.shopping_bag),
                          color: cart.contains(firework)
                              ? Colors.green
                              : Colors.grey,
                          onPressed: () async {
                            if (cart.contains(firework)) {
                              cart.remove(firework);
                              setState(() {});

                              await Haptics.vibrate(HapticsType.light);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${firework.name} removed from cart',
                                  ),
                                ),
                              );

                              return;
                            }

                            cart.add(firework);
                            setState(() {});
                            await Haptics.vibrate(HapticsType.success);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${firework.name} added to cart',
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onSearchChanged(String value) {
    setState(() {});
  }
}
