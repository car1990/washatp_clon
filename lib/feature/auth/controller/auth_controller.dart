import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clon/common/models/user_model.dart';
import 'package:whatsapp_clon/feature/auth/auth_repository.dart';

final autControllerProvider = Provider(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    return AuthController(
      authRepository: authRepository,
      ref: ref,
    );
  },
);

final userInfoAuthProvider = FutureProvider((ref) {
  final AuthController = ref.watch(autControllerProvider);
  return AuthController.getCurrentUserInfo();
});

class AuthController {
  final AuthRepository authRepository;

  final ProviderRef ref;

  AuthController({required this.authRepository, required this.ref});

  Future<UserModel?> getCurrentUserInfo() async {
    UserModel? user = await authRepository.getCurrentUserInfo();
    return user;
  }

  void saveUserInfotoFirestore({
    required String username,
    required var profileImage,
    required BuildContext context,
    required bool mounted, required String imageUrl,
  }) {
    authRepository.saveUserInfotoFirestore(
        username: username,
        profileImage: profileImage,
        ref: ref,
        context: context,
        mounted: mounted);
  }

  void verifySmsCode({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) {
    authRepository.verifySmsCode(
      context: context,
      smsCodeId: smsCodeId,
      smsCode: smsCode,
      mounted: mounted,
    );
  }

  void sendSmsCode({
    required BuildContext context,
    required String phoneNumber,
  }) {
    authRepository.sendSmsCode(
      context: context,
      phoneNumber: phoneNumber,
    );
  }
}
