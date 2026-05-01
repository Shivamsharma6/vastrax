import 'package:flutter/material.dart';

class CollectionItem {
  final String name;
  final String category;
  final String fit;
  final String price;
  final IconData icon;

  const CollectionItem({
    required this.name,
    required this.category,
    required this.fit,
    required this.price,
    required this.icon,
  });
}

class CollectionThemeModel {
  final String id;
  final String title;
  final String subtitle;
  final String mood;
  final String image;
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
    subtitle: 'The Earth Weave drop, rooted in craft, cloth and terrain.',
    mood: 'Earth Weave / First Drop',
    image: 'dummy_pictures/WhatsApp Image 2026-05-01 at 21.01.03.jpeg',
    primary: Color(0xFF18251D),
    secondary: Color(0xFF8A603C),
    accent: Color(0xFFD7A36A),
    items: [
      CollectionItem(
        name: 'Earth Weave Vest',
        category: 'Outerwear',
        fit: 'Layered utility vest',
        price: 'Rs.4,299',
        icon: Icons.inventory_2_outlined,
      ),
      CollectionItem(
        name: 'Prithvi High-Top',
        category: 'Sneakers',
        fit: 'Textile panel upper',
        price: 'Rs.5,499',
        icon: Icons.directions_walk_rounded,
      ),
      CollectionItem(
        name: 'Earth Weave Tote',
        category: 'Bags',
        fit: 'Embroidered leather carry',
        price: 'Rs.3,299',
        icon: Icons.local_mall_outlined,
      ),
    ],
  ),
  CollectionThemeModel(
    id: 'rudra',
    title: 'Rudra',
    subtitle: 'The Fire drop in ember reds, denim blues and flame motifs.',
    mood: 'Fire / First Drop',
    image: 'dummy_pictures/WhatsApp Image 2026-05-01 at 21.01.04.jpeg',
    primary: Color(0xFF2B1511),
    secondary: Color(0xFF8E2F22),
    accent: Color(0xFFE18C4F),
    items: [
      CollectionItem(
        name: 'Rudra Hood',
        category: 'Hoodie',
        fit: 'Fire crest back print',
        price: 'Rs.3,999',
        icon: Icons.checkroom_outlined,
      ),
      CollectionItem(
        name: 'Rudra Flame High-Top',
        category: 'Sneakers',
        fit: 'Flame textile panels',
        price: 'Rs.5,799',
        icon: Icons.local_fire_department_rounded,
      ),
      CollectionItem(
        name: 'Rudra Denim Jacket',
        category: 'Jacket',
        fit: 'Back crest embroidery',
        price: 'Rs.4,899',
        icon: Icons.style_outlined,
      ),
    ],
  ),
  CollectionThemeModel(
    id: 'aatma-core',
    title: 'Aatma',
    subtitle: 'The Soul collection in black, bone, slate and void blue.',
    mood: 'Soul / Essentials',
    image: 'dummy_pictures/WhatsApp Image 2026-05-01 at 21.01.05.jpeg',
    primary: Color(0xFF0D0D0F),
    secondary: Color(0xFF30363B),
    accent: Color(0xFFD8D1BF),
    items: [
      CollectionItem(
        name: 'Prana Hoodie',
        category: 'Hoodie',
        fit: 'Heavy charcoal fleece',
        price: 'Rs.3,699',
        icon: Icons.checkroom_outlined,
      ),
      CollectionItem(
        name: 'Kosha Tee',
        category: 'Tee',
        fit: 'Heavy jersey',
        price: 'Rs.1,999',
        icon: Icons.directions_walk_rounded,
      ),
      CollectionItem(
        name: 'Refined Denim',
        category: 'Denim',
        fit: 'Mantra waistband',
        price: 'Rs.3,199',
        icon: Icons.texture_rounded,
      ),
    ],
  ),
  CollectionThemeModel(
    id: 'aatma-summer',
    title: 'Aatma Summer',
    subtitle:
        'Summer mantras across light fleece, ecru jersey and sage layers.',
    mood: 'Soul / Summer',
    image: 'dummy_pictures/WhatsApp Image 2026-05-01 at 21.01.06.jpeg',
    primary: Color(0xFF1B211D),
    secondary: Color(0xFF7D8B70),
    accent: Color(0xFFE8DDC6),
    items: [
      CollectionItem(
        name: 'Prana Hoodie',
        category: 'Hoodie',
        fit: 'Light-fleece hoodie',
        price: 'Rs.3,499',
        icon: Icons.checkroom_outlined,
      ),
      CollectionItem(
        name: 'Kosha Tee',
        category: 'Tee',
        fit: 'Natural ecru heavy jersey',
        price: 'Rs.1,899',
        icon: Icons.dry_cleaning_outlined,
      ),
      CollectionItem(
        name: 'Refine Summer Denim',
        category: 'Denim',
        fit: 'Sun-bleached wash',
        price: 'Rs.3,099',
        icon: Icons.texture_rounded,
      ),
    ],
  ),
  CollectionThemeModel(
    id: 'shunya',
    title: 'Shunya',
    subtitle:
        'The Void drop in imperial silk, burnished blue and graphite charcoal.',
    mood: 'Void / First Drop',
    image: 'dummy_pictures/WhatsApp Image 2026-05-01 at 21.01.07.jpeg',
    primary: Color(0xFF0E1420),
    secondary: Color(0xFF435061),
    accent: Color(0xFFE5E9ED),
    items: [
      CollectionItem(
        name: 'Shunya Hoodie',
        category: 'Hoodie',
        fit: 'White void crest',
        price: 'Rs.3,899',
        icon: Icons.checkroom_outlined,
      ),
      CollectionItem(
        name: 'Zero-Pulse High-Top',
        category: 'Sneakers',
        fit: 'Frosted white sole',
        price: 'Rs.5,699',
        icon: Icons.directions_walk_rounded,
      ),
      CollectionItem(
        name: 'Shunya Tote',
        category: 'Bags',
        fit: 'Void motif carry-all',
        price: 'Rs.3,499',
        icon: Icons.local_mall_outlined,
      ),
    ],
  ),
  CollectionThemeModel(
    id: 'antim',
    title: 'Antim',
    subtitle:
        'The Final drop, built from textile-map craft and oxidized copper.',
    mood: 'Final / Archive',
    image: 'dummy_pictures/WhatsApp Image 2026-05-01 at 21.01.07 (1).jpeg',
    primary: Color(0xFF171615),
    secondary: Color(0xFF4A332A),
    accent: Color(0xFFC27955),
    items: [
      CollectionItem(
        name: 'Antim Hoodie',
        category: 'Hoodie',
        fit: 'Charcoal crest fleece',
        price: 'Rs.4,099',
        icon: Icons.checkroom_outlined,
      ),
      CollectionItem(
        name: 'Ancient High-Top',
        category: 'Sneakers',
        fit: 'Textile map panels',
        price: 'Rs.5,999',
        icon: Icons.terrain_rounded,
      ),
      CollectionItem(
        name: 'Antim Tote',
        category: 'Bags',
        fit: 'Oxidized copper motif',
        price: 'Rs.3,799',
        icon: Icons.local_mall_outlined,
      ),
    ],
  ),
  CollectionThemeModel(
    id: 'kaal',
    title: 'Kaal',
    subtitle: 'The First drop in void blue, copper trim and city haze.',
    mood: 'Time / First Drop',
    image: 'dummy_pictures/WhatsApp Image 2026-05-01 at 21.01.08.jpeg',
    primary: Color(0xFF102033),
    secondary: Color(0xFF263B59),
    accent: Color(0xFFC98958),
    items: [
      CollectionItem(
        name: 'Kaal Hood',
        category: 'Hoodie',
        fit: 'Oversized back crest',
        price: 'Rs.3,999',
        icon: Icons.checkroom_outlined,
      ),
      CollectionItem(
        name: 'Kaal High-Top',
        category: 'Sneakers',
        fit: 'Void blue panels',
        price: 'Rs.5,699',
        icon: Icons.directions_walk_rounded,
      ),
      CollectionItem(
        name: 'Kaal Denim Jacket',
        category: 'Jacket',
        fit: 'Back X applique',
        price: 'Rs.4,799',
        icon: Icons.style_outlined,
      ),
    ],
  ),
  CollectionThemeModel(
    id: 'aatma-void',
    title: 'Aatma Void',
    subtitle:
        'Dark soul essentials in midnight black, slate shadow and bone ivory.',
    mood: 'Soul / Void',
    image: 'dummy_pictures/WhatsApp Image 2026-05-01 at 21.01.09.jpeg',
    primary: Color(0xFF101112),
    secondary: Color(0xFF2D3337),
    accent: Color(0xFFB99274),
    items: [
      CollectionItem(
        name: 'Prana Hoodie',
        category: 'Hoodie',
        fit: 'Heavy charcoal fleece',
        price: 'Rs.3,699',
        icon: Icons.checkroom_outlined,
      ),
      CollectionItem(
        name: 'Kosha Tee',
        category: 'Tee',
        fit: 'Slate heavy jersey',
        price: 'Rs.1,999',
        icon: Icons.dry_cleaning_outlined,
      ),
      CollectionItem(
        name: 'Refined Leather Tote',
        category: 'Bags',
        fit: 'Minimal soul mark',
        price: 'Rs.3,899',
        icon: Icons.local_mall_outlined,
      ),
    ],
  ),
  CollectionThemeModel(
    id: 'aatma-shadow',
    title: 'Aatma Shadow',
    subtitle: 'Charcoal fleece, refined denim and shadow-toned essentials.',
    mood: 'Soul / Shadow',
    image: 'dummy_pictures/WhatsApp Image 2026-05-01 at 21.01.10.jpeg',
    primary: Color(0xFF101112),
    secondary: Color(0xFF2D3337),
    accent: Color(0xFF8790A0),
    items: [
      CollectionItem(
        name: 'Prana Hoodie',
        category: 'Hoodie',
        fit: 'Heavy charcoal fleece',
        price: 'Rs.3,699',
        icon: Icons.checkroom_outlined,
      ),
      CollectionItem(
        name: 'Kosha Tee',
        category: 'Tee',
        fit: 'Slate heavy jersey',
        price: 'Rs.1,999',
        icon: Icons.dry_cleaning_outlined,
      ),
      CollectionItem(
        name: 'Essential Slide',
        category: 'Slides',
        fit: 'Matte shadow finish',
        price: 'Rs.1,999',
        icon: Icons.directions_walk_rounded,
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
