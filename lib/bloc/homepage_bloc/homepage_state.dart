part of 'homepage_bloc.dart';

class HomepageState extends Equatable {
  final bool backgroundRemoved;
  final bool loadingRemovedBg;
  final XFile? pickedImage;
  final double opacity;
  final Uint8List? response;
  const HomepageState({
    this.response,
    this.loadingRemovedBg = false,
    this.backgroundRemoved = false,
    this.opacity = 0.5,
    this.pickedImage,
  });

  HomepageState changeImageState({XFile? pickedImage}) {
    return HomepageState(pickedImage: pickedImage);
  }

  HomepageState copyWith(
      {double? opacity,
      Uint8List? response,
      bool? loadingRemovedBg,
      bool? backgroundRemoved,
      XFile? pickedImage}) {
    return HomepageState(
      pickedImage: pickedImage ?? this.pickedImage,
      backgroundRemoved: backgroundRemoved ?? this.backgroundRemoved,
      loadingRemovedBg: loadingRemovedBg ?? this.loadingRemovedBg,
      response: response ?? this.response,
      opacity: opacity ?? this.opacity,
    );
  }

  @override
  List<Object?> get props =>
      [backgroundRemoved, pickedImage, opacity, response, loadingRemovedBg];
}
