// Run this to seed sample products into Firestore
// Usage: dart scripts/seed_products.dart
// Requires firebase_cli to be configured

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  final firestore = FirebaseFirestore.instance;

  final products = [
    {
      'name': 'Classic Oxford Shirt',
      'description':
          'Premium cotton oxford shirt with a tailored fit. Perfect for both formal and casual occasions.',
      'price': 2499,
      'images': [
        'https://images.unsplash.com/photo-1596755094514-f87bd320f813?w=600',
      ],
      'sizes': ['S', 'M', 'L', 'XL', 'XXL'],
      'category': 'Shirts',
      'isNew': true,
      'isTrending': false,
    },
    {
      'name': 'Slim Fit Chinos',
      'description':
          'Stretch cotton chinos with a modern slim fit. Comfortable enough for all-day wear.',
      'price': 1999,
      'images': [
        'https://images.unsplash.com/photo-1473966968600-f35216e3e490?w=600',
      ],
      'sizes': ['28', '30', '32', '34', '36'],
      'category': 'Trousers',
      'isNew': false,
      'isTrending': true,
    },
    {
      'name': 'Graphic Tee — Abstract',
      'description':
          'Premium cotton tee with an exclusive abstract art print. Limited edition drop.',
      'price': 1299,
      'images': [
        'https://images.unsplash.com/photo-1521572163474-6869f574d398?w=600',
      ],
      'sizes': ['S', 'M', 'L', 'XL'],
      'category': 'T-Shirts',
      'isNew': true,
      'isTrending': true,
    },
    {
      'name': 'Denim Jacket — Vintage Wash',
      'description':
          'Classic denim jacket with a vintage wash finish. A wardrobe staple that never goes out of style.',
      'price': 3999,
      'images': [
        'https://images.unsplash.com/photo-1576871337622-965ec20cdbc3?w=600',
      ],
      'sizes': ['S', 'M', 'L', 'XL'],
      'category': 'Jackets',
      'isNew': false,
      'isTrending': false,
    },
    {
      'name': 'Essential Crewneck Hoodie',
      'description':
          'Heavyweight French terry hoodie with brushed fleece interior. The perfect layer for any season.',
      'price': 2999,
      'images': [
        'https://images.unsplash.com/photo-1556821840-3a632cf4b7ab?w=600',
      ],
      'sizes': ['S', 'M', 'L', 'XL', 'XXL'],
      'category': 'Hoodies',
      'isNew': true,
      'isTrending': false,
    },
    {
      'name': 'Relaxed Fit Joggers',
      'description':
          'Soft French terry joggers with an elasticated waist and tapered leg. Effortless style.',
      'price': 1799,
      'images': [
        'https://images.unsplash.com/photo-1552902865-baca2037a23c?w=600',
      ],
      'sizes': ['S', 'M', 'L', 'XL'],
      'category': 'Essentials',
      'isNew': false,
      'isTrending': true,
    },
  ];

  for (final product in products) {
    await firestore.collection('products').add(product);
    stdout.writeln('Seeded: ${product["name"]}');
  }

  stdout.writeln('\nDone! ${products.length} products seeded.');
}
