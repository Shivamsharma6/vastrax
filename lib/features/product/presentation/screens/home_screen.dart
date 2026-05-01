import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../domain/models/collection_theme_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.86);
  int _activeIndex = 0;

  CollectionThemeModel get _activeCollection => collectionThemes[_activeIndex];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final collection = _activeCollection;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: AnimatedContainer(
        duration: 520.ms,
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              collection.primary,
              collection.secondary,
              const Color(0xFF070707),
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: _Header(collection: collection)),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: screenHeight.clamp(700, 920) * 0.62,
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: collectionThemes.length,
                    onPageChanged: (index) =>
                        setState(() => _activeIndex = index),
                    itemBuilder: (context, index) {
                      final page = collectionThemes[index];
                      return AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          var delta = 0.0;
                          if (_pageController.position.haveDimensions) {
                            delta =
                                (_pageController.page ??
                                    _activeIndex.toDouble()) -
                                index;
                          } else {
                            delta = (_activeIndex - index).toDouble();
                          }
                          final distance = delta
                              .abs()
                              .clamp(0.0, 1.0)
                              .toDouble();
                          final scale = lerpDouble(1, 0.92, distance)!;
                          final yOffset = lerpDouble(0, 34, distance)!;

                          return Transform.translate(
                            offset: Offset(0, yOffset),
                            child: Transform.scale(scale: scale, child: child),
                          );
                        },
                        child: _CollectionCard(collection: page),
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: _CollectionStrip(collection: collection),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.paddingOf(context).bottom + 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final CollectionThemeModel collection;

  const _Header({required this.collection});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'VASTRAX',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.8,
                    height: 0.95,
                  ),
                ),
                const SizedBox(height: 6),
                AnimatedSwitcher(
                  duration: 300.ms,
                  child: Text(
                    collection.mood.toUpperCase(),
                    key: ValueKey(collection.id),
                    style: TextStyle(
                      color: collection.accent,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _GlassIconButton(icon: Icons.search_rounded, onTap: () {}),
          const SizedBox(width: 10),
          _GlassIconButton(
            icon: Icons.shopping_bag_outlined,
            onTap: () => context.push('/cart'),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 360.ms).slideY(begin: -0.12, end: 0);
  }
}

class _GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _GlassIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Material(
          color: Colors.white.withValues(alpha: 0.11),
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

class _CollectionCard extends StatelessWidget {
  final CollectionThemeModel collection;

  const _CollectionCard({required this.collection});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      child: GestureDetector(
        onTap: () => context.push('/collection/${collection.id}'),
        child: Hero(
          tag: 'collection-${collection.id}',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(collection.image, fit: BoxFit.cover),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.04),
                        collection.primary.withValues(alpha: 0.34),
                        Colors.black.withValues(alpha: 0.9),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.12),
                      ),
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 20,
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _PaletteRow(collection: collection),
                        const SizedBox(height: 14),
                        Text(
                          collection.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.w900,
                            height: 0.92,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          collection.subtitle,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.78),
                            fontSize: 14,
                            height: 1.45,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          collection.signature,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: collection.accent,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.6,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            Expanded(
                              child: _Pill(
                                label: '${collection.items.length} artifacts',
                                color: collection.accent,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              height: 44,
                              width: 44,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                color: collection.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
              height: 18,
              width: 18,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.44)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.28),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  final Color color;

  const _Pill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        label.toUpperCase(),
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: ThemeData.estimateBrightnessForColor(color) == Brightness.dark
              ? Colors.white
              : Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}

class _CollectionStrip extends StatelessWidget {
  final CollectionThemeModel collection;

  const _CollectionStrip({required this.collection});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: 360.ms,
      switchInCurve: Curves.easeOutCubic,
      child: Padding(
        key: ValueKey(collection.id),
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Inside ${collection.title}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 150,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: collection.items.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final item = collection.items[index];
                  return _MiniItem(
                    collection: collection,
                    item: item,
                    index: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniItem extends StatelessWidget {
  final CollectionThemeModel collection;
  final CollectionItem item;
  final int index;

  const _MiniItem({
    required this.collection,
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 240,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.11),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  height: 112,
                  width: 88,
                  color: Colors.black.withValues(alpha: 0.2),
                  child: Image.asset(item.image, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.category,
                      style: TextStyle(
                        color: collection.accent,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.price,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.72),
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        .animate(delay: (index * 80).ms)
        .fadeIn(duration: 300.ms)
        .slideX(begin: 0.12, end: 0);
  }
}
