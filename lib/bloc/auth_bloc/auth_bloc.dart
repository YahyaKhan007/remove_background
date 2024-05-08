import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../models/models.dart';
import '../../services/services.dart';
import '../../views/screens.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  final DataBaseService dataBaseService;
  AuthBloc(this.authService, this.dataBaseService)
      : super(AuthState(currentUserModel: null)) {
    on<GotoRegisterationScreenEvent>(_gotoRegisterationScreen);
    on<GotoLoginScreenEvent>(_gotoLoginSceen);
    on<GoogleLoginEvent>(_googleLoginEvent);
    on<AppleLoginEvent>(_appleLoginEvent);
    on<ShowPasswordEvent>(_showPassword);
    on<LoggingInEvent>(_loggingInEvent);
    on<SignupEvent>(_signupEvent);
    on<IsLoggedInEvent>(_isLoggedInEvent);
  }

  // ~ Regustration Events
  void _gotoRegisterationScreen(
      GotoRegisterationScreenEvent event, Emitter<AuthState> emit) {
    Get.to(() => RegistrationScreen());
  }

  // ~Login Events
  void _gotoLoginSceen(GotoLoginScreenEvent event, Emitter<AuthState> emit) {
    Get.to(() => LoginScreen());
  }

  void _showPassword(ShowPasswordEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(showPassword: event.isShow));
  }

  void _googleLoginEvent(
      GoogleLoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isGoogleLoading: true));

    log('Google 1');

    final res = await authService.signInwithGoogle();
    log('Google 2');
    if (res.res == true) {
      emit(state.copyWith(isGoogleLoading: false, currentUserModel: res.user));
      Get.offAll(() => const HomePage());
    } else {
      log('There has been some issue ');
      emit(state.copyWith(isGoogleLoading: false));
    }
  }

  void _appleLoginEvent(AppleLoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isAppleLoading: true));
    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(isAppleLoading: false));
  }

  void _loggingInEvent(LoggingInEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    log("Bloc   ----> ${event.password}");

    final result = await authService.loginUser(
        email: event.email, password: event.password);

    if (result.isSuccess == true) {
      emit(state.copyWith(isLoading: false));

      Get.to(
        () => const HomePage(),
        popGesture: true,
        preventDuplicates: true,
        opaque: false,
        duration: const Duration(milliseconds: 1000),
      );
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _signupEvent(SignupEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    var result = await authService.signupUserWithEmailPassword(
        userEmail: event.email,
        userPassword: event.password,
        confirmPassword: event.confirm);

    if (result != true) {
      emit(
        state.copyWith(isLoading: false),
      );
    } else {
      emit(
        state.copyWith(isLoading: false),
      );
      Get.offAll(
        () => const HomePage(),
        popGesture: true,
        // preventDuplicates: true,s
        opaque: false,
        duration: const Duration(milliseconds: 500),
      );
    }
  }

  FutureOr<void> _isLoggedInEvent(
      IsLoggedInEvent event, Emitter<AuthState> emit) async {
    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );

    if (authService.auth.currentUser != null) {
      final currentUserModel =
          await DataBaseService.getUserbyUid(authService.auth.currentUser!.uid);

      if (currentUserModel != null) {
        Get.offAll(() => HomePage(
              userModel: currentUserModel,
            ));
      }
    } else {
      Get.offAll(() => const LoginOptionScreen());
    }
  }
}
