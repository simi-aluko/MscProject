import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:msc_project/data/data_sources/csv_data_source.dart';
import 'package:msc_project/domain/scuba_repository.dart';
import '../data/data_sources/data_source.dart';
import '../data/repository/concr_scuba_repository.dart';
import '../ui/bloc/scuba_tx_bloc.dart';

final sl = GetIt.instance;

init() async {
  sl.registerFactory(() => OrgansListBloc(scubaRepository: sl()));
  sl.registerFactory(() => CurrentOrganBloc(scubaRepository: sl()));
  sl.registerFactory(() => CurrentChannelBloc());
  sl.registerFactory(() => SmartAuditGraphBloc());
  sl.registerFactory(() => SmartAuditEventListBloc(scubaRepository: sl()));
  sl.registerFactory<ScubaDataSource>(() => CSVDataSource(csvAsList: sl()));
  sl.registerFactory<ScubaRepository>(() => ScubaRepositoryImpl(scubaDataSource: sl()));

  sl.registerLazySingleton(() => const CsvToListConverter());

  final myData = await rootBundle.loadString('assets/files/test_data.csv');
  final csvAsList = sl<CsvToListConverter>().convert(myData, eol: "\n");
  sl.registerLazySingleton(() => csvAsList);
}


