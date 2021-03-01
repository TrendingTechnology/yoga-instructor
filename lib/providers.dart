import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofia/application/notifiers/auth_current_user_notifier.dart';
import 'package:sofia/application/notifiers/auth_sign_in_notifier.dart';
import 'package:sofia/utils/authentication_client.dart';

final authenticationClientProvider = Provider<AuthenticationClient>(
  (ref) => AuthenticationClient(),
);

final authSignInNotifierProvider = StateNotifierProvider(
  (ref) => AuthSignInNotifier(ref.watch(authenticationClientProvider)),
);

final authCurrentUserNotifierProvider = StateNotifierProvider(
  (ref) => AuthCurrentUserNotifier(ref.watch(authenticationClientProvider)),
);
