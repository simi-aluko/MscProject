import 'package:csv/csv.dart';
import 'package:get_it/get_it.dart';
import 'package:msc_project/bloc/scuba_tx_bloc.dart';
import 'package:msc_project/scuba_tx_usecase.dart';

final sl = GetIt.instance;

init() async {
  sl.registerFactory(() => ScubaTxBloc(scubaTxBoxUseCase: sl()));

  sl.registerLazySingleton(() => ScubaTxBoxUseCase(sl()));

  final csvAsList = await ReadCSV(csvToListConverter: sl()).readCSV();
  sl.registerLazySingleton(() => csvAsList);

  sl.registerLazySingleton(() => const CsvToListConverter());
}
