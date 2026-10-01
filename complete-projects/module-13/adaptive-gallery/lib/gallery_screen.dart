import 'package:flutter/material.dart';

/// The one screen. It shows the same content two ways:
///   - narrow (phone): a single-column list
///   - wide (tablet / landscape): a multi-column grid, columns chosen from width
/// and it never hardcodes a color — every color comes from the theme, so light
/// and dark both look right for free.
class GalleryScreen extends StatelessWidget {
  const GalleryScreen({
    super.key,
    required this.themeMode,
    required this.onCycleTheme,
  });

  final ThemeMode themeMode;
  final VoidCallback onCycleTheme;

  // The line between "phone" and "tablet-ish". 600 logical pixels is the common
  // Material breakpoint — below it, phones; above it, big phones landscape and tablets.
  static const double _breakpoint = 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adaptive Gallery'),
        actions: [
          IconButton(
            tooltip: 'Theme: ${_themeLabel(themeMode)}',
            onPressed: onCycleTheme,
            icon: Icon(_themeIcon(themeMode)),
          ),
        ],
      ),
      // LayoutBuilder hands us the CONSTRAINTS this widget must fit into —
      // maxWidth is the real space we have, which is what "responsive" reacts to.
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= _breakpoint;

          if (!isWide) {
            // Phone: a comfortable single-column list.
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: galleryItems.length,
              itemBuilder: (context, i) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GalleryCard(item: galleryItems[i], wide: false),
              ),
            );
          }

          // Wide: a grid. Pick the column count from the width so it fills the
          // space without stretching cards too far — one number, derived.
          final columns = (constraints.maxWidth / 260).floor().clamp(2, 4);
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemCount: galleryItems.length,
            itemBuilder: (context, i) =>
                GalleryCard(item: galleryItems[i], wide: true),
          );
        },
      ),
    );
  }

  static String _themeLabel(ThemeMode m) => switch (m) {
        ThemeMode.system => 'System',
        ThemeMode.light => 'Light',
        ThemeMode.dark => 'Dark',
      };

  static IconData _themeIcon(ThemeMode m) => switch (m) {
        ThemeMode.system => Icons.brightness_auto,
        ThemeMode.light => Icons.light_mode,
        ThemeMode.dark => Icons.dark_mode,
      };
}

/// One card. Two shapes — a wide row for the list, a tall tile for the grid —
/// but the colors are identical because they come from the theme, not literals.
class GalleryCard extends StatelessWidget {
  const GalleryCard({super.key, required this.item, required this.wide});

  final GalleryItem item;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    // Theme.of(context) is how you read the CURRENT theme — light or dark.
    // Read colors from here and dark mode is automatic.
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final icon = Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(item.icon, color: colors.onPrimaryContainer, size: 28),
    );

    final title = Text(item.title, style: textTheme.titleMedium);
    final subtitle = Text(
      item.subtitle,
      style: textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );

    return Card(
      // Card already uses theme surface colors — no color set here on purpose.
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: wide
            // Grid tile: stacked, icon on top.
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  icon,
                  const Spacer(),
                  title,
                  const SizedBox(height: 4),
                  subtitle,
                ],
              )
            // List row: icon beside the text.
            : Row(
                children: [
                  icon,
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [title, const SizedBox(height: 4), subtitle],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

/// A tiny content model — enough to have something real to lay out.
class GalleryItem {
  const GalleryItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;
}

const galleryItems = <GalleryItem>[
  GalleryItem(
    title: 'Sunrise Hike',
    subtitle: 'Six of us, one very cold summit, worth every step.',
    icon: Icons.landscape,
  ),
  GalleryItem(
    title: 'City Lights',
    subtitle: 'The skyline from the rooftop, long after midnight.',
    icon: Icons.location_city,
  ),
  GalleryItem(
    title: 'Old Bookshop',
    subtitle: 'Found a first edition wedged behind the cookbooks.',
    icon: Icons.menu_book,
  ),
  GalleryItem(
    title: 'Harbour Morning',
    subtitle: 'Boats, coffee, and absolutely nowhere to be.',
    icon: Icons.sailing,
  ),
  GalleryItem(
    title: 'Desert Road',
    subtitle: 'Two hundred kilometres of nothing but sky.',
    icon: Icons.directions_car,
  ),
  GalleryItem(
    title: 'Night Market',
    subtitle: 'Every stall a different smell, all of them good.',
    icon: Icons.storefront,
  ),
  GalleryItem(
    title: 'Studio Session',
    subtitle: 'Take forty-one. The one we kept.',
    icon: Icons.music_note,
  ),
  GalleryItem(
    title: 'First Snow',
    subtitle: 'The whole street went quiet at once.',
    icon: Icons.ac_unit,
  ),
];
