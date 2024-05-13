// ignore_for_file: must_be_immutable

part of 'homepage_bloc.dart';

class HomepageState extends Equatable {
  final bool backgroundRemoved;
  final bool loadingRemovedBg;
  final XFile? pickedImage;
  final File? compressedImage;
  final double opacity;
  final Uint8List? response;
  List<String> removedBgs;

  HomepageState({
    this.response,
    this.loadingRemovedBg = false,
    this.backgroundRemoved = false,
    this.opacity = 0.5,
    this.pickedImage,
    this.compressedImage,
    required this.removedBgs,
  });

  HomepageState changeImageState({
    XFile? pickedImage,
    List<String>? removedBgs,
  }) {
    return HomepageState(
      pickedImage: pickedImage,
      removedBgs: removedBgs ?? this.removedBgs,
    );
  }

  HomepageState copyWith({
    double? opacity,
    Uint8List? response,
    bool? loadingRemovedBg,
    bool? backgroundRemoved,
    List<String>? removedBgs,
    XFile? pickedImage,
    File? compressedImage,
  }) {
    return HomepageState(
      pickedImage: pickedImage ?? this.pickedImage,
      compressedImage: compressedImage ?? this.compressedImage,
      backgroundRemoved: backgroundRemoved ?? this.backgroundRemoved,
      loadingRemovedBg: loadingRemovedBg ?? this.loadingRemovedBg,
      response: response ?? this.response,
      opacity: opacity ?? this.opacity,
      removedBgs: removedBgs ?? this.removedBgs,
    );
  }

  @override
  List<Object?> get props => [
        backgroundRemoved,
        pickedImage,
        compressedImage,
        opacity,
        response,
        loadingRemovedBg,
        removedBgs
      ];
}
