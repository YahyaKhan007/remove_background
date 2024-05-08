import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../../views/utils/image_picker.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final ImagePickerUtils imagePickerUtils;
  HomepageBloc({required this.imagePickerUtils})
      : super(HomepageState(removedBgs: const [])) {
    on<RemoveBackground>(_removeBackgroundEvent);
    on<SelectedPhotoEvent>(_selectedPhotoEvent);
    on<RemovePhotoEvent>(_removePhotoEvent);
    on<GlowEffectEvent>(_glowEffectEvent);
    on<RemovedBackgroundSuccessfull>(_saveApiOutputResponse);
    on<ChangeLoading>(_changeLoading);
    on<UpdateRemoveBackgroundsList>(_updateRemovedBackgroundList);
  }

  void _removeBackgroundEvent(
      RemoveBackground event, Emitter<HomepageState> emit) async {
    // final pickedImage = await imagePickerUtils.pickImageFromGallery();
    // if (pickedImage != null) {

    emit(state.changeImageState(pickedImage: state.pickedImage));
    // }

    log('Selected Photo : ${state.backgroundRemoved}');
  }

  void _changeLoading(ChangeLoading event, Emitter<HomepageState> emit) async {
    emit(state.copyWith(loadingRemovedBg: event.isLoading));

    log('loading : ${state.loadingRemovedBg}');
  }

  void _selectedPhotoEvent(
      SelectedPhotoEvent event, Emitter<HomepageState> emit) async {
    final pickedImage = await imagePickerUtils.pickImageFromGallery();
    if (pickedImage != null) {
      emit(state.changeImageState(pickedImage: pickedImage));
      log('image has been Selected');
    }
  }

  void _removePhotoEvent(
      RemovePhotoEvent event, Emitter<HomepageState> emit) async {
    log("photo has been removed");
    emit(state.copyWith(
      backgroundRemoved: false,
    ));
    emit(state.changeImageState(
      pickedImage: null,
    ));
    emit(state.copyWith(
        loadingRemovedBg: false, backgroundRemoved: false, pickedImage: null));
  }

  void _glowEffectEvent(GlowEffectEvent event, Emitter<HomepageState> emit) {
    Timer.periodic(
      const Duration(milliseconds: 1000),
      (timer) {
        emit(state.copyWith(opacity: timer.tick.toDouble() / 100));
      },
    );
  }

  void _saveApiOutputResponse(
      RemovedBackgroundSuccessfull event, Emitter<HomepageState> emit) {
    emit(state.copyWith(
        response: event.response,
        loadingRemovedBg: false,
        backgroundRemoved: true));
  }

  void _updateRemovedBackgroundList(
      UpdateRemoveBackgroundsList event, Emitter<HomepageState> emit) {
    emit(state.copyWith(removedBgs: event.removedBgs));
  }
}
