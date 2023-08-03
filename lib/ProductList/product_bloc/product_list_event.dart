part of 'product_list_bloc.dart';
@immutable
abstract class ProductEvent {}

class ProductInitialEvent extends ProductEvent{}
class LogoutClickEvent extends ProductEvent{}
class FollowClickEvent extends ProductEvent{}
class MessageClickEvent extends ProductEvent{}
class PhotosClickEvent extends ProductEvent{}
class VideosClickEvent extends ProductEvent{}
class FollowerClickEvent extends ProductEvent{}
class FollowingClickEvent extends ProductEvent{}
class HighlightsClickEvent extends ProductEvent{
  String? url;
  HighlightsClickEvent(this.url);
}
class AddHighlightsClickEvent extends ProductEvent{}