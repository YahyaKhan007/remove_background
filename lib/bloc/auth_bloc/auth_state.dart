// ignore_for_file: must_be_immutable

part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final bool isGoogleLoading;
  final bool isAppleLoading;
  final bool showPassword;
  final UserModel? currentUserModel;

  AuthState({
    this.isLoading = false,
    this.isGoogleLoading = false,
    this.isAppleLoading = false,
    this.showPassword = false,
    required this.currentUserModel,
  });

  AuthState copyWith(
      {bool? isLoading,
      UserModel? currentUserModel,
      bool? isGoogleLoading,
      bool? isAppleLoading,
      
      bool? showPassword}) {
    return AuthState(
        isLoading: isLoading ?? this.isLoading,
        currentUserModel: currentUserModel ?? this.currentUserModel,
        isAppleLoading: isAppleLoading ?? this.isAppleLoading,
        isGoogleLoading: isGoogleLoading ?? this.isGoogleLoading,
       
        showPassword: showPassword ?? this.showPassword);
  }

  @override
  List<Object?> get props => [
        isLoading,
        currentUserModel,
        isGoogleLoading,
        isGoogleLoading,
        isAppleLoading,
        showPassword,
      ];
}
