import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../features/charkhs/domain/charkh.dart';
import '../../features/destinations/domain/destination.dart';
import '../theme/koscharkh_theme.dart';

class KosAssets {
  const KosAssets._();

  static const icons = 'design_files/Icons';
  static const account = '$icons/Account circle.svg';
  static const accountFilled = '$icons/Account circle-1.svg';
  static const add = '$icons/add.svg';
  static const arrowBack = '$icons/arrow_back.svg';
  static const barefoot = '$icons/Barefoot.svg';
  static const cancel = '$icons/cancel.svg';
  static const cropFree = '$icons/crop_free.svg';
  static const edit = '$icons/edit.svg';
  static const electricBolt = '$icons/electric_bolt.svg';
  static const emojiPeople = '$icons/emoji_people.svg';
  static const explore = '$icons/Explore.svg';
  static const fullscreenExit = '$icons/fullscreen_exit.svg';
  static const home = '$icons/Home.svg';
  static const locationOn = '$icons/location_on.svg';
  static const map = '$icons/map.svg';
  static const myLocation = '$icons/my_location.svg';
}

class KosSvgIcon extends StatelessWidget {
  const KosSvgIcon(this.asset, {super.key, this.size = 24, this.color});

  final String asset;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: size,
      height: size,
      colorFilter: color == null
          ? null
          : ColorFilter.mode(color!, BlendMode.srcIn),
    );
  }
}

class AppScreen extends StatelessWidget {
  const AppScreen({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.safeArea = true,
  });

  final Widget child;
  final EdgeInsets padding;
  final bool safeArea;

  @override
  Widget build(BuildContext context) {
    final content = Padding(padding: padding, child: child);
    return Scaffold(
      backgroundColor: context.colors.surface,
      body: safeArea ? SafeArea(child: content) : content,
    );
  }
}

class HeaderWithBack extends StatelessWidget {
  const HeaderWithBack({super.key, required this.title, this.onBack});

  final String title;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28, bottom: 20),
      child: Row(
        children: [
          SizedBox(
            width: 44,
            height: 44,
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: onBack ?? () => Navigator.of(context).maybePop(),
              icon: KosSvgIcon(
                KosAssets.arrowBack,
                color: context.colors.onSurface,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }
}

enum KosButtonVariant { primary, secondary, danger }

class KosButton extends StatelessWidget {
  const KosButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = KosButtonVariant.primary,
    this.icon,
    this.height = 51,
    this.width,
  });

  final String text;
  final VoidCallback? onPressed;
  final KosButtonVariant variant;
  final String? icon;
  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final background = switch (variant) {
      KosButtonVariant.primary => colors.primary,
      KosButtonVariant.secondary => colors.onSurfaceMuted,
      KosButtonVariant.danger => colors.red500,
    };
    final foreground = switch (variant) {
      KosButtonVariant.primary => colors.onPrimary,
      KosButtonVariant.secondary => colors.surface,
      KosButtonVariant.danger => colors.onError,
    };
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: background,
          disabledBackgroundColor: colors.disabled,
          foregroundColor: foreground,
          disabledForegroundColor: colors.onDisabled,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: foreground,
            fontWeight: FontWeight.w500,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              KosSvgIcon(icon!, size: 20, color: foreground),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}

class IconSquareButton extends StatelessWidget {
  const IconSquareButton({
    super.key,
    required this.asset,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
  });

  final String asset;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 51,
      height: 51,
      child: Material(
        color: backgroundColor ?? context.colors.primary,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: KosSvgIcon(
              asset,
              color: iconColor ?? context.colors.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

class KosTextInput extends StatefulWidget {
  const KosTextInput({
    super.key,
    required this.value,
    required this.onChanged,
    this.placeholder,
    this.keyboardType,
  });

  final String value;
  final ValueChanged<String> onChanged;
  final String? placeholder;
  final TextInputType? keyboardType;

  @override
  State<KosTextInput> createState() => _KosTextInputState();
}

class _KosTextInputState extends State<KosTextInput> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant KosTextInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_focusNode.hasFocus && _controller.text != widget.value) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 51,
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        style: Theme.of(context).textTheme.bodyMedium,
        cursorColor: context.colors.primary,
        decoration: InputDecoration(
          filled: true,
          fillColor: context.colors.surfaceMuted,
          hintText: widget.placeholder,
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: context.colors.onSurfaceMuted,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}

class FieldLabel extends StatelessWidget {
  const FieldLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: Theme.of(context).textTheme.labelLarge),
    );
  }
}

class ErrorCaption extends StatelessWidget {
  const ErrorCaption(this.message, {super.key});

  final String? message;

  @override
  Widget build(BuildContext context) {
    if (message == null || message!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        message!,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: context.colors.error),
      ),
    );
  }
}

class CharkhCard extends StatelessWidget {
  const CharkhCard({
    super.key,
    required this.charkh,
    required this.onStart,
    required this.onEdit,
    required this.onDelete,
  });

  final Charkh charkh;
  final VoidCallback onStart;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: context.colors.surfaceMuted,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardLine('Name: ${charkh.name}'),
          const SizedBox(height: 8),
          _CardLine('Time: ${charkh.timeMinutes} minutes'),
          const SizedBox(height: 8),
          _CardLine('Description: ${charkh.description ?? ''}'),
          const SizedBox(height: 16),
          Row(
            children: [
              KosButton(
                text: 'Start',
                width: 77,
                height: 34,
                onPressed: onStart,
              ),
              const SizedBox(width: 8),
              KosButton(
                text: 'Edit',
                width: 77,
                height: 34,
                variant: KosButtonVariant.secondary,
                onPressed: onEdit,
              ),
              const SizedBox(width: 8),
              KosButton(
                text: 'Delete',
                width: 87,
                height: 34,
                variant: KosButtonVariant.danger,
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardLine extends StatelessWidget {
  const _CardLine(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11),
    );
  }
}

class DestinationCard extends StatelessWidget {
  const DestinationCard({
    super.key,
    required this.index,
    required this.destination,
    required this.onEdit,
    required this.onDelete,
  });

  final int index;
  final DestinationDraft destination;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: context.colors.surfaceMuted,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$index. ${destination.name}',
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            tooltip: 'Edit',
            onPressed: onEdit,
            icon: KosSvgIcon(
              KosAssets.edit,
              size: 20,
              color: context.colors.onSurface,
            ),
          ),
          const SizedBox(width: 2),
          SizedBox(
            width: 30,
            height: 30,
            child: Material(
              color: context.colors.error,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onDelete,
                child: Center(
                  child: KosSvgIcon(
                    KosAssets.cancel,
                    size: 16,
                    color: context.colors.onError,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class KosBottomNav extends StatelessWidget {
  const KosBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final items = [KosAssets.home, KosAssets.explore, KosAssets.account];
    return SafeArea(
      top: false,
      child: Container(
        height: 72,
        color: context.colors.surfaceMuted,
        child: Row(
          children: [
            for (var i = 0; i < items.length; i++)
              Expanded(
                child: IconButton(
                  tooltip: ['Home', 'Charkhs', 'Account'][i],
                  onPressed: () => onTap(i),
                  icon: KosSvgIcon(
                    items[i],
                    color: i == currentIndex
                        ? context.colors.onSurface
                        : context.colors.onSurfaceMuted,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

Future<bool> confirmDestructiveAction(
  BuildContext context, {
  required String title,
  required String message,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: context.colors.surfaceMuted,
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Delete',
              style: TextStyle(color: context.colors.error),
            ),
          ),
        ],
      );
    },
  );
  return result ?? false;
}
