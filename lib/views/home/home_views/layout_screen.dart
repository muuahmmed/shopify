import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_cubit/home_cubit.dart';
import '../home_cubit/home_states.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    const primaryColor = Color(0xFF6C63FF);
    final cardColor = isDarkMode ? Colors.grey[850]! : Colors.white;

    return BlocBuilder<HomeShopCubit, HomeShopStates>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            // App Bar Sliver
            SliverAppBar(
              floating: true,
              snap: true,
              title: Text(
                'Shopify',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_none),
                  onPressed: () {},
                ),
              ],
            ),

            // Main Content
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Header with Categories
                  _buildCategoriesSection(primaryColor),
                  const SizedBox(height: 24),

                  // Featured Products
                  _buildSectionHeader('Featured Products', 'See All', () {}),
                  const SizedBox(height: 12),
                  _buildFeaturedProducts(cardColor, primaryColor),
                  const SizedBox(height: 24),

                  // Special Offers
                  _buildSectionHeader('Special Offers', 'View All', () {}),
                  const SizedBox(height: 12),
                  _buildSpecialOffers(cardColor),
                  const SizedBox(height: 24),

                  // Popular Categories
                  _buildSectionHeader('Popular Categories', '', null),
                  const SizedBox(height: 12),
                  _buildPopularCategories(),
                ]),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCategoriesSection(Color primaryColor) {
    final categories = ['All', 'Electronics', 'Fashion', 'Home', 'Beauty'];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) => ChoiceChip(
          label: Text(categories[index]),
          selected: index == 0,
          selectedColor: primaryColor.withOpacity(0.2),
          labelStyle: TextStyle(
            color: index == 0 ? primaryColor : Colors.grey[600],
            fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onSelected: (selected) {},
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String actionText, VoidCallback? onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (actionText.isNotEmpty)
          GestureDetector(
            onTap: onTap,
            child: Text(
              actionText,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFeaturedProducts(Color cardColor, Color primaryColor) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) => SizedBox(
          width: 160,
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      color: Colors.primaries[index % Colors.primaries.length]
                          .withOpacity(0.1),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        size: 48,
                        color: Colors.primaries[index % Colors.primaries.length],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product ${index + 1}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      const Text('\$99.99',
                          style: TextStyle(color: Colors.green)),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.favorite_border,
                              color: Colors.grey[600],
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add_shopping_cart,
                              color: primaryColor,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialOffers(Color cardColor) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.orange.withOpacity(0.2),
              ),
              child: const Icon(
                Icons.local_offer_outlined,
                size: 40,
                color: Colors.orange,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Summer Sale',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Get 30% off on all items',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: const Text('Shop Now'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularCategories() {
    final categories = [
      {'icon': Icons.phone_iphone, 'name': 'Phones'},
      {'icon': Icons.laptop, 'name': 'Laptops'},
      {'icon': Icons.watch, 'name': 'Watches'},
      {'icon': Icons.headset, 'name': 'Audio'},
      {'icon': Icons.tv, 'name': 'TVs'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) => Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              categories[index]['icon'] as IconData,
              size: 32,
              color: Colors.blue,
            ),
            const SizedBox(height: 8),
            Text(
              categories[index]['name'] as String,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}