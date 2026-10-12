import 'package:flutter/material.dart';

/// Instagram-style post preview (static UI).
/// Uses Material theme colors (ColorScheme). No functionality.
///
/// This version matches your previous "two images" design:
/// - Square media container
/// - Two images side-by-side inside the square
class InstagramPostPreview extends StatelessWidget {
  final String username;
  final String caption;
  final String timeLabel; // e.g. "1 MIN AGO"
  final int likesCount;

  final ImageProvider avatarImage;
  final ImageProvider leftImage;
  final ImageProvider rightImage;

  final bool verified;

  const InstagramPostPreview({
    super.key,
    required this.username,
    required this.caption,
    required this.timeLabel,
    required this.likesCount,
    required this.avatarImage,
    required this.leftImage,
    required this.rightImage,
    this.verified = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final pageBg = scheme.surface;
    final cardBg = scheme.onPrimary;
    ;
    final border = scheme.outlineVariant;

    final textPrimary = scheme.onSurface;
    final textSecondary = scheme.onSurfaceVariant;

    return ColoredBox(
      color: pageBg,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350, maxHeight: 600),

          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: border),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(
                  username: username,
                  verified: verified,
                  avatarImage: avatarImage,
                ),

                // Media (Instagram = square)
                _SquareTwoImages(leftImage: leftImage, rightImage: rightImage),

                // Action icons row
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite_border_rounded,
                        color: textPrimary,
                        size: 24,
                      ),
                      const SizedBox(width: 14),
                      Icon(
                        Icons.chat_bubble_outline_rounded,
                        color: textPrimary,
                        size: 24,
                      ),
                      const SizedBox(width: 14),
                      Icon(Icons.send_rounded, color: textPrimary, size: 22),
                      const Spacer(),
                      Icon(
                        Icons.bookmark_border_rounded,
                        color: textPrimary,
                        size: 24,
                      ),
                    ],
                  ),
                ),

                // Likes
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
                  child: Text(
                    '${_compact(likesCount)} likes',
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                // Caption (username bold + text)
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 6, 10, 0),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: textPrimary,
                        fontSize: 13.5,
                        height: 1.25,
                      ),
                      children: [
                        TextSpan(
                          text: username,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const TextSpan(text: '  '),
                        TextSpan(text: caption),
                      ],
                    ),
                  ),
                ),

                // Time
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 12),
                  child: Text(
                    timeLabel.toUpperCase(),
                    style: TextStyle(
                      color: textSecondary,
                      fontSize: 11.5,
                      letterSpacing: 0.3,
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

  String _compact(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }
}

class _Header extends StatelessWidget {
  final String username;
  final bool verified;
  final ImageProvider avatarImage;

  const _Header({
    required this.username,
    required this.verified,
    required this.avatarImage,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textPrimary = scheme.onSurface;
    final textSecondary = scheme.onSurfaceVariant;
    final avatarRing =
        scheme.primary; // use theme primary as ring (nice preview)
    final border = scheme.outlineVariant;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        children: [
          // Avatar with "story" ring look (preview only)
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: avatarRing, width: 2),
            ),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: scheme.surfaceContainerHighest,
              backgroundImage: avatarImage,
            ),
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    username,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (verified) ...[
                  const SizedBox(width: 6),
                  Icon(Icons.verified, color: scheme.primary, size: 16),
                ],
              ],
            ),
          ),

          // more icon
          Icon(Icons.more_vert_rounded, color: textSecondary),

          // subtle bottom divider like IG spacing (optional)
          const SizedBox(width: 2),
          Container(
            width: 0,
            height: 0,
            decoration: BoxDecoration(border: Border.all(color: border)),
          ),
        ],
      ),
    );
  }
}

class _SquareTwoImages extends StatelessWidget {
  final ImageProvider leftImage;
  final ImageProvider rightImage;

  const _SquareTwoImages({required this.leftImage, required this.rightImage});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    const gap = 2.0;

    return AspectRatio(
      aspectRatio: 1, // Instagram media is square
      child: Container(
        color: scheme.surfaceContainerHighest,
        child: Row(
          children: [
            Expanded(child: _MediaTile(image: leftImage)),
            const SizedBox(width: gap),
            Expanded(child: _MediaTile(image: rightImage)),
          ],
        ),
      ),
    );
  }
}

class _MediaTile extends StatelessWidget {
  final ImageProvider image;
  const _MediaTile({required this.image});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(image: image, fit: BoxFit.cover),
      ),
      child: const SizedBox.expand(),
    );
  }
}
