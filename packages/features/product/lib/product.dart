library product;

// Core exports
export 'src/core/di/injection.dart';
export 'src/core/route/product_router.dart';
export 'src/core/route/product_routes.dart';
export 'src/core/errors/failures.dart';

// Domain exports - Entities
export 'src/feature/domain/entities/example_entity.dart';

// Domain exports - Repositories
export 'src/feature/domain/repositories/example_repository.dart';

// Domain exports - Use Cases
export 'src/feature/domain/usecases/get_example_data_usecase.dart';

// Presentation exports - BLoC
export 'src/feature/presentation/bloc/product_bloc.dart';

// Presentation exports - Pages
export 'src/feature/presentation/pages/product_page.dart';
