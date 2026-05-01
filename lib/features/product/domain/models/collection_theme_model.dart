import 'package:flutter/material.dart';

class CollectionItem {
  final String name;
  final String category;
  final String fit;
  final String price;
  final String image;
  final List<String> gallery;
  final IconData icon;

  const CollectionItem({
    required this.name,
    required this.category,
    required this.fit,
    required this.price,
    required this.image,
    this.gallery = const [],
    required this.icon,
  });
}

class CollectionThemeModel {
  final String id;
  final String title;
  final String subtitle;
  final String mood;
  final String image;
  final String signature;
  final List<Color> palette;
  final Color primary;
  final Color secondary;
  final Color accent;
  final List<CollectionItem> items;

  const CollectionThemeModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.mood,
    required this.image,
    required this.signature,
    required this.palette,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.items,
  });
}

const collectionThemes = [
  CollectionThemeModel(
    id: 'prithvi-dhaga',
    title: 'Prithvi & Dhaga',
    subtitle:
        'Earth weave craft across textile-map leather and forest-warm hardware.',
    mood: 'Earth Weave / First Drop',
    image: 'dummy_pictures/PRITHVI_AND_DHAGA/PRITHVI_AND_DHAGA_21.01.03.jpeg',
    signature: 'Rooted textile, antique gold, deep jungle green.',
    palette: [
      Color(0xFF10221A),
      Color(0xFF75512F),
      Color(0xFFD19A5D),
      Color(0xFF0A1320),
    ],
    primary: Color(0xFF10221A),
    secondary: Color(0xFF745135),
    accent: Color(0xFFD59A5C),
    items: [
      CollectionItem(
        name: 'Earth Weave Textile Map',
        category: 'Artifact',
        fit: 'Patchwork India map',
        price: 'Rs.2,999',
        image:
            'dummy_pictures/PRITHVI_AND_DHAGA/textile_map/PRITHVI_AND_DHAGA_textile_map_4.jpeg',
        icon: Icons.map_outlined,
      ),
      CollectionItem(
        name: 'Prithvi High-Top',
        category: 'Sneakers',
        fit: 'Woven panels, cream sole',
        price: 'Rs.5,499',
        image:
            'dummy_pictures/PRITHVI_AND_DHAGA/sneakers/PRITHVI_AND_DHAGA_sneakers_0.jpeg',
        gallery: [
          'dummy_pictures/PRITHVI_AND_DHAGA/sneakers/PRITHVI_AND_DHAGA_sneakers_1.jpeg',
        ],
        icon: Icons.directions_walk_rounded,
      ),
      CollectionItem(
        name: 'Earth Weave Tote',
        category: 'Tote',
        fit: 'Leather carry with peacock crest',
        price: 'Rs.3,299',
        image:
            'dummy_pictures/PRITHVI_AND_DHAGA/tote_bag/PRITHVI_AND_DHAGA_tote_bag_3.jpeg',
        icon: Icons.local_mall_outlined,
      ),
      CollectionItem(
        name: 'Prithvi Travel Case',
        category: 'Bag',
        fit: 'Structured premium unboxing piece',
        price: 'Rs.2,799',
        image:
            'dummy_pictures/PRITHVI_AND_DHAGA/bag/PRITHVI_AND_DHAGA_bag_2.jpeg',
        icon: Icons.inventory_2_outlined,
      ),
    ],
  ),
  CollectionThemeModel(
    id: 'rudra',
    title: 'Rudra',
    subtitle:
        'The fire drop: charred red, ember copper and ritual flame details.',
    mood: 'Fire / First Drop',
    image: 'dummy_pictures/RUDRA/RUDRA_21.01.04.jpeg',
    signature: 'Flame graphics, copper trims, red-black textile panels.',
    palette: [
      Color(0xFF2C130F),
      Color(0xFF8F2A1D),
      Color(0xFFE08A4A),
      Color(0xFF16222C),
    ],
    primary: Color(0xFF2C130F),
    secondary: Color(0xFF8F2A1D),
    accent: Color(0xFFE08A4A),
    items: [
      CollectionItem(
        name: 'Rudra Flame High-Top',
        category: 'Sneakers',
        fit: 'Flame panel upper',
        price: 'Rs.5,799',
        image: 'dummy_pictures/RUDRA/sneakers/RUDRA_sneakers_0.jpeg',
        gallery: ['dummy_pictures/RUDRA/sneakers/RUDRA_sneakers_1.jpeg'],
        icon: Icons.local_fire_department_rounded,
      ),
      CollectionItem(
        name: 'Rudra Textile Map',
        category: 'Artifact',
        fit: 'Woven India map',
        price: 'Rs.2,999',
        image: 'dummy_pictures/RUDRA/textile_map/RUDRA_textile_map_3.jpeg',
        icon: Icons.map_outlined,
      ),
      CollectionItem(
        name: 'Rudra Crest Tote',
        category: 'Tote',
        fit: 'Leather with ember crest',
        price: 'Rs.3,499',
        image: 'dummy_pictures/RUDRA/tote_bag/RUDRA_tote_bag_4.jpeg',
        gallery: ['dummy_pictures/RUDRA/tote_bag/RUDRA_tote_bag_6.jpeg'],
        icon: Icons.local_mall_outlined,
      ),
      CollectionItem(
        name: 'Rudra Amulet',
        category: 'Amulet',
        fit: 'Fire-mark talisman',
        price: 'Rs.899',
        image: 'dummy_pictures/RUDRA/amulet/RUDRA_amulet_5.jpeg',
        icon: Icons.auto_awesome_rounded,
      ),
    ],
  ),
  CollectionThemeModel(
    id: 'aatma',
    title: 'Aatma',
    subtitle:
        'Soul essentials in slate shadow, natural ecru and quiet ritual objects.',
    mood: 'Soul / Core',
    image: 'dummy_pictures/AATMA/AATMA_21.01.09.jpeg',
    signature: 'Charcoal fleece, refined leather, meditation-box detailing.',
    palette: [
      Color(0xFF101112),
      Color(0xFF34393C),
      Color(0xFF898D86),
      Color(0xFFE4D9C6),
    ],
    primary: Color(0xFF101112),
    secondary: Color(0xFF33393D),
    accent: Color(0xFFC5A27D),
    items: [
      CollectionItem(
        name: 'Aatma Essential Sneaker',
        category: 'Sneakers',
        fit: 'Black leather low profile',
        price: 'Rs.5,299',
        image: 'dummy_pictures/AATMA/sneakers/AATMA_sneakers_0.jpeg',
        gallery: ['dummy_pictures/AATMA/sneakers/AATMA_sneakers_5.jpeg'],
        icon: Icons.directions_walk_rounded,
      ),
      CollectionItem(
        name: 'Refined Leather Tote',
        category: 'Tote',
        fit: 'Minimal embossed soul mark',
        price: 'Rs.3,899',
        image: 'dummy_pictures/AATMA/tote_bag/AATMA_tote_bag_3.jpeg',
        gallery: ['dummy_pictures/AATMA/tote_bag/AATMA_tote_bag_7.jpeg'],
        icon: Icons.local_mall_outlined,
      ),
      CollectionItem(
        name: 'Aatma Meditation Box',
        category: 'Artifact',
        fit: 'Boxed ritual vessel set',
        price: 'Rs.2,499',
        image:
            'dummy_pictures/AATMA/meditation_box/AATMA_meditation_box_5.jpeg',
        icon: Icons.spa_outlined,
      ),
      CollectionItem(
        name: 'Shadow Cap Detail',
        category: 'Headwear',
        fit: 'Stone-washed stitched form',
        price: 'Rs.999',
        image: 'dummy_pictures/AATMA/hat/AATMA_hat_1.jpeg',
        gallery: [
          'dummy_pictures/AATMA/hat/AATMA_hat_2.jpeg',
          'dummy_pictures/AATMA/hat/AATMA_hat_3.jpeg',
        ],
        icon: Icons.style_outlined,
      ),
    ],
  ),
  CollectionThemeModel(
    id: 'shunya',
    title: 'Shunya',
    subtitle:
        'The void drop: frost white, graphite charcoal and burnished blue restraint.',
    mood: 'Void / First Drop',
    image: 'dummy_pictures/SHUNYA/SHUNYA_21.01.07.jpeg',
    signature: 'Frost packaging, zero-pulse sneakers, silent white crests.',
    palette: [
      Color(0xFF0E1420),
      Color(0xFF3E4A5B),
      Color(0xFFE8ECEF),
      Color(0xFF7E858D),
    ],
    primary: Color(0xFF0E1420),
    secondary: Color(0xFF3E4A5B),
    accent: Color(0xFFE8ECEF),
    items: [
      CollectionItem(
        name: 'Zero-Pulse High-Top',
        category: 'Sneakers',
        fit: 'Frosted white platform sole',
        price: 'Rs.5,699',
        image: 'dummy_pictures/SHUNYA/sneakers/SHUNYA_sneakers_0.jpeg',
        gallery: [
          'dummy_pictures/SHUNYA/sneakers/SHUNYA_sneakers_1.jpeg',
          'dummy_pictures/SHUNYA/sneakers/SHUNYA_sneakers_4.jpeg',
          'dummy_pictures/SHUNYA/sneakers/SHUNYA_sneakers_6.jpeg',
        ],
        icon: Icons.directions_walk_rounded,
      ),
      CollectionItem(
        name: 'Shunya Frost Case',
        category: 'Bag',
        fit: 'Premium boxed unboxing',
        price: 'Rs.2,699',
        image: 'dummy_pictures/SHUNYA/bag/SHUNYA_bag_2.jpeg',
        gallery: ['dummy_pictures/SHUNYA/bag/SHUNYA_bag_5.jpeg'],
        icon: Icons.inventory_2_outlined,
      ),
      CollectionItem(
        name: 'Shunya Tote',
        category: 'Tote',
        fit: 'Void motif carry-all',
        price: 'Rs.3,499',
        image: 'dummy_pictures/SHUNYA/tote_bag/SHUNYA_tote_bag_5.jpeg',
        icon: Icons.local_mall_outlined,
      ),
      CollectionItem(
        name: 'Void Ornament',
        category: 'Artifact',
        fit: 'Graphite charcoal detail',
        price: 'Rs.799',
        image: 'dummy_pictures/SHUNYA/hat/SHUNYA_hat_8.jpeg',
        gallery: [
          'dummy_pictures/SHUNYA/hat/SHUNYA_hat_1.jpeg',
          'dummy_pictures/SHUNYA/hat/SHUNYA_hat_4.jpeg',
        ],
        icon: Icons.blur_circular_rounded,
      ),
    ],
  ),
  CollectionThemeModel(
    id: 'antim',
    title: 'Antim',
    subtitle:
        'Final-drop artifacts with oxidized copper, ancient sneakers and blackened leather.',
    mood: 'Final / Archive',
    image: 'dummy_pictures/ANTIM/ANTIM_21.01.07 (1).jpeg',
    signature: 'Aged copper, charred paper, textile-map memory.',
    palette: [
      Color(0xFF121110),
      Color(0xFF43312B),
      Color(0xFFC27852),
      Color(0xFF22313A),
    ],
    primary: Color(0xFF121110),
    secondary: Color(0xFF43312B),
    accent: Color(0xFFC27852),
    items: [
      CollectionItem(
        name: 'Antim Ancient Sneaker',
        category: 'Sneakers',
        fit: 'Weathered textile high-top',
        price: 'Rs.5,999',
        image: 'dummy_pictures/ANTIM/sneakers/ANTIM_sneakers_0.jpeg',
        gallery: [
          'dummy_pictures/ANTIM/sneakers/ANTIM_sneakers_1.jpeg',
          'dummy_pictures/ANTIM/sneakers/ANTIM_sneakers_2.jpeg',
        ],
        icon: Icons.terrain_rounded,
      ),
      CollectionItem(
        name: 'Antim Chest',
        category: 'Bag',
        fit: 'Charred paper box set',
        price: 'Rs.2,899',
        image: 'dummy_pictures/ANTIM/bag/ANTIM_bag_4.jpeg',
        gallery: ['dummy_pictures/ANTIM/bag/ANTIM_bag_5.jpeg'],
        icon: Icons.inventory_2_outlined,
      ),
      CollectionItem(
        name: 'Antim Tote',
        category: 'Tote',
        fit: 'Oxidized copper motif',
        price: 'Rs.3,799',
        image: 'dummy_pictures/ANTIM/tote_bag/ANTIM_tote_bag_10.jpeg',
        icon: Icons.local_mall_outlined,
      ),
      CollectionItem(
        name: 'Antim Ornament Set',
        category: 'Artifact',
        fit: 'Aged textile detail',
        price: 'Rs.899',
        image: 'dummy_pictures/ANTIM/hat/ANTIM_hat_14.jpeg',
        gallery: [
          'dummy_pictures/ANTIM/hat/ANTIM_hat_15.jpeg',
          'dummy_pictures/ANTIM/hat/ANTIM_hat_7.jpeg',
        ],
        icon: Icons.auto_awesome_rounded,
      ),
    ],
  ),
];

CollectionThemeModel collectionById(String id) {
  return collectionThemes.firstWhere(
    (collection) => collection.id == id,
    orElse: () => collectionThemes.first,
  );
}
