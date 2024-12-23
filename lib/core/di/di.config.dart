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
import '../../data/datasource_impl/room_firebase_data_source_impl.dart' as _i80;
import '../../data/datasource_impl/user_data_source_impl.dart' as _i972;
import '../../data/date_source_contract/login_data_source.dart' as _i63;
import '../../data/date_source_contract/register_data_source.dart' as _i351;
import '../../data/date_source_contract/room_data_source.dart' as _i809;
import '../../data/date_source_contract/user_data_source.dart' as _i1008;
import '../../data/repo_impl/login_repo_impl.dart' as _i886;
import '../../data/repo_impl/register_repo_impl.dart' as _i357;
import '../../data/repo_impl/room_repo_impl.dart' as _i958;
import '../../data/repo_impl/user_repo_impl.dart' as _i89;
import '../../domain/repo_contract/login_repo.dart' as _i496;
import '../../domain/repo_contract/register_repo.dart' as _i513;
import '../../domain/repo_contract/room_repo.dart' as _i716;
import '../../domain/repo_contract/user_repo.dart' as _i999;
import '../../domain/usecases/add_room_to_booking_list_use_case.dart' as _i753;
import '../../domain/usecases/add_room_use_case.dart' as _i914;
import '../../domain/usecases/delete_user_use_case.dart' as _i691;
import '../../domain/usecases/edit_room_use_case.dart' as _i657;
import '../../domain/usecases/get_booking_list_use_case.dart' as _i737;
import '../../domain/usecases/get_rooms_list_use_case.dart' as _i612;
import '../../domain/usecases/get_user_use_case.dart' as _i198;
import '../../domain/usecases/get_users_use_case.dart' as _i668;
import '../../domain/usecases/login_use_case.dart' as _i210;
import '../../domain/usecases/register_use_case.dart' as _i502;
import '../../domain/usecases/update_user_use_case.dart' as _i908;
import '../../features/admin/presentation/screens/add_room_screen/viewModel/cubit/add_room_cubit.dart'
    as _i336;
import '../../features/admin/presentation/screens/edit_room_screen/viewModel/edit_room_cubit.dart'
    as _i704;
import '../../features/admin/presentation/tabs/profile/viewModel/users_cubit.dart'
    as _i922;
import '../../features/admin/presentation/tabs/rooms/viewModel/rooms_list_cubit.dart'
    as _i936;
import '../../features/user/presentation/screens/auth/login/viewModel/cubit/login_view_model.dart'
    as _i341;
import '../../features/user/presentation/screens/auth/register/viewModel/cubit/register_view_model.dart'
    as _i662;
import '../../features/user/presentation/tabs/booking/viewModel/booking_list_cubit.dart'
    as _i483;
import '../../features/user/presentation/tabs/profile/viewModel/user_profile_cubit.dart'
    as _i490;

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
    gh.factory<_i1008.UserDataSource>(() => _i972.DeleteUserDataSourceImpl(
        firebaseServices: gh<_i355.FirebaseServices>()));
    gh.factory<_i809.RoomDataSource>(() => _i80.AddRoomFirebaseDataSourceImpl(
        firebaseServices: gh<_i355.FirebaseServices>()));
    gh.factory<_i63.LoginDataSource>(() => _i574.LoginFirebaseDataSourceImpl(
        firebaseServices: gh<_i355.FirebaseServices>()));
    gh.factory<_i351.RegisterDataSource>(() =>
        _i644.RegisterFirebaseDataSourceImpl(
            firebaseServices: gh<_i355.FirebaseServices>()));
    gh.factory<_i999.UserRepo>(
        () => _i89.UserRepoImpl(dataSource: gh<_i1008.UserDataSource>()));
    gh.factory<_i513.RegisterRepo>(() => _i357.RegisterRepoImpl(
        registerDataSource: gh<_i351.RegisterDataSource>()));
    gh.factory<_i716.RoomRepo>(
        () => _i958.AddRoomRepoImpl(dataSource: gh<_i809.RoomDataSource>()));
    gh.factory<_i496.LoginRepo>(
        () => _i886.LoginRepoImpl(loginDataSource: gh<_i63.LoginDataSource>()));
    gh.factory<_i668.GetUsersUseCase>(
        () => _i668.GetUsersUseCase(repo: gh<_i999.UserRepo>()));
    gh.factory<_i691.DeleteUserUseCase>(
        () => _i691.DeleteUserUseCase(repo: gh<_i999.UserRepo>()));
    gh.factory<_i198.GetUserUseCase>(
        () => _i198.GetUserUseCase(repo: gh<_i999.UserRepo>()));
    gh.factory<_i908.UpdateUserUseCase>(
        () => _i908.UpdateUserUseCase(repo: gh<_i999.UserRepo>()));
    gh.factory<_i914.AddRoomUseCase>(
        () => _i914.AddRoomUseCase(repo: gh<_i716.RoomRepo>()));
    gh.factory<_i612.GetRoomsListUseCase>(
        () => _i612.GetRoomsListUseCase(repo: gh<_i716.RoomRepo>()));
    gh.factory<_i657.EditRoomUseCase>(
        () => _i657.EditRoomUseCase(repo: gh<_i716.RoomRepo>()));
    gh.factory<_i753.AddRoomToBookingListUseCase>(
        () => _i753.AddRoomToBookingListUseCase(repo: gh<_i716.RoomRepo>()));
    gh.factory<_i737.GetBookingListUseCase>(
        () => _i737.GetBookingListUseCase(repo: gh<_i716.RoomRepo>()));
    gh.factory<_i922.UsersCubit>(() => _i922.UsersCubit(
          useCase: gh<_i668.GetUsersUseCase>(),
          deleteUserUseCase: gh<_i691.DeleteUserUseCase>(),
        ));
    gh.factory<_i336.AddRoomCubit>(
        () => _i336.AddRoomCubit(useCase: gh<_i914.AddRoomUseCase>()));
    gh.factory<_i936.RoomsListCubit>(
        () => _i936.RoomsListCubit(useCase: gh<_i612.GetRoomsListUseCase>()));
    gh.factory<_i490.UserProfileCubit>(
        () => _i490.UserProfileCubit(useCase: gh<_i908.UpdateUserUseCase>()));
    gh.factory<_i502.RegisterUseCase>(
        () => _i502.RegisterUseCase(repo: gh<_i513.RegisterRepo>()));
    gh.factory<_i210.LoginUseCase>(
        () => _i210.LoginUseCase(repo: gh<_i496.LoginRepo>()));
    gh.factory<_i662.RegisterViewModel>(
        () => _i662.RegisterViewModel(useCase: gh<_i502.RegisterUseCase>()));
    gh.factory<_i341.LoginViewModel>(
        () => _i341.LoginViewModel(useCase: gh<_i210.LoginUseCase>()));
    gh.factory<_i704.EditRoomCubit>(
        () => _i704.EditRoomCubit(useCase: gh<_i657.EditRoomUseCase>()));
    gh.factory<_i483.BookingListCubit>(() => _i483.BookingListCubit(
          addRoomToBookingListUseCase: gh<_i753.AddRoomToBookingListUseCase>(),
          getBookingListUseCase: gh<_i737.GetBookingListUseCase>(),
        ));
    return this;
  }
}
