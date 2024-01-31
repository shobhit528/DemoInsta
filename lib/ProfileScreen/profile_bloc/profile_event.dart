part of 'profile_bloc.dart';
@immutable
abstract class ProfileEvent {}

class ProfileInitialEvent extends ProfileEvent{}
class LogoutClickEvent extends ProfileEvent{}
class FollowClickEvent extends ProfileEvent{}
class MessageClickEvent extends ProfileEvent{}
class PhotosClickEvent extends ProfileEvent{}
class VideosClickEvent extends ProfileEvent{}
class FollowerClickEvent extends ProfileEvent{}
class FollowingClickEvent extends ProfileEvent{}

class HighlightsClickEvent extends ProfileEvent{
  String? url;
  HighlightsClickEvent(this.url);
}
class AddHighlightsClickEvent extends ProfileEvent{}