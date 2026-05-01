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

    return Scaffold(
      body: AnimatedContainer(
        duration: 520.ms,
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [collection.primary, collection.secondary, Colors.black],
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
                  height: 500,
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
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Vastrax',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                AnimatedSwitcher(
                  duration: 300.ms,
                  child: Text(
                    collection.mood.toUpperCase(),
                    key: ValueKey(collection.id),
                    style: TextStyle(
                      color: collection.accent,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
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
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Material(
          color: Colors.white.withValues(alpha: 0.12),
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: GestureDetector(
        onTap: () => context.push('/collection/${collection.id}'),
        child: Hero(
          tag: 'collection-${collection.id}',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
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
                        collection.primary.withValues(alpha: 0.42),
                        Colors.black.withValues(alpha: 0.86),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 22,
                  right: 22,
                  bottom: 22,
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          collection.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.w800,
                            height: 0.95,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          collection.subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.82),
                            fontSize: 14,
                            height: 1.45,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            Expanded(
                              child: _Pill(
                                label: '${collection.items.length} pieces',
                                color: collection.accent,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              height: 44,
                              width: 44,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
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
        borderRadius: BorderRadius.circular(16),
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
              height: 118,
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
          width: 210,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
          ),
          child: Row(
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: collection.accent,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(item.icon, color: collection.primary),
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
                        letterSpacing: 1,
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
