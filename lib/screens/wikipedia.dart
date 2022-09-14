import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WikipediaaScreen extends StatefulWidget {
  const WikipediaaScreen({Key? key}) : super(key: key);

  @override
  State<WikipediaaScreen> createState() => _WikipediaaScreenState();
}

class _WikipediaaScreenState extends State<WikipediaaScreen> {
  // late PullToRefreshController pullToRefreshController;
  InAppWebViewController? inAppWebViewController;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  String searchedText = "";
  List allBookMarks = [];
  TextEditingController searchCOntroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wikipedia"),
        actions: [
          IconButton(
            icon: Image.asset("assets/images/wiki.png"),
            onPressed: () async {
              await inAppWebViewController!.loadUrl(
                  urlRequest:
                      URLRequest(url: Uri.parse("https://www.wikipedia.org")));
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () async {
              if (await inAppWebViewController!.canGoBack()) {
                await inAppWebViewController!.goBack();
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              await inAppWebViewController!.reload();
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios_outlined),
            onPressed: () async {
              if (await inAppWebViewController!.canGoForward()) {
                await inAppWebViewController!.goForward();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchCOntroller,
                  onSubmitted: (val) async {
                    searchedText = val;
                    Uri uri = Uri.parse(searchedText);

                    if (uri.scheme.isEmpty) {
                      uri = Uri.parse(
                          "https://www.google.com/search?q=" + searchedText);
                    }

                    await inAppWebViewController!
                        .loadUrl(urlRequest: URLRequest(url: uri));
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              )),
          Expanded(
            flex: 15,
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: Uri.parse("https://www.wikipedia.org"),
              ),
              onWebViewCreated: (controller) {
                inAppWebViewController = controller;
              },
              // pullToRefreshController: pullToRefreshController,
              initialOptions: options,
              onLoadStop: (controller, url) {
                // pullToRefreshController.endRefreshing();
                setState(() {
                  searchCOntroller.text = url.toString();
                });
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.green,
            child: Icon(Icons.bookmark_add_outlined),
            // mini: true,
            onPressed: () async {
              Uri? uri = await inAppWebViewController!.getUrl();
              allBookMarks.add(uri.toString());
            },
          ),
          SizedBox(width: 5),
          FloatingActionButton(
            backgroundColor: Colors.green,
            child: Icon(Icons.bookmarks_outlined),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        content: Column(
                          children: allBookMarks
                              .map((e) => GestureDetector(
                                    child: Text(e),
                                    onTap: () {
                                      Navigator.of(context).pop();

                                      inAppWebViewController!.loadUrl(
                                        urlRequest: URLRequest(
                                          url: Uri.parse(e),
                                        ),
                                      );
                                    },
                                  ))
                              .toList(),
                        ),
                      ));
            },
            // mini: true,
          ),
        ],
      ),
    );
  }
}
