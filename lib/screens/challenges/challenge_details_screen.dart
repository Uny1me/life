import 'package:flutter/material.dart';
import 'package:aproko_app/models/challenge.dart';
import 'package:provider/provider.dart';
import 'package:aproko_app/providers/challenge_provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ChallengeDetailsScreen extends StatefulWidget {
  final Challenge challenge;

  const ChallengeDetailsScreen({
    super.key,
    required this.challenge,
  });

  @override
  State<ChallengeDetailsScreen> createState() => _ChallengeDetailsScreenState();
}

class _ChallengeDetailsScreenState extends State<ChallengeDetailsScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.challenge.videoId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.challenge.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Challenge header with image
              if (widget.challenge.videoId.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: YoutubePlayer(
                    controller: _controller,
                    aspectRatio: 489 / 629,
                  ),
                ),
              // if (widget.challenge.pictures.isNotEmpty)
              //   Container(
              //     height: 200,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //         image: NetworkImage(widget.challenge.pictures.first),
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ),

              // YouTube Video Section

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: widget.challenge.getCategoryColor().withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      widget.challenge.category.name.toUpperCase(),
                      style: TextStyle(
                        color: widget.challenge.getCategoryColor(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Description
                  Text(
                    widget.challenge.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Duration
                  Row(
                    children: [
                      Icon(
                        Icons.timer,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Duration: ${widget.challenge.duration.inDays} days',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Start/Stop Challenge button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final provider = Provider.of<ChallengeProvider>(
                          context,
                          listen: false,
                        );
                        provider.toggleChallengeStatus(widget.challenge.id);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.challenge.isActive ? Colors.red : widget.challenge.getCategoryColor(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        widget.challenge.isActive ? 'Stop Challenge' : 'Start Challenge',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
