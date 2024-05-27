part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, success, failure }

final class ProfileState extends Equatable {
  final ProfileStatus profileStatus;
  final firebase_auth.User? user;
  final String? errorMessage;

  const ProfileState({
    this.profileStatus = ProfileStatus.initial,
    this.user,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        profileStatus,
        user,
        errorMessage,
      ];

  ProfileState copyWith({
    ProfileStatus? profileStatus,
    firebase_auth.User? user,
    String? errorMessage,
  }) {
    return ProfileState(
      profileStatus: profileStatus ?? this.profileStatus,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
