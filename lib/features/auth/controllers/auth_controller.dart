import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/features/auth/repository/auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository);
});

class AuthController {
  final AuthRepository authRepository;
  AuthController({required this.authRepository});
  void verifyOtpCode(
      {required BuildContext context,
      required String smsCodeId,
      required String smsCode,
      required bool mounted}) {
    authRepository.verifyOtp(
        context: context,
        smsCodeId: smsCodeId,
        smsCode: smsCode,
        mounted: mounted);
  }

  void sentSms({required BuildContext context,required String phone,}){
    authRepository.sendOtp(context: context, phone: phone);
  }
}
