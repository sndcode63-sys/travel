import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VisitInfoColumn extends StatelessWidget {
  final String? submitTime;
  final String? schemeName;
  final String? visitStatus;
  final String? email;
  final String? fatherName;
  final String? phone;
  final Color Function(String? status) statusColor;

  final double spacing;
  final TextStyle? textStyle;

  const VisitInfoColumn({
    super.key,
    required this.submitTime,
    required this.schemeName,
    required this.visitStatus,
    required this.email,
    required this.fatherName,
    required this.phone,
    required this.statusColor,
    this.spacing = 6,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = textStyle ??
        const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (submitTime != null && submitTime!.isNotEmpty)
          Text(submitTime!, style: defaultStyle),
        if (schemeName != null && schemeName!.isNotEmpty) ...[
          SizedBox(height: spacing),
          Text(schemeName!, style: defaultStyle),
        ],
        if (visitStatus != null && visitStatus!.isNotEmpty) ...[
          SizedBox(height: spacing),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor(visitStatus).withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              visitStatus!,
              style: defaultStyle.copyWith(
                color: statusColor(visitStatus),
                fontSize: 14,
              ),
            ),
          ),
        ],
        if (email != null && email!.isNotEmpty) ...[
          SizedBox(height: spacing),
          Text(email!, style: defaultStyle),
        ],
        if (fatherName != null && fatherName!.isNotEmpty) ...[
          SizedBox(height: spacing),
          Text(fatherName!, style: defaultStyle),
        ],
        if (phone != null && phone!.isNotEmpty) ...[
          SizedBox(height: spacing),
          Text(phone!, style: defaultStyle),
        ],
      ],
    );
  }
}

class LabeledInfoRow extends StatelessWidget {
  final List<String> labels;
  final List<String?> values;
  final Color Function(String? status) statusColor;
  final double spacing;
  final TextStyle? labelStyle;

  const LabeledInfoRow({
    super.key,
    required this.labels,
    required this.values,
    required this.statusColor,
    this.spacing = 6,
    this.labelStyle,
  }) : assert(labels.length == values.length, "Labels and values must match");

  @override
  Widget build(BuildContext context) {
    final defaultLabelStyle = labelStyle ??
        const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Labels Column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: labels
              .map((label) => Padding(
            padding: EdgeInsets.only(bottom: spacing),
            child: Text(label, style: defaultLabelStyle),
          ))
              .toList(),
        ),

        // Values Column
        VisitInfoColumn(
          submitTime: values[0],
          schemeName: values[1],
          visitStatus: values[2],
          email: values[3],
          fatherName: values[4],
          phone: values[5],
          statusColor: statusColor,
          spacing: spacing,
          textStyle: defaultLabelStyle,
        ),
      ],
    );
  }
}



class VisitCard extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final String? schemeName;
  final String? visitDate;
  final String? visitStatus;
  final Color Function(String? status) statusColor;
  final Color? visitDateColor;

  const VisitCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.schemeName,
    required this.visitDate,
    required this.visitStatus,
    required this.statusColor,
    this.visitDateColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          // Image
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              imageUrl: imageUrl ?? "",
              fit: BoxFit.cover,
              placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator(strokeWidth: 2)),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              memCacheWidth: 200,
              memCacheHeight: 200,
            ),
          ),
          const SizedBox(width: 15),

          // Info Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (name != null) Text(name!, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                if (schemeName != null) Text(schemeName!, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                if (visitDate != null)
                  Text(
                    "Submit Date: $visitDate",
                    style: TextStyle(
                      color: visitDateColor ?? Colors.grey,
                      fontSize: 14,
                    ),
                  ),
              ],
            ),
          ),

          // Status Badge
          if (visitStatus != null)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: statusColor(visitStatus!).withAlpha(50),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                visitStatus!,
                style: TextStyle(
                  color: statusColor(visitStatus!),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
