import 'package:get_it/get_it.dart';
import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/data/local/auth_repository.dart';
import 'package:story_app/provider/auth_provider.dart';
import 'package:story_app/provider/story_provider.dart';
import 'package:story_app/provider/upload_provider.dart';

final locator = GetIt.instance;

void init() {
  locator.registerLazySingleton<AuthProvider>(
      () => AuthProvider(locator(), locator()));
  locator.registerLazySingleton<StoryProvider>(
      () => StoryProvider(locator(), locator()));
  locator.registerLazySingleton<UploadProvider>(
      () => UploadProvider(locator(), locator()));

  locator.registerLazySingleton<AuthRepository>(() => AuthRepository());
  locator.registerLazySingleton<ApiService>(() => ApiService());
}
