import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'bottom_drawer.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final String Function(T) itemToString;
  final void Function(T?) onChanged;
  final String? hint;
  final bool isRequired;
  final String? errorText;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.itemToString,
    required this.onChanged,
    this.hint,
    this.isRequired = false,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (isRequired)
              Text(
                ' *',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
          ],
        ),
        SizedBox(height: 8.h),
        InkWell(
          onTap: () => _showDropdown(context),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: errorText != null ? Theme.of(context).colorScheme.error : Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value != null ? itemToString(value as T) : (hint ?? 'Select $label'),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: value != null ? null : Colors.grey,
                      ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),
        ),
        if (errorText != null) ...[
          SizedBox(height: 4.h),
          Text(
            errorText!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
        ],
      ],
    );
  }

  void _showDropdown(BuildContext context) {
    showBottomDrawer(
      context: context,
      title: label,
      children: [
        ...items.map(
          (item) => ListTile(
            title: Text(itemToString(item)),
            trailing: value == item
                ? Icon(
                    Icons.check,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : null,
            onTap: () {
              onChanged(item);
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
