import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:story_app/provider/image_provider.dart';
import 'package:story_app/provider/story_provider.dart';
import 'package:story_app/provider/upload_provider.dart';

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({super.key});

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _storyDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Story'),
      ),
      body: SingleChildScrollView(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            shape: BoxShape.rectangle,
          ),
          child: context.watch<ImagesProvider>().imagePath == null
              ? const Center(
                  child: Text('No image selected'),
                )
              : _showImage(),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _storyDescriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: context.watch<UploadProvider>().isUploading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.orange),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            _onUpload();
                          },
                          child: const Text(
                            'SUBMIT',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _showImage() {
    final imagePath = context.read<ImagesProvider>().imagePath;
    return kIsWeb
        ? Image.network(
            imagePath.toString(),
            fit: BoxFit.cover,
          )
        : Image.file(
            File(imagePath.toString()),
            fit: BoxFit.cover,
          );
  }

  _onUpload() async {
    final imageProvider = context.read<ImagesProvider>();
    final imagePath = imageProvider.imagePath;
    final imageFile = imageProvider.imageFile;
    final storyDescription = _storyDescriptionController.text;
    if (imagePath == null || imageFile == null) return;

    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final fileName = imageFile.name;
    final image = await imageFile.readAsBytes();

    final uploadProvider = context.read<UploadProvider>();

    final newBytes = await uploadProvider.compressImage(image);

    await uploadProvider.upload(newBytes, storyDescription, fileName);
    final storyProvider = context.read<StoryProvider>();
    await storyProvider.fetchAllStory();

    if (uploadProvider.uploadResponse != null) {
      imageProvider.setImageFile(null);
      imageProvider.setImagePath(null);
    }

    debugPrint('UploadResponse: ${uploadProvider.uploadResponse?.message}');

    scaffoldMessenger.showSnackBar(
      SnackBar(
        content:
            Text(uploadProvider.uploadResponse?.message ?? 'Upload failed'),
      ),
    );

    GoRouter.of(context).goNamed('home');
  }
}
