import "package:flutter/material.dart";
import "package:file_picker/file_picker.dart";
import 'dart:io';
import 'package:path/path.dart' as path;

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
	List<File> fichiers = [];

	@override
	Widget build(BuildContext context){
		return Scaffold(
			appBar: AppBar(title: const Text("Fichiers sélectionnés"), elevation: 15),
			body:ListView.builder(
				itemCount: fichiers.length,
				itemBuilder: (context, index){
					final file = fichiers[index];
					final filename = path.basename(file.path);
					return ListTile(
						title: Text(filename),
						leading: Icon(Icons.picture_as_pdf, color: Colors.red),
						onTap: (){
							print("cliqué");
						}
					);
				},
			),
			floatingActionButton: FloatingActionButton(
				onPressed: ()async{
					FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true, type:FileType.custom, allowedExtensions: ['pdf'],);
					setState(() {
						if(result != null){
							List<File> files = result.paths.map((path) => File(path!)).toList();
							fichiers = files;
						}
					});
				},
				child: Icon(Icons.add)
			)
		);
	}
}