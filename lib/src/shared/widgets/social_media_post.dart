import 'package:flutter/material.dart';

/// Realistic Facebook-style post preview (static UI).
/// Uses Material theme colors (ColorScheme) instead of hard-coded colors.
class FacebookPostPreview extends StatelessWidget {
  final String name;
  final String timeLabel; // "1 min"
  final String text;

  /// Provide any ImageProvider:
  /// - AssetImage('assets/a.jpg')
  /// - NetworkImage('https://...')
  /// - MemoryImage(...)
  final ImageProvider leftImage;
  final ImageProvider rightImage;

  /// Optional: show verified badge
  final bool verified;

  const FacebookPostPreview({
    super.key,
    required this.name,
    required this.timeLabel,
    required this.text,
    required this.leftImage,
    required this.rightImage,
    this.verified = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    // “Facebook page background” equivalent using Material surfaces
    final pageBg = scheme.surfaceContainerLowest; // good for app backgrounds
    final cardBg = scheme.onPrimary;
    final border = scheme.outlineVariant;
    final textPrimary = scheme.onSurface;
    final textSecondary = scheme.onSurfaceVariant;
    final iconSecondary = scheme.onSurfaceVariant;

    return ColoredBox(
      color: pageBg,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350, maxHeight: 600),
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: border, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: .min,
              children: [
                _Header(name: name, timeLabel: timeLabel, verified: verified),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 10),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 13.5,
                      height: 1.25,
                      color: textPrimary,
                    ),
                  ),
                ),
                _TwoImagesRow(left: leftImage, right: rightImage),
                const SizedBox(height: 8),
                Divider(height: 1, thickness: 1, color: border),
                _ActionsRow(
                  dividerColor: border,
                  iconColor: iconSecondary,
                  textColor: textSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String name;
  final String timeLabel;
  final bool verified;

  const _Header({
    required this.name,
    required this.timeLabel,
    required this.verified,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final textPrimary = scheme.onSurface;
    final textSecondary = scheme.onSurfaceVariant;
    final avatarBg = scheme.surfaceContainerHighest;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 8, 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: avatarBg,
            child: Icon(Icons.person_rounded, size: 18, color: textSecondary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: textPrimary,
                        ),
                      ),
                    ),
                    if (verified) ...[
                      const SizedBox(width: 6),
                      Icon(Icons.verified, size: 16, color: scheme.primary),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      timeLabel,
                      style: TextStyle(fontSize: 11.5, color: textSecondary),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '•',
                      style: TextStyle(fontSize: 11.5, color: textSecondary),
                    ),
                    const SizedBox(width: 6),
                    Icon(Icons.public, size: 14, color: textSecondary),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Icon(Icons.more_horiz, size: 20, color: textSecondary),
          ),
        ],
      ),
    );
  }
}

class _TwoImagesRow extends StatelessWidget {
  final ImageProvider left;
  final ImageProvider right;

  const _TwoImagesRow({required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    // Screenshot-like gap
    const gap = 8.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(child: _ImageTile(image: left)),
          const SizedBox(width: gap),
          Expanded(child: _ImageTile(image: right)),
        ],
      ),
    );
  }
}

class _ImageTile extends StatelessWidget {
  final ImageProvider image;
  const _ImageTile({required this.image});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            image: DecorationImage(image: image, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

class _ActionsRow extends StatelessWidget {
  final Color dividerColor;
  final Color iconColor;
  final Color textColor;

  const _ActionsRow({
    required this.dividerColor,
    required this.iconColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        children: [
          _ActionButton(
            icon: Icons.thumb_up_alt_outlined,
            label: 'Like',
            iconColor: iconColor,
            textColor: textColor,
          ),
          _ActionButton(
            icon: Icons.mode_comment_outlined,
            label: 'Comment',
            iconColor: iconColor,
            textColor: textColor,
          ),
          _ActionButton(
            icon: Icons.reply_outlined,
            label: 'Share',
            iconColor: iconColor,
            textColor: textColor,
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color textColor;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: iconColor),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
