import 'dart:ui';

import 'package:flutter/material.dart';

class AppBottomBarItem {
  const AppBottomBarItem({
    required this.title,
    required this.icon,
    this.selectedIcon,
    this.onTap,
    this.badge,
    this.isCenter = false,
    this.isActionOnly = false, // <-- new flag
  });

  final String title;
  final Widget icon;
  final Widget? selectedIcon;
  final VoidCallback? onTap;
  final Widget? badge;
  final bool isCenter;
  final bool isActionOnly;
}

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onChanged,
    this.height = 72,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.indicatorColor,
    this.borderRadius = 22,
    this.showLabels = true,
    this.showIndicator = true,
    this.enableBlur = true,
    this.blurSigma = 20,
    this.iconSize = 24,
    this.selectedIconSize = 25,
    this.centerIconSize = 30,
    this.centerButtonSize = 56,
    this.animationDuration = const Duration(milliseconds: 250),
  });

  final List<AppBottomBarItem> items;
  final int currentIndex;
  final ValueChanged<int> onChanged;

  final double height;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? indicatorColor;
  final double borderRadius;
  final bool showLabels;
  final bool showIndicator;
  final bool enableBlur;
  final double blurSigma;
  final double iconSize;
  final double selectedIconSize;
  final double centerIconSize;
  final double centerButtonSize;
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final selected = selectedColor ?? theme.colorScheme.primary;
    final unselected = unselectedColor ?? theme.colorScheme.onSurfaceVariant;
    final background =
        backgroundColor ?? theme.colorScheme.surface.withValues(alpha: 0.5);

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(36, 0, 36, 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 24,
                offset: const Offset(0, -6),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: BackdropFilter(
              filter: enableBlur
                  ? ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma)
                  : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(
                height: height,
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.12),
                    width: 1,
                  ),
                ),
                child: _buildRow(selected, unselected),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(Color selected, Color unselected) {
    // Find index of center item (if any)
    int centerIndex = -1;
    for (int i = 0; i < items.length; i++) {
      if (items[i].isCenter) {
        centerIndex = i;
        break;
      }
    }

    if (centerIndex == -1) {
      // No center item → all items rendered equally
      return Row(
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = !item.isActionOnly && index == currentIndex;
          return Expanded(
            child: _BottomBarButton(
              item: item,
              selected: isSelected,
              selectedColor: selected,
              unselectedColor: unselected,
              indicatorColor:
                  indicatorColor ?? selected.withValues(alpha: 0.12),
              showLabel: showLabels,
              showIndicator: showIndicator,
              iconSize: iconSize,
              selectedIconSize: selectedIconSize,
              animationDuration: animationDuration,
              onTap: () {
                if (!item.isActionOnly) {
                  onChanged(index);
                }
                item.onTap?.call();
              },
            ),
          );
        }),
      );
    }

    // With center item → split into left and right
    final leftItems = items.sublist(0, centerIndex);
    final rightItems = items.sublist(centerIndex + 1);

    return Row(
      children: [
        ...leftItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isSelected = !item.isActionOnly && index == currentIndex;
          return Expanded(
            child: _BottomBarButton(
              item: item,
              selected: isSelected,
              selectedColor: selected,
              unselectedColor: unselected,
              indicatorColor:
                  indicatorColor ?? selected.withValues(alpha: 0.12),
              showLabel: showLabels,
              showIndicator: showIndicator,
              iconSize: iconSize,
              selectedIconSize: selectedIconSize,
              animationDuration: animationDuration,
              onTap: () {
                if (!item.isActionOnly) {
                  onChanged(index);
                }
                item.onTap?.call();
              },
            ),
          );
        }),

        // Center button
        _CenterBottomBarButton(
          item: items[centerIndex],
          selected: items[centerIndex].isActionOnly
              ? true // always solid for action-only center
              : centerIndex == currentIndex,
          selectedColor: selected,
          buttonSize: centerButtonSize,
          iconSize: centerIconSize,
          animationDuration: animationDuration,
          onTap: () {
            if (!items[centerIndex].isActionOnly) {
              onChanged(centerIndex);
            }
            items[centerIndex].onTap?.call();
          },
        ),

        ...rightItems.asMap().entries.map((entry) {
          final index = centerIndex + 1 + entry.key;
          final item = entry.value;
          final isSelected = !item.isActionOnly && index == currentIndex;
          return Expanded(
            child: _BottomBarButton(
              item: item,
              selected: isSelected,
              selectedColor: selected,
              unselectedColor: unselected,
              indicatorColor:
                  indicatorColor ?? selected.withValues(alpha: 0.12),
              showLabel: showLabels,
              showIndicator: showIndicator,
              iconSize: iconSize,
              selectedIconSize: selectedIconSize,
              animationDuration: animationDuration,
              onTap: () {
                if (!item.isActionOnly) {
                  onChanged(index);
                }
                item.onTap?.call();
              },
            ),
          );
        }),
      ],
    );
  }
}

class _CenterBottomBarButton extends StatelessWidget {
  const _CenterBottomBarButton({
    required this.item,
    required this.selected,
    required this.selectedColor,
    required this.buttonSize,
    required this.iconSize,
    required this.animationDuration,
    required this.onTap,
  });

  final AppBottomBarItem item;
  final bool selected;
  final Color selectedColor;
  final double buttonSize;
  final double iconSize;
  final Duration animationDuration;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final icon = item.selectedIcon ?? item.icon;

    final backgroundColor = selected
        ? selectedColor
        : selectedColor.withValues(alpha: 0.15);
    final iconColor = selected ? Colors.white : selectedColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(
        child: AnimatedContainer(
          duration: animationDuration,
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: selectedColor.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              customBorder: const CircleBorder(),
              child: Center(
                child: AnimatedSwitcher(
                  duration: animationDuration,
                  child: IconTheme(
                    key: ValueKey(iconColor),
                    data: IconThemeData(size: iconSize, color: iconColor),
                    child: icon,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomBarButton extends StatelessWidget {
  const _BottomBarButton({
    required this.item,
    required this.selected,
    required this.selectedColor,
    required this.unselectedColor,
    required this.indicatorColor,
    required this.showLabel,
    required this.showIndicator,
    required this.iconSize,
    required this.selectedIconSize,
    required this.animationDuration,
    required this.onTap,
  });

  final AppBottomBarItem item;
  final bool selected;
  final Color selectedColor;
  final Color unselectedColor;
  final Color indicatorColor;
  final bool showLabel;
  final bool showIndicator;
  final double iconSize;
  final double selectedIconSize;
  final Duration animationDuration;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final icon = selected ? (item.selectedIcon ?? item.icon) : item.icon;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Center(
          child: AnimatedContainer(
            duration: animationDuration,
            curve: Curves.easeOutCubic,
            padding: EdgeInsets.symmetric(
              horizontal: showLabel ? 12 : 8,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: showIndicator && selected
                  ? indicatorColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    AnimatedScale(
                      scale: selected ? 1.0 : 0.92,
                      duration: animationDuration,
                      child: IconTheme(
                        data: IconThemeData(
                          size: selected ? selectedIconSize : iconSize,
                          color: selected ? selectedColor : unselectedColor,
                        ),
                        child: icon,
                      ),
                    ),
                    if (item.badge != null)
                      Positioned(right: -8, top: -6, child: item.badge!),
                  ],
                ),
                if (showLabel) ...[
                  const SizedBox(height: 3),
                  AnimatedDefaultTextStyle(
                    duration: animationDuration,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                      color: selected ? selectedColor : unselectedColor,
                    ),
                    child: Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontFamily: "vazir"),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
