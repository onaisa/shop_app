part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class GetProfileLodingState extends ProfileState {}

class GetProfileSucsessState extends ProfileState {}

class GetProfileErorrState extends ProfileState {}

class UpdateProfileLodingState extends ProfileState {}

class UpdateProfileSucsessState extends ProfileState {
  final Profilmodel profilmodel;
  UpdateProfileSucsessState(this.profilmodel);
}

class UpdateProfileErorrState extends ProfileState {
  final error;
  UpdateProfileErorrState(this.error);
}
