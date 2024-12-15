// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/api/firebase_services.dart' as _i355;
import '../../data/datasource_impl/login_firebase_data_source_impl.dart'
    as _i574;
import '../../data/datasource_impl/register_firebase_data_source_impl.dart'
    as _i644;
import '../../data/date_source_contract/login_data_source.dart' as _i63;
import '../../data/date_source_contract/register_data_source.dart' as _i351;
import '../../data/repo_impl/login_repo_impl.dart' as _i886;
import '../../data/repo_impl/register_repo_impl.dart' as _i357;
import '../../domain/repo_contract/login_repo.dart' as _i496;
import '../../domain/repo_contract/register_repo.dart' as _i513;
import '../../domain/usecases/login_use_case.dart' as _i210;
import '../../domain/usecases/register_use_case.dart' as _i502;
import '../../features/user/presentation/screens/auth/login/viewModel/cubit/login_view_model.dart'
    as _i341;
import '../../features/user/presentation/screens/auth/register/viewModel/cubit/register_view_model.dart'
    as _i662;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i355.FirebaseServices>(() => _i355.FirebaseServices());
    gh.factory<_i63.LoginDataSource>(() => _i574.LoginFirebaseDataSourceImpl(
        firebaseServices: gh<_i355.FirebaseServices>()));
    gh.factory<_i351.RegisterDataSource>(() =>
        _i644.RegisterFirebaseDataSourceImpl(
            firebaseServices: gh<_i355.FirebaseServices>()));
    gh.factory<_i513.RegisterRepo>(() => _i357.RegisterRepoImpl(
        registerDataSource: gh<_i351.RegisterDataSource>()));
    gh.factory<_i496.LoginRepo>(
        () => _i886.LoginRepoImpl(loginDataSource: gh<_i63.LoginDataSource>()));
    gh.factory<_i502.RegisterUseCase>(
        () => _i502.RegisterUseCase(repo: gh<_i513.RegisterRepo>()));
    gh.factory<_i210.LoginUseCase>(
        () => _i210.LoginUseCase(repo: gh<_i496.LoginRepo>()));
    gh.factory<_i662.RegisterViewModel>(
        () => _i662.RegisterViewModel(useCase: gh<_i502.RegisterUseCase>()));
    gh.factory<_i341.LoginViewModel>(
        () => _i341.LoginViewModel(useCase: gh<_i210.LoginUseCase>()));
    return this;
  }
}
