import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewerScreen extends StatefulWidget {
  /////////////////////////////////////////
  ///
  /// You Have to input list of either files or urls of your images to view
  ///
  ////////////////////////////////////////
  PhotoViewerScreen({
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    this.galleryItemsUrls,
    this.galleryItemsFiles,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<String>? galleryItemsUrls;
  final List<File>? galleryItemsFiles;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _PhotoViewerScreenState();
  }
}

class _PhotoViewerScreenState extends State<PhotoViewerScreen> {
  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    late final item;
    if (widget.galleryItemsUrls == null) {
      item = widget.galleryItemsFiles![index];
    } else {
      item = widget.galleryItemsUrls![index];
    }

    PhotoViewScaleStateController scaleStateController;
    scaleStateController = PhotoViewScaleStateController();
    return PhotoViewGalleryPageOptions(
      imageProvider: widget.galleryItemsUrls == null
          ? Image.file(widget.galleryItemsFiles![index]).image
          : Image.network(widget.galleryItemsUrls![index]).image,
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      scaleStateController: scaleStateController,
      heroAttributes: PhotoViewHeroAttributes(tag: UniqueKey()),
    );
  }

  @override
  Widget build(BuildContext context) {
    late int currentIndex = widget.initialIndex;

    void onPageChanged(int index) {
      setState(() {
        currentIndex = index;
      });
    }

    return Scaffold(
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.galleryItemsUrls == null
                  ? widget.galleryItemsFiles!.length
                  : widget.galleryItemsUrls!.length,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration,
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
              scrollDirection: widget.scrollDirection,
            ),
          ],
        ),
      ),
    );
  }
}
