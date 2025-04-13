import 'package:aproko_app/models/challenge.dart';
import 'package:aproko_app/providers/challenge_provider.dart';
import 'package:aproko_app/screens/challenges/challenge_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart' as yt;

IconData _getCategoryIcon(ChallengeCategory category) {
  switch (category) {
    case ChallengeCategory.nutrition:
      return Icons.restaurant_menu;
    case ChallengeCategory.medication:
      return Icons.medication;
    case ChallengeCategory.fitness:
      return Icons.fitness_center;
  }
}

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  late YoutubePlayerController _controller;
  List<String> videoIds = ['ZWn9Jn1LT9I', 'JTz4OEkn0TQ', 'BdFwUEGhZss'];
  String videoId = '0616BfybtRY';
  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: true,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(16.w),
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Discover', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 80,
                        child: Consumer<ChallengeProvider>(
                          builder: (context, provider, child) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: provider.challenges.length,
                              itemBuilder: (context, index) {
                                final challenge = provider.challenges[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 6.w),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChallengeDetailsScreen(
                                            challenge: challenge,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 220,
                                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                                      decoration: BoxDecoration(
                                        color: challenge.getCategoryColor().withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12.w),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: challenge.getCategoryDarkColor(),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              _getCategoryIcon(challenge.category),
                                              size: 14.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              challenge.name,
                                              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),

                      // YouTube Video Section
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.w),
                          color: Colors.black,
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: YoutubePlayer(
                          controller: _controller,
                          aspectRatio: 489 / 629,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Is it possible for a woman to be pregnant and not know? The answer might surprise you!',
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: 12.h),
                      Text(
                        'In this insightful conversation, Dr. Abosede Lewu, a consultant gynecologist, breaks down the science behind cryptic pregnancies, PCOS, infertility, and reproductive health.',
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 12.h),
                      ElevatedButton(
                        onPressed: () {
                          // Add your onPressed logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.w),
                          ),
                        ),
                        child: Text(
                          'Speak to a Doctor',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
