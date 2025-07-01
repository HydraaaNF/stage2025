import "package:flutter/material.dart";

void main(){
	runApp(MaterialApp(home:MainPage()));
}

class MainPage extends StatefulWidget{
	MainPage({super.key});

	State<MainPage> createState(){
		return MainPageState();
	}
}

class MainPageState extends State<MainPage>{
	final pages = [
		Page1(),
		Page2()
	];

	int pageIndex = 0;
	
	@override
	Widget build(BuildContext context){
		return Scaffold(
			appBar: AppBar(title: const Text("Exo1"), elevation:15),
			body: pages[pageIndex],
			bottomNavigationBar: NavigationBar(
				selectedIndex: pageIndex,
				onDestinationSelected: (int index){
					setState((){
						pageIndex = index;
					});
				},
				destinations:[
					NavigationDestination(
						icon: Icon(Icons.camera),
						label: "Page 1"
					),
					NavigationDestination(
						icon: Icon(Icons.backpack),
						label: "Page 2"
					)
				]
			)
		);
	}
}

class Page1 extends StatelessWidget{
	Page1({super.key});

	@override
	Widget build(BuildContext context){
		return Center(child: Text("Page 1"));
	}
}

class Page2 extends StatelessWidget{
	Page2({super.key});

	@override
	Widget build(BuildContext context){
		return Center(child: Text("Page 2"));
	}
}