import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/common/result_state.dart';
import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/data/local/auth_repository.dart';
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
          builder: (context, state, child) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Detail'),
                ),
                body: state.state == ResultState.loading
                    ? const Center(child: CircularProgressIndicator())
                    : state.state == ResultState.hasData
                        ? _buildDetail(state, context)
                        : const Center(child: Text('No data')));
          },
        ));
  }

  Widget _buildDetail(DetailProvider state, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            child: Image.network(state.detailResponse.story.photoUrl,
                fit: BoxFit.cover, width: double.infinity, height: 300),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(state.detailResponse.story.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Text(state.detailResponse.story.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
