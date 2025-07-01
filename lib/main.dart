import "package:flutter/material.dart";

void main(){
	runApp(MaterialApp(home:Page1()));
}

class Page1 extends StatefulWidget{
	Page1({super.key});

	State<Page1> createState(){
		return Page1State();
	}
}

class Page1State extends State<Page1>{	
	@override
	Widget build(PageContext context){
		return Scaffold(
			appBar: AppBar(title: const Text("Page1"), elevation:15),
			body: Center(child: Text("Corps de la page 1"),
		)
	}
}

class Page2 extends StatefulWidget{
	Page2({super.key});

	State<Page2> createState(){
		return Page2State();
	}
}

class Page2State extends State<Page1>{	
	@override
	Widget build(PageContext context){
		return Scaffold(
			appBar: AppBar(title: const Text("Page2"), elevation:15),
			body: Center(child: Text("Corps de la page 2"),
		)
	}
}