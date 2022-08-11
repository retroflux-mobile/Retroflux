import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SidebarButtons extends StatelessWidget {
  final double? bottomPadding;
  final bool isFavorite;
  final bool isSpeedMode;
  final VoidCallback onFavorite;
  final VoidCallback onSpeedMode;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final VoidCallback? onAvatar;
  final PdfViewerController pdfController;
  const SidebarButtons({
    Key? key,
    this.bottomPadding,
    required this.onFavorite,
    required this.onSpeedMode,
    this.onComment,
    this.onShare,
    this.isFavorite = false,
    this.isSpeedMode = true,
    this.onAvatar,
    required this.pdfController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      margin: EdgeInsets.only(
        bottom: bottomPadding ?? 50,
        right: 12,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FavoriteIcon(
            onFavorite: onFavorite,
            isFavorite: isFavorite,
            pdfController: pdfController,
          ),
          _IconButton(
            icon: const IconToText(Icons.comment, size: 36),
            text: '',
            onTap: onComment,
          ),
          SpeedModeIcon(isSpeedMode: isSpeedMode, onSpeedMode: onSpeedMode),
          Container(
            width: 56,
            height: 56,
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.0),
              // color: Colors.black.withOpacity(0.8),
            ),
          )
        ],
      ),
    );
  }
}

class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon({
    Key? key,
    required this.onFavorite,
    required this.isFavorite,
    required this.pdfController,
  }) : super(key: key);
  final bool isFavorite;
  final VoidCallback onFavorite;
  final PdfViewerController pdfController;

  @override
  State<StatefulWidget> createState() => FavoriteIconState();
}

class FavoriteIconState extends State<FavoriteIcon> {
  @override
  Widget build(BuildContext context) {
    return _IconButton(
      icon: IconToText(
        Icons.favorite,
        size: 40,
        color: widget.isFavorite ? Colors.red : null,
      ),
      text: '',
      onTap: () => {widget.onFavorite()},
    );
  }
}

class SpeedModeIcon extends StatefulWidget {
  const SpeedModeIcon({
    Key? key,
    required this.isSpeedMode,
    required this.onSpeedMode,
  }) : super(key: key);
  final bool isSpeedMode;
  final VoidCallback onSpeedMode;

  @override
  State<StatefulWidget> createState() => SpeedModeIconState();
}

class SpeedModeIconState extends State<SpeedModeIcon> {
  @override
  Widget build(BuildContext context) {
    return _IconButton(
      icon: IconToText(
        Icons.speed,
        size: 40,
        color: widget.isSpeedMode ? Colors.blue : null,
      ),
      text: '',
      onTap: () => {widget.onSpeedMode()},
    );
  }
}

class IconToText extends StatelessWidget {
  final IconData? icon;
  final TextStyle? style;
  final double? size;
  final Color? color;

  const IconToText(
    this.icon, {
    Key? key,
    this.style,
    this.size,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      String.fromCharCode(icon!.codePoint),
      style: style ??
          TextStyle(
            fontFamily: 'MaterialIcons',
            fontSize: size ?? 30,
            inherit: true,
            color: color ?? Colors.white,
          ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final Widget? icon;
  final String? text;
  final VoidCallback? onTap;
  const _IconButton({
    Key? key,
    this.icon,
    this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shadowStyle = TextStyle(
      shadows: [
        Shadow(
          color: Colors.black.withOpacity(0.15),
          offset: const Offset(0, 1),
          blurRadius: 1,
        ),
      ],
    );
    Widget body = Column(
      children: <Widget>[
        GestureDetector(
          onTap: onTap,
          // The custom button
          child: icon ?? Container(),
        ),
        Container(height: 2),
        Text(
          text ?? '??',
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DefaultTextStyle(
        child: body,
        style: shadowStyle,
      ),
    );
  }
}
