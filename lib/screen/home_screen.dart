import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/responses/story_response.dart';
import 'package:story_app/provider/auth_provider.dart';
import 'package:story_app/provider/image_provider.dart';
import 'package:story_app/provider/story_provider.dart';
import 'package:story_app/screen/widgets/card_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final apiProvider = context.read<StoryProvider>();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (apiProvider.pageItems != null) {
          apiProvider.fetchAllStory();
        }
      }
    });

    Future.microtask(() async => apiProvider.fetchAllStory());
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Story App'),
          actions: [
            IconButton(
              onPressed: () {
                GoRouter.of(context).goNamed('maps');
              },
              icon: const Icon(Icons.map_outlined),
            ),
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
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Logout'),
                            content: const Text('Are you sure want to logout?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  authProvider.logout();
                                  scaffoldMessenger.showSnackBar(
                                    const SnackBar(
                                      content: Text('Logout success'),
                                    ),
                                  );
                                  GoRouter.of(context).goNamed('login');
                                },
                                child: const Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('No'),
                              ),
                            ],
                          );
                        },
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
        final state = storyProvider.storyState;

        return state.map(
          initial: (_) => const SizedBox.shrink(),
          loading: (_) => const Center(
            child: CircularProgressIndicator(),
          ),
          loaded: (value) {
            final stories = storyProvider.stories;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth <= 600) {
                    return _buildListView(stories, storyProvider);
                  } else if (constraints.maxWidth <= 1200) {
                    return _buildGridView(stories, storyProvider,
                        crossAxisCount: 2);
                  } else {
                    return _buildGridView(stories, storyProvider,
                        crossAxisCount: 3);
                  }
                },
              ),
            );
          },
          error: (value) => Center(
            child: Text(
              value.message,
            ),
          ),
        );
      },
    );
  }

  Widget _buildListView(List<ListStory> stories, StoryProvider storyProvider) {
    return ListView.builder(
      controller: scrollController,
      itemCount: stories.length + (storyProvider.pageItems != null ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == stories.length && storyProvider.pageItems != null) {
          return const Center(child: CircularProgressIndicator());
        }
        final story = stories[index];
        return CardItem(context: context, story: story);
      },
    );
  }

  Widget _buildGridView(List<ListStory> stories, StoryProvider storyProvider,
      {required int crossAxisCount}) {
    return GridView.builder(
      controller: scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: stories.length + (storyProvider.pageItems != null ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == stories.length && storyProvider.pageItems != null) {
          return const Center(child: CircularProgressIndicator());
        }
        final story = stories[index];
        return CardItem(context: context, story: story);
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
      GoRouter.of(context).pop();
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
      GoRouter.of(context).pop();
    }
  }
}
