import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'main.dart';
import 'mdelclass.dart';

class mirrorWallProvider with ChangeNotifier {
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  SearchEngine? Engine = SearchEngine.Google;
  InAppWebViewController? webViewController;


  List<BookmarkModel> bookMarkList = [];

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
     // developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    return updateConnectionStatus(result);
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    connectionStatus = result;
    notifyListeners();
  }

  bookMarkADD(BookmarkModel DATA){
    bookMarkList.add(DATA);
    notifyListeners();
  }

  deleteBookMark(index){
    bookMarkList.removeAt(index);
    notifyListeners();
  }



  bookMarkUrl(index){
    webViewController!.loadUrl(urlRequest: URLRequest(url: WebUri('${bookMarkList[index].bookmark}')));
notifyListeners();
  }


  changeEngine(value){
    Engine = value;
    notifyListeners();
  }

}
