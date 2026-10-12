import 'package:flutter/material.dart';

/// X (Twitter) style post preview (static UI).
/// Uses Material theme colors (ColorScheme). No functionality.
///
/// This version mirrors your “two images” design:
/// - Text + 2 images side-by-side
/// - Action icons row (reply/repost/like/share) as visuals
class XPostPreview extends StatelessWidget {
  final String displayName;
  final String handle; // @samir
  final String timeLabel; // e.g. "1m"
  final String text;

  final ImageProvider avatarImage;
  final ImageProvider leftImage;
  final ImageProvider rightImage;

  /// Optional verified badge
  final bool verified;

  /// Optional numbers (still render-only)
  final int replies;
  final int reposts;
  final int likes;

  const XPostPreview({
    super.key,
    required this.displayName,
    required this.handle,
    required this.timeLabel,
    required this.text,
    required this.avatarImage,
    required this.leftImage,
    required this.rightImage,
    this.verified = false,
    this.replies = 0,
    this.reposts = 0,
    this.likes = 0,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final bg = scheme.onPrimary;
    final border = scheme.outlineVariant;
    final primary = scheme.onSurface;
    final secondary = scheme.onSurfaceVariant;

    return ColoredBox(
      color: scheme.surfaceContainerLowest,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350, maxHeight: 600),
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: border),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: scheme.surfaceContainerHighest,
                        backgroundImage: avatarImage,
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
                                    displayName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: primary,
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                if (verified) ...[
                                  const SizedBox(width: 6),
                                  Icon(
                                    Icons.verified,
                                    size: 16,
                                    color: scheme.primary,
                                  ),
                                ],
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    handle,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: secondary,
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text('·', style: TextStyle(color: secondary)),
                                const SizedBox(width: 6),
                                Text(
                                  timeLabel,
                                  style: TextStyle(
                                    color: secondary,
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              text,
                              style: TextStyle(
                                color: primary,
                                fontSize: 14.5,
                                height: 1.25,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(Icons.more_horiz, color: secondary),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Media (2 images side-by-side)
                  _TwoImages(leftImage: leftImage, rightImage: rightImage),

                  const SizedBox(height: 10),

                  Divider(height: 1, thickness: 1, color: border),

                  const SizedBox(height: 8),

                  // Actions row (render only)
                  _ActionsRow(
                    secondary: secondary,
                    replies: replies,
                    reposts: reposts,
                    likes: likes,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TwoImages extends StatelessWidget {
  final ImageProvider leftImage;
  final ImageProvider rightImage;

  const _TwoImages({required this.leftImage, required this.rightImage});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    const gap = 6.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AspectRatio(
        aspectRatio: 16 / 9, // X media often wide; inside we split 2-up
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

class _ActionsRow extends StatelessWidget {
  final Color secondary;
  final int replies;
  final int reposts;
  final int likes;

  const _ActionsRow({
    required this.secondary,
    required this.replies,
    required this.reposts,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Action(
          icon: Icons.chat_bubble_outline_rounded,
          value: replies,
          color: secondary,
        ),
        const SizedBox(width: 18),
        _Action(icon: Icons.repeat_rounded, value: reposts, color: secondary),
        const SizedBox(width: 18),
        _Action(
          icon: Icons.favorite_border_rounded,
          value: likes,
          color: secondary,
        ),
        const Spacer(),
        Icon(Icons.ios_share_rounded, color: secondary, size: 18),
      ],
    );
  }
}

class _Action extends StatelessWidget {
  final IconData icon;
  final int value;
  final Color color;

  const _Action({required this.icon, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    final hasValue = value > 0;

    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        if (hasValue) ...[
          const SizedBox(width: 6),
          Text(
            _compact(value),
            style: TextStyle(
              color: color,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }

  String _compact(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }
}
