import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
	runApp(MyApp());
}

class MyApp extends StatelessWidget{
	MyApp({super.key});

	@override
	Widget build(BuildContext context){
		return MultiProvider(providers: [
				ChangeNotifierProvider(create: (context) => ThemeProvider())
			],
			child: HomePage()
		);
	}
}

class HomePage extends StatefulWidget{
	HomePage({super.key});
	
	State<HomePage> createState(){
		return HomePageState();
	}
}

class HomePageState extends State<HomePage>{

	bool settings = false;

	Future<bool> getBrightMode()async{
		final prefs = await SharedPreferences.getInstance();
		bool? dm = prefs.getBool("darkmode");
		if(dm != null){
			return dm;
		}
		return false;
	}

	@override
	Widget build(BuildContext context){
		getBrightMode().then((dm) => context.read<ThemeProvider>().setMode(dm));
		return MaterialApp(
					home: Scaffold(
						appBar: AppBar(title: const Text("...")),
						body:settings ? Settings() : ClassicPage()
						,
						floatingActionButton: FloatingActionButton(
								onPressed: (){
									setState(() {
										settings = !settings;
									});
								},
								child: Icon(settings ? Icons.arrow_back : Icons.settings)
						),
					),
					theme: ThemeData(
						brightness: Brightness.dark,
						scaffoldBackgroundColor: Colors.red,
						primaryColor: Colors.orange
					),
					darkTheme: ThemeData(
						brightness: Brightness.dark,
						scaffoldBackgroundColor: Colors.black,
						primaryColor: Colors.deepOrangeAccent
					),
					themeMode: context.watch<ThemeProvider>().darkmode ? ThemeMode.dark : ThemeMode.light,
				);
	}
}

class ClassicPage extends StatefulWidget{
	ClassicPage({super.key});

	State<ClassicPage> createState(){
		return ClassicPageState();
	}
}

class ClassicPageState extends State<ClassicPage>{

	@override
	Widget build(BuildContext context){
		return Center(child: Text("text random"),);
	}
}

class Settings extends StatefulWidget{
	Settings({super.key});

	State<Settings> createState(){
		return SettingsState();
	}
}

class SettingsState extends State<Settings>{

	void setBrightMode(darkmode)async{
		final prefs = await SharedPreferences.getInstance();
		prefs.setBool("darkmode", darkmode);
	}

	@override
	Widget build(BuildContext context){
		return Center(
				child: IconButton(
						onPressed: ()async{
							context.read<ThemeProvider>().switchMode();
							setBrightMode(context.read<ThemeProvider>().darkmode);
						},
						tooltip: "Changer le thème",
						icon: Icon(context.watch<ThemeProvider>().darkmode ? Icons.dark_mode : Icons.light_mode)
				)
		);
	}
}

class ThemeProvider extends ChangeNotifier{
	bool darkmode;
	ThemeProvider({this.darkmode = false});

	void switchMode()async{
		darkmode = !darkmode;
		notifyListeners();
	}

	void setMode(mode)async{
		if(mode != darkmode){
			darkmode = mode;
			notifyListeners();
		}
	}
}