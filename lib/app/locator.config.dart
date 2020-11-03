// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/authentication_service.dart';
import '../services/cloud_storage_service.dart';
import '../services/firestore_services.dart';
import '../utils/image_selector.dart';
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
  gh.lazySingleton<AuthenticationService>(() => AuthenticationService());
  gh.lazySingleton<CloudStorageService>(() => CloudStorageService());
  gh.lazySingleton<DialogService>(() => registerModule.dialogService);
  gh.lazySingleton<FirestoreService>(() => FirestoreService());
  gh.lazySingleton<ImageSelector>(() => ImageSelector());
  gh.lazySingleton<NavigationService>(() => registerModule.navigationService);
  return get;
}

class _$RegisterModule extends RegisterModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
}
