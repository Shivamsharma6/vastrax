import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../domain/models/collection_theme_model.dart';

class CollectionDetailScreen extends StatefulWidget {
  final String collectionId;

  const CollectionDetailScreen({super.key, required this.collectionId});

  @override
  State<CollectionDetailScreen> createState() => _CollectionDetailScreenState();
}

class _CollectionDetailScreenState extends State<CollectionDetailScreen> {
  late final CollectionThemeModel collection = collectionById(
    widget.collectionId,
  );
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final selectedItem = collection.items[_selectedIndex];
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: AnimatedContainer(
        duration: 420.ms,
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [collection.primary, collection.secondary, Colors.black],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                tag: 'collection-${collection.id}',
                child: Image.asset(collection.image, fit: BoxFit.cover),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.12),
                      collection.primary.withValues(alpha: 0.46),
                      Colors.black.withValues(alpha: 0.94),
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(child: _TopBar(collection: collection)),
                  SliverToBoxAdapter(
                    child: _HeroCopy(
                      collection: collection,
                      topSpace: (screenHeight * 0.25).clamp(150, 240),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _CategoryRail(
                      collection: collection,
                      selectedIndex: _selectedIndex,
                      onSelected: (index) =>
                          setState(() => _selectedIndex = index),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _SelectedItemPanel(
                      collection: collection,
                      item: selectedItem,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _AvailabilityGrid(collection: collection),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.paddingOf(context).bottom + 26,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final CollectionThemeModel collection;

  const _TopBar({required this.collection});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      child: Row(
        children: [
          _BlurButton(
            icon: Icons.arrow_back_rounded,
            onTap: () => context.pop(),
          ),
          const Spacer(),
          _BlurButton(icon: Icons.favorite_border_rounded, onTap: () {}),
          const SizedBox(width: 10),
          _BlurButton(
            icon: Icons.shopping_bag_outlined,
            onTap: () => context.push('/cart'),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 260.ms);
  }
}

class _BlurButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _BlurButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Material(
          color: Colors.black.withValues(alpha: 0.22),
          child: InkWell(
            onTap: onTap,
            child: SizedBox(
              height: 48,
              width: 48,
              child: Icon(icon, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  final CollectionThemeModel collection;
  final double topSpace;

  const _HeroCopy({required this.collection, required this.topSpace});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, topSpace, 20, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PaletteRow(collection: collection),
          const SizedBox(height: 14),
          Text(
            collection.mood.toUpperCase(),
            style: TextStyle(
              color: collection.accent,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.8,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            collection.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.w900,
              height: 0.92,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            collection.subtitle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.82),
              fontSize: 15,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            collection.signature,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: collection.accent,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              height: 1.35,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 420.ms).slideY(begin: 0.08, end: 0);
  }
}

class _PaletteRow extends StatelessWidget {
  final CollectionThemeModel collection;

  const _PaletteRow({required this.collection});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: collection.palette
          .map(
            (color) => Container(
              height: 20,
              width: 20,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.42)),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _CategoryRail extends StatelessWidget {
  final CollectionThemeModel collection;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _CategoryRail({
    required this.collection,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: collection.items.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = collection.items[index];
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: AnimatedContainer(
              duration: 260.ms,
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected
                    ? collection.accent
                    : Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
              ),
              child: Row(
                children: [
                  Icon(
                    item.icon,
                    color: isSelected ? collection.primary : Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    item.category,
                    style: TextStyle(
                      color: isSelected ? collection.primary : Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SelectedItemPanel extends StatelessWidget {
  final CollectionThemeModel collection;
  final CollectionItem item;

  const _SelectedItemPanel({required this.collection, required this.item});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: 320.ms,
      switchInCurve: Curves.easeOutCubic,
      child: Padding(
        key: ValueKey(item.name),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.13),
                border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: SizedBox(
                      height: 220,
                      width: double.infinity,
                      child: Image.asset(item.image, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: collection.accent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          item.icon,
                          color: collection.primary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.category.toUpperCase(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: collection.accent,
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              item.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                                fontWeight: FontWeight.w900,
                                height: 1.05,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        item.price,
                        style: TextStyle(
                          color: collection.accent,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item.fit,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.72),
                      fontSize: 13,
                      height: 1.45,
                    ),
                  ),
                  if (item.gallery.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 82,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: item.gallery.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 10),
                        itemBuilder: (context, index) => ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.asset(
                              item.gallery[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AvailabilityGrid extends StatelessWidget {
  final CollectionThemeModel collection;

  const _AvailabilityGrid({required this.collection});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Catalog',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 14),
          ...collection.items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          height: 66,
                          width: 66,
                          child: Image.asset(item.image, fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.category,
                              style: TextStyle(
                                color: collection.accent,
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        item.price,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                )
                .animate(delay: (index * 70).ms)
                .fadeIn(duration: 260.ms)
                .slideY(begin: 0.12, end: 0);
          }),
        ],
      ),
    );
  }
}
