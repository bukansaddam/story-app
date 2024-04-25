import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/data/local/auth_repository.dart';
import 'package:story_app/data/responses/detail_story_response.dart';
import 'package:story_app/provider/detail_provider.dart';

class DetailScreen extends StatefulWidget {
  final String id;
  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailProvider(
        apiService: ApiService(),
        authRepository: AuthRepository(),
        id: widget.id,
      ),
      child: Consumer<DetailProvider>(
        builder: (context, detailProvider, child) {
          final state = detailProvider.detailState;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Detail'),
            ),
            body: state.map(
              initial: (_) => const SizedBox
                  .shrink(), // Tidak melakukan apa-apa saat initial state
              loading: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
              loaded: (value) {
                final detailStory = detailProvider.detailResponse;
                return _buildDetail(detailStory, context);
              }, // Tampilkan detail saat data telah dimuat
              error: (value) => Center(
                child: Text(
                  value.message,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetail(DetailResponse state, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            child: Image.network(state.story.photoUrl,
                fit: BoxFit.cover, width: double.infinity, height: 300),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(state.story.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Text(state.story.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
