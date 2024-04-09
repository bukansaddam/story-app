import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:story_app/common/result_state.dart';
import 'package:story_app/provider/auth_provider.dart';
import 'package:story_app/provider/image_provider.dart';
import 'package:story_app/provider/story_provider.dart';
import 'package:story_app/screen/widgets/card_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Story App'),
          actions: [
            Consumer<AuthProvider>(
              builder: (context, authProvider, _) {
                final isLoggedIn = authProvider.checkLogin();
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                if (isLoggedIn == false) {
                  return IconButton(
                    onPressed: () {
                      GoRouter.of(context).goNamed('login');
                    },
                    icon: const Icon(Icons.login),
                  );
                } else {
                  return IconButton(
                    onPressed: () {
                      authProvider.logout();
                      GoRouter.of(context).goNamed('login');
                      scaffoldMessenger.showSnackBar(
                        const SnackBar(
                          content: Text('Logout success'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.logout),
                  );
                }
              },
            ),
          ],
        ),
        body: _buildBody(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // GoRouter.of(context).goNamed('add_story');
            _buildBottomSheet(context);
          },
          shape: const CircleBorder(),
          backgroundColor: Colors.orange,
          child: const Icon(Icons.add),
        ));
  }

  Future<void> _buildBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0, top: 16),
                child: Text(
                  'Add Story',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
                onTap: () {
                  _onCameraView(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
                onTap: () {
                  _onGalleryView(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return Consumer<StoryProvider>(
      builder: (context, storyProvider, _) {
        if (storyProvider.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (storyProvider.state == ResultState.hasData) {
          return Padding(
              padding: const EdgeInsets.all(16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth <= 600) {
                    return ListView.builder(
                      itemCount: storyProvider.storyResponse.listStory.length,
                      itemBuilder: (context, index) {
                        final story =
                            storyProvider.storyResponse.listStory[index];
                        return CardItem(context: context, story: story);
                      },
                    );
                  } else if (constraints.maxWidth <= 1200) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: storyProvider.storyResponse.listStory.length,
                      itemBuilder: (context, index) {
                        final story =
                            storyProvider.storyResponse.listStory[index];
                        return CardItem(context: context, story: story);
                      },
                    );
                  } else {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: storyProvider.storyResponse.listStory.length,
                      itemBuilder: (context, index) {
                        final story =
                            storyProvider.storyResponse.listStory[index];
                        return CardItem(context: context, story: story);
                      },
                    );
                  }
                },
              ));
        } else {
          return Center(child: Text(storyProvider.message ?? 'Error'));
        }
      },
    );
  }

  void _onCameraView(BuildContext context) async {
    final provider = context.read<ImagesProvider>();

    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;

    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
      GoRouter.of(context).goNamed('add_story');
      Navigator.of(context).pop();
    }
  }

  _onGalleryView(BuildContext context) async {
    final provider = context.read<ImagesProvider>();

    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;
    if (isMacOS || isLinux) return;

    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
      GoRouter.of(context).goNamed('add_story');
      Navigator.of(context).pop();
    }
  }
}
