import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_abstraction_example/src/common/patterns/app_state_pattern.dart';
import 'package:bloc_abstraction_example/src/common/patterns/result_pattern.dart';
import 'package:bloc_abstraction_example/src/features/users/exceptions/user_exception.dart';
import 'package:bloc_abstraction_example/src/features/users/models/user_model.dart';
import 'package:bloc_abstraction_example/src/features/users/repositories/user_repository.dart';
import 'package:bloc_abstraction_example/src/features/users/view_models/user_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../user_mocks.mocks.dart';

void main() {
  group('UserViewModel Test', () {
    late MockUserRepository mockUserRepository;

    // Dummy values required by mockito for sealed/generic return types
    final dummySuccess = SuccessResult<List<UserModel>, UserException>(value: []);
    final dummyError = ErrorResult<List<UserModel>, UserException>(
      error: UserException('dummy'),
    );

    final tUsers = [
      UserModel(
        id: 1,
        name: 'Leanne Graham',
        username: 'Bret',
        email: 'Sincere@april.biz',
        phone: '1-770-736-0860',
        website: 'hildegard.org',
        address: Address(
          street: 'Kulas Light',
          suite: 'Apt. 556',
          city: 'Gwenborough',
          zipcode: '92998-3874',
          geo: Geo(lat: '-37.3159', lng: '81.1496'),
        ),
        company: Company(
          name: 'Romaguera-Crona',
          catchPhrase: 'Multi-layered client-server neural-net',
          bs: 'harness real-time e-markets',
        ),
      ),
    ];

    setUpAll(() {
      provideDummy<UserResult>(dummySuccess);
      provideDummy<UserResult>(dummyError);
    });

    setUp(() {
      mockUserRepository = MockUserRepository();
    });

    // ---------------------------------------------------------------------------
    // Initial state
    // ---------------------------------------------------------------------------

    test('should start with InitialState', () {
      final viewModel = UserViewModelImpl(userRepository: mockUserRepository);
      expect(
        viewModel.state,
        isA<InitialState<List<UserModel>, UserException>>(),
      );
      viewModel.close();
    });

    // ---------------------------------------------------------------------------
    // getAllUsers
    // ---------------------------------------------------------------------------

    group('getAllUsers', () {
      blocTest<UserViewModelImpl, UsersState>(
        'should emit [LoadingState, SuccessState] '
        'when repository returns SuccessResult',
        setUp: () {
          when(
            mockUserRepository.findAllUsers(),
          ).thenAnswer((_) async => SuccessResult(value: tUsers));
        },
        build: () => UserViewModelImpl(userRepository: mockUserRepository),
        act: (vm) => vm.getAllUsers(),
        expect: () => [
          isA<LoadingState<List<UserModel>, UserException>>(),
          isA<SuccessState<List<UserModel>, UserException>>()
              .having((s) => s.data, 'data', equals(tUsers))
              .having(
                (s) => s.data.first.name,
                'first name',
                equals(tUsers.first.name),
              ),
        ],
        verify: (vm) => verify(mockUserRepository.findAllUsers()).called(1),
      );

      blocTest<UserViewModelImpl, UsersState>(
        'should emit [LoadingState, ErrorState] '
        'when repository returns ErrorResult',
        setUp: () {
          when(mockUserRepository.findAllUsers()).thenAnswer(
            (_) async =>
                ErrorResult(error: UserException('Device not connected.')),
          );
        },
        build: () => UserViewModelImpl(userRepository: mockUserRepository),
        act: (vm) => vm.getAllUsers(),
        expect: () => [
          isA<LoadingState<List<UserModel>, UserException>>(),
          isA<ErrorState<List<UserModel>, UserException>>().having(
            (s) => s.error.message,
            'error message',
            contains('Device not connected.'),
          ),
        ],
      );

      blocTest<UserViewModelImpl, UsersState>(
        'should emit SuccessState with empty list '
        'when repository returns an empty SuccessResult',
        setUp: () {
          when(
            mockUserRepository.findAllUsers(),
          ).thenAnswer((_) async => SuccessResult(value: <UserModel>[]));
        },
        build: () => UserViewModelImpl(userRepository: mockUserRepository),
        act: (vm) => vm.getAllUsers(),
        expect: () => [
          isA<LoadingState<List<UserModel>, UserException>>(),
          isA<SuccessState<List<UserModel>, UserException>>().having(
            (s) => s.data,
            'data',
            isEmpty,
          ),
        ],
      );

      blocTest<UserViewModelImpl, UsersState>(
        'should emit exactly two states (LoadingState then final state)',
        setUp: () {
          when(
            mockUserRepository.findAllUsers(),
          ).thenAnswer((_) async => SuccessResult(value: tUsers));
        },
        build: () => UserViewModelImpl(userRepository: mockUserRepository),
        act: (vm) => vm.getAllUsers(),
        expect: () => [
          isA<LoadingState<List<UserModel>, UserException>>(),
          isA<SuccessState<List<UserModel>, UserException>>(),
        ],
      );

      blocTest<UserViewModelImpl, UsersState>(
        'should have LoadingState while repository call is in progress',
        build: () => UserViewModelImpl(userRepository: mockUserRepository),
        act: (vm) async {
          UsersState? stateWhileLoading;
          when(mockUserRepository.findAllUsers()).thenAnswer((_) async {
            stateWhileLoading = vm.state;
            return SuccessResult(value: tUsers);
          });
          await vm.getAllUsers();
          expect(
            stateWhileLoading,
            isA<LoadingState<List<UserModel>, UserException>>(),
          );
        },
        expect: () => [
          isA<LoadingState<List<UserModel>, UserException>>(),
          isA<SuccessState<List<UserModel>, UserException>>(),
        ],
      );

      blocTest<UserViewModelImpl, UsersState>(
        'should reset to LoadingState on each new getAllUsers call',
        setUp: () {
          when(
            mockUserRepository.findAllUsers(),
          ).thenAnswer((_) async => SuccessResult(value: tUsers));
        },
        build: () => UserViewModelImpl(userRepository: mockUserRepository),
        act: (vm) async {
          await vm.getAllUsers();
          when(mockUserRepository.findAllUsers()).thenAnswer(
            (_) async => ErrorResult(error: UserException('Server error')),
          );
          await vm.getAllUsers();
        },
        expect: () => [
          isA<LoadingState<List<UserModel>, UserException>>(),
          isA<SuccessState<List<UserModel>, UserException>>(),
          isA<LoadingState<List<UserModel>, UserException>>(),
          isA<ErrorState<List<UserModel>, UserException>>(),
        ],
        verify: (vm) => verify(mockUserRepository.findAllUsers()).called(2),
      );
    });
  });
}
