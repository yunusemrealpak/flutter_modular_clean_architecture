import 'package:core/core.dart';

import '../../domain/usecases/get_example_data_usecase.dart';
import '../../domain/entities/example_entity.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

/// BLoC for product feature
/// Manages state and handles business logic through use cases
@lazySingleton
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  // Inject use cases
  final GetExampleDataUseCase getExampleDataUseCase;

  ProductBloc({
    required this.getExampleDataUseCase,
  }) : super(const ProductState.initial()) {
    // Register event handlers
    on<ProductEventLoadData>(_onLoadData);
  }

  /// Handle load data event
  Future<void> _onLoadData(
    ProductEventLoadData event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductState.loading());

    // Call use case with parameters
    final params = GetExampleDataParams(id: event.id);
    final result = await getExampleDataUseCase(params);

    // Handle result
    result.fold(
      (failure) {
        // Emit error state on failure
        emit(ProductState.error(failure.message));
      },
      (entity) {
        // Emit success state with data
        emit(ProductState.loaded(entity));
      },
    );
  }
}
