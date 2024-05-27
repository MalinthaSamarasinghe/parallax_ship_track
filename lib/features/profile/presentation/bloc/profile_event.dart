part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

/// UpdateName
class UpdateNameChanged extends ProfileEvent {
  final String name;

  const UpdateNameChanged({required this.name});

  @override
  List<Object> get props => [name];
}

/// UpdateEmail
class UpdateEmailChanged extends ProfileEvent {
  final String email;

  const UpdateEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

/// UpdateProfileImg
class UpdateProfileImgChanged extends ProfileEvent {
  final String profileImg;

  const UpdateProfileImgChanged({required this.profileImg});

  @override
  List<Object> get props => [profileImg];
}
