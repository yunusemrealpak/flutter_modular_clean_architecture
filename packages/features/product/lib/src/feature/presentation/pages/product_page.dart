import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';

import '../bloc/product_bloc.dart';

/// Main page for product feature
/// Demonstrates BLoC integration and state management
@RoutePage()
class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    // Load data when page initializes
    // Example: Load data with ID "1"
    context.read<ProductBloc>().add(
          const ProductEvent.loadData(id: '1'),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'.replaceAll('_', ' ')),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Reload data
              context.read<ProductBloc>().add(
                    const ProductEvent.loadData(id: '1'),
                  );
            },
          ),
        ],
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          // Handle state changes that need side effects (e.g., show snackbar)
          state.maybeWhen(
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.when(
            // Initial state - show prompt to load data
            initial: () => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Ready to load data',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppButton(
                    label: 'Load Example Data',
                    onPressed: () {
                      context.read<ProductBloc>().add(
                            const ProductEvent.loadData(id: '1'),
                          );
                    },
                  ),
                ],
              ),
            ),
            // Loading state - show progress indicator
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            // Loaded state - show data
            loaded: (data) => Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Example Data',
                            style: AppTypographyResponsive.headlineSmall,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          const Divider(),
                          const SizedBox(height: AppSpacing.sm),
                          _buildDataRow('ID', data.id),
                          _buildDataRow('Name', data.name),
                          _buildDataRow('Description', data.description),
                          _buildDataRow(
                            'Created At',
                            data.createdAt.toString().split('.')[0],
                          ),
                          if (data.updatedAt != null)
                            _buildDataRow(
                              'Updated At',
                              data.updatedAt.toString().split('.')[0],
                            ),
                          _buildDataRow(
                            'Is Recent',
                            data.isRecent ? 'Yes' : 'No',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppButton(
                    label: 'Reload Data',
                    onPressed: () {
                      context.read<ProductBloc>().add(
                            const ProductEvent.loadData(id: '1'),
                          );
                    },
                  ),
                ],
              ),
            ),
            // Error state - show error message with retry button
            error: (message) => Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: AppColors.error,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Error',
                      style: AppTypographyResponsive.headlineSmall.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppButton(
                      label: 'Retry',
                      onPressed: () {
                        context.read<ProductBloc>().add(
                              const ProductEvent.loadData(id: '1'),
                            );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Helper widget to build data rows
  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTypography.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
