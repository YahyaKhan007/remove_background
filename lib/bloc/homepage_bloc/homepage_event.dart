part of 'homepage_bloc.dart';

sealed class HomepageEvent extends Equatable {
  const HomepageEvent();

  @override
  List<Object> get props => [];
}

class RemoveBackground extends HomepageEvent {
  final bool backgroundRemoved;
  const RemoveBackground({required this.backgroundRemoved});
}

class SelectedPhotoEvent extends HomepageEvent {
  const SelectedPhotoEvent();
}

class RemovePhotoEvent extends HomepageEvent {
  const RemovePhotoEvent();
}

class GlowEffectEvent extends HomepageEvent {
  const GlowEffectEvent();
}

class RemovedBackgroundSuccessfull extends HomepageEvent {
  final Uint8List response;
  const RemovedBackgroundSuccessfull({required this.response});
}

class ChangeLoading extends HomepageEvent {
  final bool isLoading;
  const ChangeLoading(this.isLoading);
}

class UpdateRemoveBackgroundsList extends HomepageEvent {
  final List<String> removedBgs;
  const UpdateRemoveBackgroundsList({required this.removedBgs});
}
