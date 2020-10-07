// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/third_party_services.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<DialogService>(() => registerModule.dialogService);
  gh.lazySingleton<NavigationService>(() => registerModule.navigationService);
  return get;
}

class _$RegisterModule extends RegisterModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
}
