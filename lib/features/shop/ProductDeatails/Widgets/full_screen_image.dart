import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  const FullScreenImage({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Full Screen Image"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: CachedNetworkImage(imageUrl: image,fit: BoxFit.cover,),
      ),
    );
  }
}
