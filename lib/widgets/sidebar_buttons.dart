import 'package:flutter/material.dart';

class SidebarButtons extends StatelessWidget {
  final double? bottomPadding;
  final bool isFavorite;
  final VoidCallback? onFavorite;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final VoidCallback? onAvatar;
  const SidebarButtons({
    Key? key,
    this.bottomPadding,
    this.onFavorite,
    this.onComment,
    this.onShare,
    this.isFavorite = false,
    this.onAvatar,
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
          ),
          _IconButton(
            icon: const IconToText(Icons.comment, size: 36),
            text: '',
            onTap: onComment,
          ),
          _IconButton(
            icon: const IconToText(Icons.keyboard_arrow_left, size: 36, color: Colors.blue),
            text: '',
            onTap: onComment,
          ),
          _IconButton(
            icon: const IconToText(Icons.keyboard_arrow_right, size: 36, color: Colors.blue),
            text: '',
            onTap: onShare,
          ),
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

class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon({
    Key? key,
    required this.onFavorite,
    this.isFavorite,
  }) : super(key: key);
  final bool? isFavorite;
  final VoidCallback? onFavorite;

  @override
  Widget build(BuildContext context) {
    return _IconButton(
      icon: IconToText(
        Icons.favorite,
        size: 40,
        color: isFavorite! ? Colors.red : null,
      ),
      text: '',
      onTap: onFavorite,
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
      style: style ?? TextStyle(
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
