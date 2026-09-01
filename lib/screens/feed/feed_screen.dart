import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/post_model.dart';
import '../auth/login_screen.dart';

class GolpogramFeedScreen extends StatefulWidget {
  final String userName;
  const GolpogramFeedScreen({super.key, required this.userName});

  @override
  State<GolpogramFeedScreen> createState() => _GolpogramFeedScreenState();
}

class _GolpogramFeedScreenState extends State<GolpogramFeedScreen> {
  final TextEditingController _postController = TextEditingController();
  final List<PostItem> _posts = [
    PostItem(
      id: '1',
      author: 'Golpo Premi',
      time: '1 hr ago',
      text: 'সোশ্যাল মিডিয়া হোক হালকা এবং সহজ। কোনো ভারী বোঝা নয়, শুধু আন্তরিক আড্ডা। ☕📖',
      likes: 8,
      isLiked: false,
      comments: ['একদম সত্যি কথা!'],
    ),
  ];

  void _addNewPost() {
    final text = _postController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _posts.insert(
        0,
        PostItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          author: widget.userName,
          time: 'Just now',
          text: text,
        ),
      );
    });

    _postController.clear();
    Navigator.pop(context);
  }

  void _openCreatePostModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          top: 20,
          left: 18,
          right: 18,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('নতুন গল্প লিখুন', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF00897B))),
                IconButton(icon: const Icon(Icons.close, color: Colors.grey), onPressed: () => Navigator.pop(context))
              ],
            ),
            const Divider(),
            TextField(
              controller: _postController,
              maxLines: 5,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'আজকের গল্প বা ভাবনা কী?...', border: InputBorder.none),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00897B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: _addNewPost,
              icon: const Icon(Icons.send_rounded),
              label: const Text('পোস্ট করুন', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }

  void _showCommentsModal(PostItem post) {
    final TextEditingController commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.65,
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 16, left: 16, right: 16),
          child: Column(
            children: [
              const Text('মন্তব্যসমূহ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              const Divider(),
              Expanded(
                child: post.comments.isEmpty
                    ? const Center(child: Text('এখনো কোনো মন্তব্য নেই। প্রথম মন্তব্যটি আপনিই করুন!'))
                    : ListView.builder(
                        itemCount: post.comments.length,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: const Color(0xFFF4F6F8), borderRadius: BorderRadius.circular(12)),
                          child: Text(post.comments[index], style: const TextStyle(fontSize: 14)),
                        ),
                      ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: commentController,
                      decoration: const InputDecoration(hintText: 'একটি সুন্দর মন্তব্য লিখুন...', border: InputBorder.none),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFF00897B)),
                    onPressed: () {
                      if (commentController.text.trim().isNotEmpty) {
                        setState(() {
                          post.comments.add('${widget.userName}: ${commentController.text.trim()}');
                        });
                        setModalState(() {});
                        commentController.clear();
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.menu_book_rounded, color: Color(0xFF00897B), size: 28),
            SizedBox(width: 8),
            Text('Golpogram', style: TextStyle(color: Color(0xFF00897B), fontWeight: FontWeight.w900, fontSize: 22)),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'লগআউট',
            icon: const Icon(Icons.logout_rounded),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!context.mounted) return;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFF00897B),
                  child: Text(
                    widget.userName.isNotEmpty ? widget.userName[0].toUpperCase() : 'U',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: _openCreatePostModal,
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                      decoration: BoxDecoration(color: const Color(0xFFF4F6F8), borderRadius: BorderRadius.circular(24)),
                      child: Text("${widget.userName}, নতুন কোনো গল্প আছে?", style: const TextStyle(color: Colors.grey, fontSize: 14)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ..._posts.map((post) {
            return Container(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xFFE0F2F1),
                        child: Text(
                          post.author.isNotEmpty ? post.author[0].toUpperCase() : 'U',
                          style: const TextStyle(color: Color(0xFF00897B), fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post.author, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          Text(post.time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                      const Spacer(),
                      if (post.author == widget.userName)
                        PopupMenuButton<String>(
                          onSelected: (val) {
                            if (val == 'delete') {
                              setState(() => _posts.removeWhere((item) => item.id == post.id));
                            }
                          },
                          itemBuilder: (ctx) => [const PopupMenuItem(value: 'delete', child: Text('Delete Story'))],
                        )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(post.text, style: const TextStyle(fontSize: 15, height: 1.45, color: Colors.black87)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${post.likes} Likes', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      Text('${post.comments.length} Comments', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            post.isLiked = !post.isLiked;
                            post.likes += post.isLiked ? 1 : -1;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                          child: Row(
                            children: [
                              Icon(post.isLiked ? Icons.favorite : Icons.favorite_border, size: 20, color: post.isLiked ? Colors.red : Colors.grey[700]),
                              const SizedBox(width: 6),
                              Text('Like', style: TextStyle(color: post.isLiked ? Colors.red : Colors.grey[700], fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => _showCommentsModal(post),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                          child: Row(
                            children: [
                              Icon(Icons.mode_comment_outlined, size: 19, color: Colors.grey[700]),
                              const SizedBox(width: 6),
                              Text('Comment', style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
