import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:product/product.dart';
import 'package:product/src/feature/domain/usecases/get_example_data_usecase.dart';
import 'package:product/src/feature/domain/entities/example_entity.dart';

// Mock classes
class MockGetExampleDataUseCase extends Mock
    implements GetExampleDataUseCase {}

void main() {
  group('ProductBloc', () {
    late ProductBloc bloc;
    late MockGetExampleDataUseCase mockGetExampleDataUseCase;

    // Sample test data
    final testEntity = ExampleEntity(
      id: '1',
      name: 'Test Name',
      description: 'Test Description',
      createdAt: DateTime.now(),
    );

    setUp(() {
      // Initialize mocks
      mockGetExampleDataUseCase = MockGetExampleDataUseCase();

      // Create bloc with mocked dependencies
      bloc = ProductBloc(
        getExampleDataUseCase: mockGetExampleDataUseCase,
      );

      // Register fallback values for Mocktail
      registerFallbackValue(const GetExampleDataParams(id: ''));
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is ProductStateInitial', () {
      expect(bloc.state, const ProductState.initial());
    });

    group('LoadData', () {
      blocTest<ProductBloc, ProductState>(
        'emits [loading, loaded] when data is loaded successfully',
        build: () {
          // Mock successful response
          when(() => mockGetExampleDataUseCase(any()))
              .thenAnswer((_) async => Right(testEntity));
          return bloc;
        },
        act: (bloc) => bloc.add(const ProductEvent.loadData(id: '1')),
        expect: () => [
          const ProductState.loading(),
          ProductState.loaded(testEntity),
        ],
        verify: (_) {
          // Verify use case was called with correct params
          verify(
            () => mockGetExampleDataUseCase(
              const GetExampleDataParams(id: '1'),
            ),
          ).called(1);
        },
      );

      blocTest<ProductBloc, ProductState>(
        'emits [loading, error] when data loading fails',
        build: () {
          // Mock failure response
          when(() => mockGetExampleDataUseCase(any())).thenAnswer(
            (_) async => const Left(
              ServerFailure(
                message: 'Server error',
                code: 'SERVER_ERROR',
              ),
            ),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(const ProductEvent.loadData(id: '1')),
        expect: () => [
          const ProductState.loading(),
          const ProductState.error('Server error'),
        ],
      );

      blocTest<ProductBloc, ProductState>(
        'emits [loading, error] when validation fails',
        build: () {
          // Mock validation failure
          when(() => mockGetExampleDataUseCase(any())).thenAnswer(
            (_) async => const Left(
              ValidationFailure(
                message: 'ID cannot be empty',
                code: 'INVALID_ID',
              ),
            ),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(const ProductEvent.loadData(id: '')),
        expect: () => [
          const ProductState.loading(),
          const ProductState.error('ID cannot be empty'),
        ],
      );
    });
  });
}
