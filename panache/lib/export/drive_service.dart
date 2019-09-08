import 'dart:async';
import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as g;
import 'package:panache_core/panache_core.dart';
import 'package:panache_services/panache_services.dart';

class DriveService implements CloudService {
  final DirectoryProvider dirProvider;

  io.Directory _dir;
  io.Directory get dir => _dir;

  GoogleSignInAccount _account;

  g.DriveApi _api;

  final GoogleSignIn _googleSignIn;

  Future<bool> get authenticated async => await _googleSignIn.isSignedIn();

  StreamController<User> _userStreamer = StreamController<User>();

  Stream<User> get currentUser$ => _userStreamer.stream;

  DriveService({@required this.dirProvider, @required GoogleSignIn signin})
      : _googleSignIn = signin {
    _initDir();
    //Future.delayed(aSecond * 5, () => _recoverUser());
  }

  dispose() {
    _userStreamer.close();
  }

  // FIXME throw a Platform exception for now
  _recoverUser() {
    try {
      _googleSignIn.signInSilently().then(
          (account) => print('DriveService login... $account'),
          onError: (error) =>
              print('DriveService. silentSignin error  $error'));
    } catch (error) {
      print('DriveService._recoverUser...eXCEPTION\n$error\n----------- ');
    }
  }

  Future _initDir() async {
    _dir = await dirProvider();
  }

  Future<bool> login() async {
    _googleSignIn.onCurrentUserChanged.listen((account) =>
        _userStreamer.add(User(account.displayName, account.photoUrl)));

    try {
      _account = await _googleSignIn
          .signIn()
          .catchError((error) => print('Signin error : $error'));
      if (_account == null) return false;

      final authHeaders = await _googleSignIn.currentUser.authHeaders;
      final client = GoogleHttpClient(authHeaders);

      _api = g.DriveApi(client);
      return _api != null;
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

    final createdFile = await _api.files.create(gFile,
        uploadMedia: g.Media(localFile.openRead(), localFile.lengthSync()));

    return createdFile;
  }

  Future logout() async {
    final result = await _googleSignIn.signOut();
    _account = null;
    return result;
  }
}
