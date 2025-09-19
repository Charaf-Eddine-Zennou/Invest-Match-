import 'package:flutter/material.dart';
import 'bottom_sheet_post_actions.dart';
import 'comments_sheet.dart';

class FeedPost extends StatefulWidget {
  final String companyName;
  final String profilePicPath;
  final String caption;
  final List<String> media;
  final bool isFollowing;
  final VoidCallback onProfileTap;

  const FeedPost({
    super.key,
    required this.companyName,
    required this.profilePicPath,
    required this.caption,
    required this.media,
    required this.isFollowing,
    required this.onProfileTap,
  });

  @override
  State<FeedPost> createState() => _FeedPostState();
}

class _FeedPostState extends State<FeedPost> with TickerProviderStateMixin {
  bool isLiked = false;
  bool isDisliked = false;
  bool isFollowing = false;
  bool captionExpanded = false;

  late final AnimationController _likeController;
  late final AnimationController _dislikeController;

  @override
  void initState() {
    super.initState();
    isFollowing = widget.isFollowing;
    _likeController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 250), lowerBound: 1.0, upperBound: 1.2);
    _dislikeController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 250), lowerBound: 1.0, upperBound: 1.2);
  }

  @override
  void dispose() {
    _likeController.dispose();
    _dislikeController.dispose();
    super.dispose();
  }

  void _onLike() {
    setState(() {
      isLiked = !isLiked;
      if (isLiked) {
        isDisliked = false;
        _likeController.forward().then((_) => _likeController.reverse());
      }
    });
  }

  void _onDislike() {
    setState(() {
      isDisliked = !isDisliked;
      if (isDisliked) {
        isLiked = false;
        _dislikeController.forward().then((_) => _dislikeController.reverse());
      }
    });
  }

  // ---- Commentaires ----
  void _openComments() {
    final fake = <CommentData>[
      CommentData(
        author: "marie_lbt",
        avatarUrl: "https://i.pravatar.cc/150?img=47",
        text: "Incroyable ce projet, hâte de voir la suite 🔥",
        timeLabel: "2 j",
        likes: 154,
      ),
      CommentData(
        author: "thomas.dev",
        avatarUrl: "https://i.pravatar.cc/150?img=12",
        text: "Ça mérite clairement plus de visibilité 👏",
        timeLabel: "3 j",
        likes: 98,
      ),
      CommentData(
        author: "laura_art",
        avatarUrl: "https://i.pravatar.cc/150?img=22",
        text: "Super design, l'UI est vraiment clean ! 🎨",
        timeLabel: "5 j",
        likes: 312,
      ),
      CommentData(
        author: "alexandre_io",
        avatarUrl: "https://i.pravatar.cc/150?img=56",
        text: "Vous prévoyez une version web aussi ? 💻",
        timeLabel: "1 sem",
        likes: 47,
      ),
      CommentData(
        author: "chloe_ventures",
        avatarUrl: "https://i.pravatar.cc/150?img=39",
        text: "Si besoin d’un investisseur early stage, je suis là 😉",
        timeLabel: "1 sem",
        likes: 201,
      ),
      CommentData(
        author: "quentin_pro",
        avatarUrl: "https://i.pravatar.cc/150?img=5",
        text: "Très pro, ça respire la qualité.",
        timeLabel: "2 sem",
        likes: 77,
      ),
      CommentData(
        author: "mathilde.k",
        avatarUrl: "https://i.pravatar.cc/150?img=31",
        text: "Vraiment inspirant 🙌",
        timeLabel: "3 sem",
        likes: 120,
      ),
      CommentData(
        author: "yannick_data",
        avatarUrl: "https://i.pravatar.cc/150?img=9",
        text: "Je suis curieux de voir l’algorithme de matching en action 🤖",
        timeLabel: "4 sem",
        likes: 65,
      ),
    ];

    showCommentsSheet(context, comments: fake);
  }


  @override
  Widget build(BuildContext context) {
    final double bottomPadding = 18 + MediaQuery.of(context).padding.bottom;

    return Stack(
      children: [
        // Media
        Positioned.fill(
          child: widget.media.length > 1
              ? PageView.builder(
            itemCount: widget.media.length,
            itemBuilder: (context, index) {
              final mediaPath = widget.media[index];
              return mediaPath.endsWith('.mp4')
                  ? Container(color: Colors.grey)
                  : Image.asset(mediaPath, fit: BoxFit.cover);
            },
          )
              : (widget.media.isNotEmpty
              ? (widget.media[0].endsWith('.mp4')
              ? Container(color: Colors.grey)
              : Image.asset(widget.media[0], fit: BoxFit.cover))
              : Container(color: Colors.black)),
        ),

        // ---- Overlay noir quand la caption est dépliée ----
        if (captionExpanded)
          Positioned.fill(
            child: AnimatedOpacity(
              opacity: captionExpanded ? 1.0 : 0.0,
              duration: Duration(milliseconds: 200),
              child: Container(color: Colors.black.withOpacity(0.19)),
            ),
          ),

        // ---- Boutons verticaux à droite ----
        Positioned(
          bottom: bottomPadding + 6,
          right: 14,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: _onLike,
                child: ScaleTransition(
                  scale: _likeController,
                  child: Icon(Icons.favorite, color: isLiked ? Colors.red : Colors.white, size: 44),
                ),
              ),
              SizedBox(height: 26),
              GestureDetector(
                onTap: _onDislike,
                child: ScaleTransition(
                  scale: _dislikeController,
                  child: Icon(Icons.thumb_down, color: isDisliked ? Colors.red : Colors.white, size: 39),
                ),
              ),
              SizedBox(height: 26),
              GestureDetector(
                onTap: _openComments,
                child: const Icon(Icons.mode_comment_outlined,
                    color: Colors.white, size: 38),
              ),
              SizedBox(height: 26),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    constraints: BoxConstraints(maxHeight: 180),
                    builder: (_) => BottomSheetPostActions(),
                  );
                },
                child: Icon(Icons.more_vert, color: Colors.white, size: 40),
              ),
            ],
          ),
        ),

        // ---- Bloc profil + caption en bas ----
        Positioned(
          left: 16,
          right: 80,
          bottom: bottomPadding,
          child: AnimatedSize(
            duration: Duration(milliseconds: 210),
            curve: Curves.easeInOut,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // ---- Bloc profil ----
                Row(
                  children: [
                    GestureDetector(
                      onTap: widget.onProfileTap,
                      child: CircleAvatar(radius: 22, backgroundImage: AssetImage(widget.profilePicPath)),
                    ),
                    SizedBox(width: 9),
                    GestureDetector(
                      onTap: widget.onProfileTap,
                      child: Text(widget.companyName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
                    ),
                    SizedBox(width: 8),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: isFollowing ? Colors.white : Colors.transparent,
                        side: BorderSide(color: Colors.white, width: 1),
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        minimumSize: Size(0, 26),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () => setState(() => isFollowing = !isFollowing),
                      child: Text(
                        isFollowing ? "Suivi" : "Suivre",
                        style: TextStyle(color: isFollowing ? Colors.black : Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                GestureDetector(
                  onTap: () => setState(() => captionExpanded = !captionExpanded),
                  child: AnimatedSize(
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.easeInOutCubic,
                    child: GestureDetector(
                      onTap: () => setState(() => captionExpanded = !captionExpanded),
                      child: captionExpanded
                          ? SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.caption,
                              style: TextStyle(color: Colors.white, fontSize: 16, height: 1.23),
                            ),
                            GestureDetector(
                              onTap: () => setState(() => captionExpanded = false),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2.5),
                                child: Text("Voir moins", style: TextStyle(color: Colors.white54, fontSize: 13)),
                              ),
                            ),
                          ],
                        ),
                      )
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.caption,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white, fontSize: 16, height: 1.23),
                          ),
                          Text("Voir plus", style: TextStyle(color: Colors.white60, fontSize: 13)),
                        ],
                      ),
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
