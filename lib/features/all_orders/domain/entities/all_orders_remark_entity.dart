import 'package:equatable/equatable.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'all_orders_remark_entity.g.dart';

@CopyWith()
class AllOrdersRemarkEntity extends Equatable {
  final String readBy;
  final String remark;
  final String remarkDate;
  final String remarkedBy;
  final String tag;

  const AllOrdersRemarkEntity({
    required this.readBy,
    required this.remark,
    required this.remarkDate,
    required this.remarkedBy,
    required this.tag,
  });

  @override
  List<Object> get props => [
        readBy,
        remark,
        remarkDate,
        remarkedBy,
        tag,
      ];
}
