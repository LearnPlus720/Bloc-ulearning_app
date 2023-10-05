




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:ulearning_app/pages/common_widgets.dart';
import 'bloc/payview_blocs.dart';
import 'bloc/payview_events.dart';
import 'bloc/payview_states.dart';

class PayWebView extends StatefulWidget {
  const PayWebView({super.key});

  @override
  State<PayWebView> createState() => _PayWebViewState();
}

class _PayWebViewState extends State<PayWebView> {
  late final WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    print("... PayWebView initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)!.settings.arguments as Map;
    print('------my url is ${args['url']}');

    context.read<PayWebViewBloc>().add(TriggerWebView(args["url"]));

  }

  @override
  void dispose(){
    webViewController.clearCache();
    print("... PayWebView dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PayWebViewBloc, PayWebViewStates>(
        builder: (context, state)
    {
      return Scaffold(
        appBar: buildAppBar(titleText :"Payment page"),
        body:  state.url==""?SizedBox(width:50.w, height:50.h,child: const CircularProgressIndicator(),): WebView(
              initialUrl: state.url,
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels: {

                    JavascriptChannel(
                    name: "Pay",
                    onMessageReceived: (JavascriptMessage message){
                    print(message.message);
                    Navigator.of(context).pop(message.message);
                    }
                    ),
                },
              onWebViewCreated: (WebViewController w){
                webViewController = w;
              },
                ),
      );
    });
  }
}
