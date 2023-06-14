import 'package:bloc/bloc.dart';
import 'package:iss_assignment/features/map_building_details/domain/data/models/floor_Installation.dart';
import 'package:iss_assignment/features/map_building_details/domain/data/models/floor_installation_request.dart';
import 'package:meta/meta.dart';

import '../../../domain/repository/floor_installation_repository.dart';

part 'map_building_details_state.dart';

class MapBuildingDetailsCubit extends Cubit<MapBuildingDetailsState> {
  final IFloorInstallationRepository floorInstallationRepository;

  MapBuildingDetailsCubit(this.floorInstallationRepository)
      : super(MapBuildingDetailsInitialState());

  Future<void> fetchFloorInstallationData(String floorId) async {
    emit(MapBuildingDetailsLoadingState());

    try {
      FloorInstallation data =
          await floorInstallationRepository.getFloorInstallationWith(floorId);
      emit(MapBuildingDetailsFetchedState(data));
    } catch (error) {
      emit(MapBuildingDetailsErrorState('Error: $error'));
    }
  }

  Future<void> postFloorInstallation(
      String floorId, int confirmedIncrement) async {
    emit(MapBuildingDetailsLoadingState());

    FloorInstallationRequest request =
        FloorInstallationRequest(newConfrimedInstallations: confirmedIncrement);
    try {
      FloorInstallation data = await floorInstallationRepository
          .postFloorInstallationWith(floorId, request);
      emit(MapBuildingDetailsFetchedState(data));
    } catch (error) {
      emit(MapBuildingDetailsErrorState('Error: $error'));
    }
  }
}
