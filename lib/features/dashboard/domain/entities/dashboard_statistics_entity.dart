import 'package:equatable/equatable.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'dashboard_statistics_entity.g.dart';

@CopyWith()
class DashboardStatisticsEntity extends Equatable {
  final String name;
  final String value;
  final String mainCategory;
  final String imagePath;

  const DashboardStatisticsEntity({
    required this.name,
    required this.value,
    required this.mainCategory,
    required this.imagePath,
  });

  @override
  List<Object> get props => [
        name,
        value,
        mainCategory,
        imagePath,
      ];
}
