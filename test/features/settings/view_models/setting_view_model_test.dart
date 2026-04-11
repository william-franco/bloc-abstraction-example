import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_abstraction_example/src/features/settings/models/setting_model.dart';
import 'package:bloc_abstraction_example/src/features/settings/view_models/setting_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../setting_mocks.mocks.dart';

void main() {
  group('SettingViewModel Test', () {
    late MockSettingRepository mockSettingRepository;

    setUpAll(() {
      provideDummy<SettingModel>(SettingModel());
    });

    setUp(() {
      mockSettingRepository = MockSettingRepository();
    });

    // ---------------------------------------------------------------------------
    // Initial state
    // ---------------------------------------------------------------------------

    test('should start with a default SettingModel (isDarkTheme false)', () {
      final viewModel = SettingViewModelImpl(
        settingRepository: mockSettingRepository,
      );
      expect(viewModel.state, isA<SettingModel>());
      expect(viewModel.state.isDarkTheme, isFalse);
      viewModel.close();
    });

    // ---------------------------------------------------------------------------
    // getTheme
    // ---------------------------------------------------------------------------

    group('getTheme', () {
      blocTest<SettingViewModelImpl, SettingModel>(
        'should emit SettingModel with isDarkTheme true '
        'when repository returns isDarkTheme true',
        setUp: () {
          when(
            mockSettingRepository.readTheme(),
          ).thenAnswer((_) async => SettingModel(isDarkTheme: true));
        },
        build: () =>
            SettingViewModelImpl(settingRepository: mockSettingRepository),
        act: (vm) => vm.getTheme(),
        expect: () => [
          isA<SettingModel>().having(
            (s) => s.isDarkTheme,
            'isDarkTheme',
            isTrue,
          ),
        ],
        verify: (vm) => verify(mockSettingRepository.readTheme()).called(1),
      );

      blocTest<SettingViewModelImpl, SettingModel>(
        'should emit SettingModel with isDarkTheme false '
        'when repository returns isDarkTheme false',
        setUp: () {
          when(
            mockSettingRepository.readTheme(),
          ).thenAnswer((_) async => SettingModel(isDarkTheme: false));
        },
        build: () =>
            SettingViewModelImpl(settingRepository: mockSettingRepository),
        act: (vm) => vm.getTheme(),
        expect: () => [
          isA<SettingModel>().having(
            (s) => s.isDarkTheme,
            'isDarkTheme',
            isFalse,
          ),
        ],
      );

      blocTest<SettingViewModelImpl, SettingModel>(
        'should emit exactly one state when getTheme completes',
        setUp: () {
          when(
            mockSettingRepository.readTheme(),
          ).thenAnswer((_) async => SettingModel(isDarkTheme: true));
        },
        build: () =>
            SettingViewModelImpl(settingRepository: mockSettingRepository),
        act: (vm) => vm.getTheme(),
        expect: () => [isA<SettingModel>()],
      );

      blocTest<SettingViewModelImpl, SettingModel>(
        'should propagate exception thrown by repository',
        setUp: () {
          when(
            mockSettingRepository.readTheme(),
          ).thenThrow(Exception('SettingRepository: Storage failure'));
        },
        build: () =>
            SettingViewModelImpl(settingRepository: mockSettingRepository),
        act: (vm) => vm.getTheme(),
        errors: () => [isA<Exception>()],
      );
    });

    // ---------------------------------------------------------------------------
    // changeTheme
    // ---------------------------------------------------------------------------

    group('changeTheme', () {
      blocTest<SettingViewModelImpl, SettingModel>(
        'should emit SettingModel with isDarkTheme true '
        'and call repository.updateTheme with true',
        setUp: () {
          when(
            mockSettingRepository.updateTheme(
              isDarkTheme: anyNamed('isDarkTheme'),
            ),
          ).thenAnswer((_) async {});
        },
        build: () =>
            SettingViewModelImpl(settingRepository: mockSettingRepository),
        act: (vm) => vm.changeTheme(isDarkTheme: true),
        expect: () => [
          isA<SettingModel>().having(
            (s) => s.isDarkTheme,
            'isDarkTheme',
            isTrue,
          ),
        ],
        verify: (vm) =>
            verify(mockSettingRepository.updateTheme(isDarkTheme: true))
                .called(1),
      );

      blocTest<SettingViewModelImpl, SettingModel>(
        'should emit SettingModel with isDarkTheme false '
        'and call repository.updateTheme with false',
        setUp: () {
          when(
            mockSettingRepository.updateTheme(
              isDarkTheme: anyNamed('isDarkTheme'),
            ),
          ).thenAnswer((_) async {});
        },
        build: () =>
            SettingViewModelImpl(settingRepository: mockSettingRepository),
        act: (vm) => vm.changeTheme(isDarkTheme: false),
        expect: () => [
          isA<SettingModel>().having(
            (s) => s.isDarkTheme,
            'isDarkTheme',
            isFalse,
          ),
        ],
        verify: (vm) =>
            verify(mockSettingRepository.updateTheme(isDarkTheme: false))
                .called(1),
      );

      blocTest<SettingViewModelImpl, SettingModel>(
        'should preserve other SettingModel fields when toggling theme '
        'via copyWith',
        setUp: () {
          when(
            mockSettingRepository.readTheme(),
          ).thenAnswer((_) async => SettingModel(isDarkTheme: false));
          when(
            mockSettingRepository.updateTheme(
              isDarkTheme: anyNamed('isDarkTheme'),
            ),
          ).thenAnswer((_) async {});
        },
        build: () =>
            SettingViewModelImpl(settingRepository: mockSettingRepository),
        act: (vm) async {
          await vm.getTheme();
          await vm.changeTheme(isDarkTheme: true);
        },
        expect: () => [
          isA<SettingModel>().having(
            (s) => s.isDarkTheme,
            'isDarkTheme',
            isFalse,
          ),
          isA<SettingModel>().having(
            (s) => s.isDarkTheme,
            'isDarkTheme',
            isTrue,
          ),
        ],
      );

      blocTest<SettingViewModelImpl, SettingModel>(
        'should emit exactly one state per changeTheme call',
        setUp: () {
          when(
            mockSettingRepository.updateTheme(
              isDarkTheme: anyNamed('isDarkTheme'),
            ),
          ).thenAnswer((_) async {});
        },
        build: () =>
            SettingViewModelImpl(settingRepository: mockSettingRepository),
        act: (vm) => vm.changeTheme(isDarkTheme: true),
        expect: () => [isA<SettingModel>()],
      );

      blocTest<SettingViewModelImpl, SettingModel>(
        'should not emit new state when repository.updateTheme throws',
        setUp: () {
          when(
            mockSettingRepository.updateTheme(
              isDarkTheme: anyNamed('isDarkTheme'),
            ),
          ).thenThrow(Exception('Write failure'));
        },
        build: () =>
            SettingViewModelImpl(settingRepository: mockSettingRepository),
        act: (vm) => vm.changeTheme(isDarkTheme: true),
        expect: () => [],
        errors: () => [isA<Exception>()],
      );

      blocTest<SettingViewModelImpl, SettingModel>(
        'should reflect correct state after multiple sequential changeTheme calls',
        setUp: () {
          when(
            mockSettingRepository.updateTheme(
              isDarkTheme: anyNamed('isDarkTheme'),
            ),
          ).thenAnswer((_) async {});
        },
        build: () =>
            SettingViewModelImpl(settingRepository: mockSettingRepository),
        act: (vm) async {
          await vm.changeTheme(isDarkTheme: true);
          await vm.changeTheme(isDarkTheme: false);
        },
        expect: () => [
          isA<SettingModel>().having(
            (s) => s.isDarkTheme,
            'isDarkTheme',
            isTrue,
          ),
          isA<SettingModel>().having(
            (s) => s.isDarkTheme,
            'isDarkTheme',
            isFalse,
          ),
        ],
        verify: (vm) => verify(
          mockSettingRepository.updateTheme(
            isDarkTheme: anyNamed('isDarkTheme'),
          ),
        ).called(2),
      );
    });
  });
}
