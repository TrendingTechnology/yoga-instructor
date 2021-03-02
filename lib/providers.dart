import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofia/application/notifiers/auth_current_user_notifier.dart';
import 'package:sofia/application/notifiers/auth_sign_in_notifier.dart';
import 'package:sofia/application/notifiers/retrieve_poses_notifier.dart';
import 'package:sofia/application/notifiers/store_user_data_notifier.dart';
import 'package:sofia/utils/authentication_client.dart';
import 'package:sofia/utils/database.dart';

final authenticationClientProvider = Provider<AuthenticationClient>(
  (ref) => AuthenticationClient(),
);

final databaseProvider = Provider<Database>(
  (ref) => Database(),
);

final authSignInNotifierProvider = StateNotifierProvider(
  (ref) => AuthSignInNotifier(ref.watch(authenticationClientProvider)),
);

final authCurrentUserNotifierProvider = StateNotifierProvider(
  (ref) => AuthCurrentUserNotifier(
    ref.watch(authenticationClientProvider),
    ref.watch(databaseProvider),
  ),
);

final storeUserDataNotifierProvider = StateNotifierProvider(
  (ref) => StoreUserDataNotifier(ref.watch(databaseProvider)),
);

final retrievePosesNotifierProvider = StateNotifierProvider(
  (ref) => RetrievePosesNotifier(ref.watch(databaseProvider)),
);
