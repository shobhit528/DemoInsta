part of 'profile_bloc.dart';

abstract class ProfileState {}

abstract class ProfileActionState extends ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadSuccessState extends ProfileState {
  final List<Item> list;
  final List<highLightClass> heighLightlist;
  ProfileLoadSuccessState(this.list,  this.heighLightlist);
}

class ProfileErrorState extends ProfileState {}

class ProfileLogoutNavigateState extends ProfileActionState {}

class ProfileFollowNavigateState extends ProfileActionState {}

class ProfileMessageNavigateState extends ProfileActionState {}
