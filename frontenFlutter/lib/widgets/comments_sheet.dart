import 'package:flutter/material.dart';

class CommentData {
  final String author;
  final String avatarUrl;
  final String text;
  final String timeLabel;
  final bool isAuthor;
  final int likes;

  CommentData({
    required this.author,
    required this.avatarUrl,
    required this.text,
    required this.timeLabel,
    this.isAuthor = false,
    this.likes = 0,
  });
}

// ---- Ouvre la feuille de commentaires avec snap (50% et 100%). ----
Future<void> showCommentsSheet(
    BuildContext context, {
      required List<CommentData> comments,
    }) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black54,
    builder: (ctx) => _CommentsSheet(comments: comments),
  );
}

class _CommentsSheet extends StatefulWidget {
  final List<CommentData> comments;
  const _CommentsSheet({super.key, required this.comments});

  @override
  State<_CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<_CommentsSheet> {
  final DraggableScrollableController _dragCtrl =
  DraggableScrollableController();
  final TextEditingController _inputCtrl = TextEditingController();
  final FocusNode _inputFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _inputFocus.addListener(() {
      if (_inputFocus.hasFocus) {
        _expandToFull();
      }
    });
  }

  @override
  void dispose() {
    _dragCtrl.dispose();
    _inputCtrl.dispose();
    _inputFocus.dispose();
    super.dispose();
  }

  Future<void> _expandToFull() async {
    if (_dragCtrl.size < 1.0) {
      await _dragCtrl.animateTo(
        1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  void _replyTo(String username) {
    _expandToFull();
    final mention = '@$username ';
    _inputCtrl
      ..text = mention
      ..selection = TextSelection.fromPosition(TextPosition(offset: mention.length));
    _inputFocus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DraggableScrollableSheet(
      controller: _dragCtrl,
      expand: false,
      minChildSize: 0.5,
      initialChildSize: 0.5,
      maxChildSize: 1.0,
      snap: true,
      snapSizes: const [0.5, 1.0],
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              // Handle
              Container(
                width: 44,
                height: 5,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              // Header simple
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Commentaires",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Divider(height: 1),
              // ---- Liste des commentaires (scrollable) ----
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (context, i) => _CommentTile(
                    data: widget.comments[i],
                    onReply: _replyTo,
                  ),
                  separatorBuilder: (_, __) => const SizedBox(height: 4),
                  itemCount: widget.comments.length,
                ),
              ),
              const Divider(height: 1),
              // Réactions
              SizedBox(
                height: 44,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  children: const [
                    _ReactionChip("💀", fontSize: 14, hp: 10, vp: 6),
                    _ReactionChip("🙌", fontSize: 14, hp: 10, vp: 6),
                    _ReactionChip("🔥", fontSize: 14, hp: 10, vp: 6),
                    _ReactionChip("👏", fontSize: 14, hp: 10, vp: 6),
                    _ReactionChip("🥲", fontSize: 14, hp: 10, vp: 6),
                    _ReactionChip("😍", fontSize: 14, hp: 10, vp: 6),
                    _ReactionChip("😮", fontSize: 14, hp: 10, vp: 6),
                    _ReactionChip("😂", fontSize: 14, hp: 10, vp: 6),
                  ],
                ),
              ),
              // ---- Champ d’entrée ----
              SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 12,
                    right: 12,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 8,
                  ),
                  child: Row(
                    children: [
                      const _Avatar(size: 28),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _inputCtrl,
                          focusNode: _inputFocus,
                          minLines: 1,
                          maxLines: 4,
                          onTap: _expandToFull,
                          textInputAction: TextInputAction.send,
                          decoration: InputDecoration(
                            hintText: "Ajoutez un commentaire…",
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.send),
                        tooltip: "Envoyer",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CommentTile extends StatefulWidget {
  final CommentData data;
  final void Function(String username) onReply;
  const _CommentTile({required this.data, required this.onReply});

  @override
  State<_CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<_CommentTile>
    with SingleTickerProviderStateMixin {
  bool liked = false;
  late final AnimationController _popCtrl;

  @override
  void initState() {
    super.initState();
    _popCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      lowerBound: 1.0,
      upperBound: 1.2,
    );
  }

  @override
  void dispose() {
    _popCtrl.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() => liked = !liked);
    _popCtrl
        .forward()
        .then((_) => _popCtrl.reverse());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final d = widget.data;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Avatar(image: d.avatarUrl, size: 40),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ligne auteur + temps + badge
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        d.author,
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text("• ${d.timeLabel}",
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: theme.hintColor)),
                    if (d.isAuthor) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color:
                          theme.colorScheme.primary.withOpacity(0.12),
                        ),
                        child: Text("Auteur(ice)",
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(d.text, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 3),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => widget.onReply(d.author), // 3)
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 26),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text("Répondre"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              GestureDetector(
                onTap: _toggleLike,
                child: ScaleTransition(
                  scale: _popCtrl,
                  child: Icon(
                    liked ? Icons.favorite : Icons.favorite_border,
                    color: liked
                        ? Colors.red
                        : theme.iconTheme.color?.withOpacity(0.8),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                d.likes.toString(),
                style: theme.textTheme.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReactionChip extends StatelessWidget {
  final String emoji;
  final double fontSize;
  final double hp;
  final double vp;
  const _ReactionChip(this.emoji,
      {this.fontSize = 16, this.hp = 10, this.vp = 6});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: hp, vertical: vp),
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Text(emoji, style: TextStyle(fontSize: fontSize)),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? image;
  final double size;
  const _Avatar({this.image, this.size = 40});

  @override
  Widget build(BuildContext context) {
    final placeholder = CircleAvatar(
      radius: size / 2,
      child: const Icon(Icons.person),
    );
    if (image == null || image!.isEmpty) return placeholder;
    if (image!.startsWith('http')) {
      return CircleAvatar(
          radius: size / 2, backgroundImage: NetworkImage(image!));
    }
    return CircleAvatar(
        radius: size / 2, backgroundImage: AssetImage(image!));
  }
}
