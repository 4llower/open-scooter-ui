import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_scooter_ui/feature/domain/usecases/get_all_scooters.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/scooter_cubit/scooter_state.dart';

class ScooterCubit extends Cubit<ScooterState> {
  final GetAllScooters getAllScooters;

  ScooterCubit({required this.getAllScooters}) : super(ScooterEmpty());

  void loadScooters() async {
    if (state is ScooterLoading) return;

    emit(ScooterLoading());

    final failureOrScooter = await getAllScooters(GetAllScooterParams());

    failureOrScooter.fold(
        (_) =>
            throw UnimplementedError('[Failure] ScooterCubit getAllScooters'),
        (resp) => emit(ScooterLoaded(scooterList: resp)));
  }
}