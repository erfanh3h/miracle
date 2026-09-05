import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Components/appwrite_component.dart';

class AppwriteImage extends StatelessWidget {
  const AppwriteImage({
    super.key,
    this.bucketId = "660974b80d1540254b8c",
    required this.fileId,
    this.fit = BoxFit.cover,
    this.radius = 50,
  });

  final String bucketId;
  final String fileId;
  final BoxFit fit;
  final double radius;

  @override
  Widget build(BuildContext context) {
    Storage storage = Storage(AppwriteComponent.instance.client);
    return FutureBuilder(
      future: storage.getFileView(bucketId: bucketId, fileId: fileId),
      builder: (context, snapshot) {
        return CircleAvatar(
          radius: radius,
          backgroundColor: context.theme.colorScheme.inverseSurface,
          backgroundImage: snapshot.hasData && snapshot.data != null
              ? MemoryImage(snapshot.data!)
              : null,
          child: snapshot.hasData && snapshot.data != null
              ? Container()
              : Icon(
                  Icons.person,
                  size: radius,
                  color: context.theme.colorScheme.surface,
                ),
        );
      },
    );
  }
}
