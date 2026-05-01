# Vastrax — Premium Collection-Driven E-Commerce

A Flutter-based e-commerce app built around **collection-first storytelling**. Each collection is a themed drop with its own color palette, mood, and product lineup.

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter (Dart) |
| State Management | Provider |
| Routing | go_router |
| Backend | Firebase Firestore |
| Animations | flutter_animate |
| Images | cached_network_image |
| Payment | Razorpay (via razorpay_flutter) |

## Architecture

```
lib/
├── core/
│   ├── app.dart              # VastraxApp entry, MultiProvider setup
│   ├── routes/app_router.dart  # GoRouter config (5 named routes)
│   ├── theme/app_theme.dart    # Light theme, Material 3
│   └── widgets/product_card.dart
├── features/
│   ├── product/
│   │   ├── data/repositories/product_repository.dart  # Firestore CRUD
│   │   ├── domain/models/
│   │   │   ├── product_model.dart          # ProductModel (Firestore sync)
│   │   │   └── collection_theme_model.dart # CollectionThemeModel + 9 collections
│   │   └── presentation/
│   │       ├── screens/
│   │       │   ├── home_screen.dart           # Collection-first home with PageView
│   │       │   ├── collection_detail_screen.dart  # Hero → Rail → Panel → Grid
│   │       │   └── product_detail_screen.dart     # Product details + cart
│   │       └── providers/product_provider.dart
│   └── payment/
│       ├── domain/models/cart_item.dart
│       ├── presentation/providers/cart_provider.dart
│       └── presentation/screens/
│           ├── cart_screen.dart
│           └── checkout_screen.dart
├── shared/
└── main.dart
```

## Screens & Navigation

| Route | Screen | Description |
|-------|--------|-------------|
| `/home` | HomeScreen | Full-screen gradient collection cards with parallax PageView |
| `/collection/:id` | CollectionDetailScreen | Hero image, category rail, selected item panel, availability grid |
| `/product/:id` | ProductDetailScreen | Product images, size selector, add-to-cart |
| `/cart` | CartScreen | Item list, quantity controls, clear bag, subtotal |
| `/checkout` | CheckoutScreen | Delivery form, payment method (COD/UPI), place order |

## Collections (9 Themes)

Each collection has a unique color palette (`primary`, `secondary`, `accent`) and product lineup.

1. **Prithvi & Dhaga** — Earth Weave drop · Greens / Browns / Golds
2. **Rudra** — Fire drop · Ember reds, denim blues, flame motifs
3. **Aatma** — Soul collection · Black, bone, slate, void blue
4. **Aatma Summer** — Light fleece, ecru jersey, sage layers
5. **Shunya** — The Void · Imperial silk, burnished blue, graphite charcoal
6. **Antim** — Final/Archive · Textile-map craft, oxidized copper
7. **Kaal** — Time · Void blue, copper trim, city haze
8. **Aatma Void** — Dark soul essentials · Midnight black, slate shadow, bone ivory
9. **Aatma Shadow** — Charcoal fleece, refined denim, shadow tones

## Key UI Patterns

- **Collection-first home**: Horizontal PageView with scale + translate parallax (viewportFraction: 0.86)
- **Hero transitions**: Collection cards use `Hero` tags for smooth navigation to detail screens
- **Glassmorphism**: `BackdropFilter` blur on interactive elements (`_GlassIconButton`, `_BlurButton`)
- **Staggered animations**: List items animate with delay-based fade + slide effects
- **Bouncing physics**: All scroll views use `BouncingScrollPhysics`
- **Animated gradients**: Background colors shift dynamically based on active collection

## Getting Started

```bash
# Clone and install dependencies
cd vastrax
flutter pub get

# Run on connected device or emulator
flutter run

# Or run on Chrome for quick iteration
flutter run -d chrome
```

### Firebase Setup

The app uses Firebase Firestore for product data. Update `lib/main.dart` with your Firebase config:

```dart
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: 'YOUR_API_KEY',
    appId: 'YOUR_APP_ID',
    messagingSenderId: 'SENDER_ID',
    projectId: 'vastrax',
  ),
);
```

Seed products via CLI:

```bash
dart scripts/seed_products.dart
```

## Payment

- Supports **Cash on Delivery** and **UPI / Card / NetBanking** via Razorpay
- Cart state managed via `CartProvider` (ChangeNotifier)
- Checkout flow includes delivery address form + payment method selection

## Build & Analysis

```bash
# Static analysis (all clear — 0 errors, 0 warnings, only info-level lints)
flutter analyze --no-pub

# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release
```
