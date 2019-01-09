import 'dart:io' as io;

import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as g;
import 'package:panache_lib/panache_lib.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/drive.file',
  ],
);

class DriveService implements CloudService {
  final DirectoryProvider dirProvider;
  io.Directory dir;

  GoogleSignInAccount account;

  g.DriveApi api;

  bool get authenticated => (account?.id != null) ?? false;

  DriveService({this.dirProvider}) {
    _initDir();
  }

  Future _initDir() async {
    dir = await dirProvider();
  }

  Future<bool> login() async {
    try {
      account = await _googleSignIn.signIn();
      final client =
          GoogleHttpClient(await _googleSignIn.currentUser.authHeaders);
      api = g.DriveApi(client);
      return api != null;
    } catch (error) {
      print('DriveScreen.login.ERROR... $error');
    }
    return false;
  }

  Future<g.File> save(String content) async {
    final filename = 'my-theme${DateTime.now().millisecondsSinceEpoch}.dart';

    final gFile = g.File();
    gFile.name = filename;

    final localFile = io.File('${dir.path}/$filename');
    await localFile.create();
    await localFile.writeAsString(content);

    final createdFile = await api.files.create(gFile,
        uploadMedia: g.Media(localFile.openRead(), localFile.lengthSync()));

    return createdFile;
  }

  Future logout() async {
    final result = await _googleSignIn.signOut();
    print('DriveService.logout... $result');
    return result;
  }
}
