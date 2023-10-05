import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';

import 'common/values/colors.dart';
import 'global.dart';

Future<void> main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   lazy: false,
    //     create: (context)=>WelcomeBloc(),
    //   child: ScreenUtilInit(
    //     builder: (context,child)=> MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       theme: ThemeData(
    //         appBarTheme:  const AppBarTheme(
    //           elevation: 0,
    //           backgroundColor: Colors.white,
    //           centerTitle: true,
    //         ),
    //       ),
    //       home: Welcome(),
    //       routes: {
    //         "myHomePage":(context)=>const MyHomePage(title: 'dfsdfsdfsdf',),
    //         "signIn":(context)=>const SignIn(),
    //       },
    //     )
    //   )
    //
    // );
    
    return MultiBlocProvider(
        // providers: AppBlocProviders.allBlockProviders,
      providers: [...AppPages.allBlocProviders(context)],
        child: ScreenUtilInit(
          // Universal Size
          designSize: const Size(375,812),
          builder: (context,child)=> MaterialApp(
            builder: EasyLoading.init(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                appBarTheme: const AppBarTheme(
                    iconTheme: IconThemeData(
                      color: AppColors.primaryText,
                    ),
                    elevation: 0,
                    centerTitle: true,
                    backgroundColor: Colors.white)),
            // home: ApplicationPage(),
            onGenerateRoute: AppPages.GenerateRouteSettings,
            // initialRoute: "/",
            // routes: {
            //   // "myHomePage":(context)=>const MyHomePage(title: 'MyHomePage',),
            //   "signIn":(context)=>const SignIn(),
            //   "register":(context)=>const Register(),
            // },
          ),
        )

    );
  }

}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  void _decrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Container();
    // return Scaffold(
    //   appBar: AppBar(
    //     // TRY THIS: Try changing the color here to a specific color (to
    //     // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
    //     // change color while the other colors stay the same.
    //     backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    //     // Here we take the value from the MyHomePage object that was created by
    //     // the App.build method, and use it to set our appbar title.
    //     title: Text(widget.title),
    //   ),
    //   body: Center(
    //     // Center is a layout widget. It takes a single child and positions it
    //     // in the middle of the parent.
    //     child: BlocBuilder<AppBlocs, AppStates>(
    //       builder: (context, state){
    //       return Column(
    //
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           const Text(
    //             'You have pushed the button this many times:',
    //           ),
    //           Text(
    //             "${BlocProvider.of<AppBlocs>(context).state.counter}",
    //             style: Theme.of(context).textTheme.headlineMedium,
    //           ),
    //         ],
    //       );
    //       },
    //     ),
    //   ),
    //   floatingActionButton: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: [
    //       FloatingActionButton(
    //         heroTag: "herotag1",
    //         onPressed: ()=>BlocProvider.of<AppBlocs>(context).add(Increment()),
    //         tooltip: 'Increment',
    //         child: const Icon(Icons.add),
    //       ),
    //       FloatingActionButton(
    //         heroTag: "herotag2",
    //         onPressed:()=>BlocProvider.of<AppBlocs>(context).add(Decrement()),
    //         tooltip: 'Decrement',
    //         child: const Icon(Icons.minimize),
    //       ),
    //     ],
    //   ), // This trailing comma makes auto-formatting nicer for build methods.
    // );
  }
}
