import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofia/application/notifiers/auth_current_user_notifier.dart';
import 'package:sofia/application/notifiers/auth_sign_in_notifier.dart';
import 'package:sofia/application/notifiers/store_user_data_notifier.dart';
import 'package:sofia/utils/authentication_client.dart';
import 'package:sofia/utils/database.dart';

// Authentication Providers: ---------------------------------
final authenticationClientProvider = Provider<AuthenticationClient>(
  (ref) => AuthenticationClient(),
);

final authSignInNotifierProvider = StateNotifierProvider(
  (ref) => AuthSignInNotifier(ref.watch(authenticationClientProvider)),
);

final authCurrentUserNotifierProvider = StateNotifierProvider(
  (ref) => AuthCurrentUserNotifier(ref.watch(authenticationClientProvider)),
);

// Databse Providers: -----------------------------------------
final databaseProvider = Provider<Database>(
  (ref) => Database(),
);

final storeUserDataNotifierProvider = StateNotifierProvider(
  (ref) => StoreUserDataNotifier(ref.watch(databaseProvider)),
);
