part of 'map_building_details_cubit.dart';

@immutable
abstract class MapBuildingDetailsState {}

class MapBuildingDetailsInitialState extends MapBuildingDetailsState {}

class MapBuildingDetailsLoadingState extends MapBuildingDetailsState {}

class MapBuildingDetailsFetchedState extends MapBuildingDetailsState {
  final FloorInstallation floorInstallation;

  MapBuildingDetailsFetchedState(this.floorInstallation);
}

class MapBuildingDetailsErrorState extends MapBuildingDetailsState {
  final String error;

  MapBuildingDetailsErrorState(this.error);
}
