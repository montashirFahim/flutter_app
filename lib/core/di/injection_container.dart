// lib/core/di/injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:app_1/features/auth/data/repositories/mock_auth_repo.dart';
import 'package:app_1/features/auth/domain/repositories/auth_repo.dart';
import 'package:app_1/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app_1/features/feed/data/repositories/mock_feed_repo.dart';
import 'package:app_1/features/feed/domain/repositories/feed_repo.dart';
import 'package:app_1/features/feed/presentation/cubit/feed_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Repositories
  sl.registerLazySingleton<AuthRepo>(() => MockAuthRepo());
  sl.registerLazySingleton<FeedRepo>(() => MockFeedRepo());

  // Cubits
  sl.registerFactory(() => AuthCubit(authRepo: sl()));
  sl.registerFactory(() => FeedCubit(feedRepo: sl(), authCubit: sl()));
}
