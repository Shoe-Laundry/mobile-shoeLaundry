/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/User.svg
  SvgGenImage get user => const SvgGenImage('assets/icons/User.svg');

  /// File path: assets/icons/additionalservices.svg
  SvgGenImage get additionalservices =>
      const SvgGenImage('assets/icons/additionalservices.svg');

  /// File path: assets/icons/all_categories.svg
  SvgGenImage get allCategories =>
      const SvgGenImage('assets/icons/all_categories.svg');

  /// File path: assets/icons/careandmaintenance.svg
  SvgGenImage get careandmaintenance =>
      const SvgGenImage('assets/icons/careandmaintenance.svg');

  /// File path: assets/icons/cash.svg
  SvgGenImage get cash => const SvgGenImage('assets/icons/cash.svg');

  /// File path: assets/icons/dashboard.svg
  SvgGenImage get dashboard => const SvgGenImage('assets/icons/dashboard.svg');

  /// File path: assets/icons/debit.svg
  SvgGenImage get debit => const SvgGenImage('assets/icons/debit.svg');

  /// File path: assets/icons/delete.svg
  SvgGenImage get delete => const SvgGenImage('assets/icons/delete.svg');

  /// File path: assets/icons/done.svg
  SvgGenImage get done => const SvgGenImage('assets/icons/done.svg');

  /// File path: assets/icons/history.svg
  SvgGenImage get history => const SvgGenImage('assets/icons/history.svg');

  /// File path: assets/icons/home.svg
  SvgGenImage get home => const SvgGenImage('assets/icons/home.svg');

  /// File path: assets/icons/image.svg
  SvgGenImage get image => const SvgGenImage('assets/icons/image.svg');

  /// File path: assets/icons/orders.svg
  SvgGenImage get orders => const SvgGenImage('assets/icons/orders.svg');

  /// File path: assets/icons/payments.svg
  SvgGenImage get payments => const SvgGenImage('assets/icons/payments.svg');

  /// File path: assets/icons/print.svg
  SvgGenImage get print => const SvgGenImage('assets/icons/print.svg');

  /// File path: assets/icons/profile.svg
  SvgGenImage get profile => const SvgGenImage('assets/icons/profile.svg');

  /// File path: assets/icons/qr_code.svg
  SvgGenImage get qrCode => const SvgGenImage('assets/icons/qr_code.svg');

  /// File path: assets/icons/washingservice.svg
  SvgGenImage get washingservice =>
      const SvgGenImage('assets/icons/washingservice.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        user,
        additionalservices,
        allCategories,
        careandmaintenance,
        cash,
        dashboard,
        debit,
        delete,
        done,
        history,
        home,
        image,
        orders,
        payments,
        print,
        profile,
        qrCode,
        washingservice
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/image-qris.png
  AssetGenImage get imageQris =>
      const AssetGenImage('assets/images/image-qris.png');

  /// File path: assets/images/launcher.png
  AssetGenImage get launcher =>
      const AssetGenImage('assets/images/launcher.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/manage_printer.png
  AssetGenImage get managePrinter =>
      const AssetGenImage('assets/images/manage_printer.png');

  /// File path: assets/images/manage_printerx.png
  AssetGenImage get managePrinterx =>
      const AssetGenImage('assets/images/manage_printerx.png');

  /// File path: assets/images/manage_product.png
  AssetGenImage get manageProduct =>
      const AssetGenImage('assets/images/manage_product.png');

  /// File path: assets/images/order.png
  AssetGenImage get order => const AssetGenImage('assets/images/order.png');

  /// File path: assets/images/sinkrondata.png
  AssetGenImage get sinkrondata =>
      const AssetGenImage('assets/images/sinkrondata.png');

  /// File path: assets/images/user.png
  AssetGenImage get user => const AssetGenImage('assets/images/user.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        imageQris,
        launcher,
        logo,
        managePrinter,
        managePrinterx,
        manageProduct,
        order,
        sinkrondata,
        user
      ];
}

class $AssetsJsonGen {
  const $AssetsJsonGen();

  /// File path: assets/json/empty.json
  String get empty => 'assets/json/empty.json';

  /// File path: assets/json/onboarding1.json
  String get onboarding1 => 'assets/json/onboarding1.json';

  /// File path: assets/json/onboarding2.json
  String get onboarding2 => 'assets/json/onboarding2.json';

  /// File path: assets/json/onboarding3.json
  String get onboarding3 => 'assets/json/onboarding3.json';

  /// List of all assets
  List<String> get values => [empty, onboarding1, onboarding2, onboarding3];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsJsonGen json = $AssetsJsonGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
