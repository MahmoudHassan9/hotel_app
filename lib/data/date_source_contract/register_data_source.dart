abstract class RegisterDataSource {
  Future<void> register(
      {required String email,
      required String password,
      required String name,
      required String phoneNumber});

}
