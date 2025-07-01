import "package:flutter/material.dart";
import "package:file_picker/file_picker.dart";
import 'dart:io';
import 'package:path/path.dart' as path;
import "package:pdfx/pdfx.dart";

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
	File? fichier;

	Widget buildSelector(BuildContext){
		return Scaffold(
				appBar: AppBar(title: const Text("Fichiers sélectionnés"), elevation: 15),
				body: fichiers.length > 0 ? ListView.builder(
					itemCount: fichiers.length,
					itemBuilder: (context, index){
						final file = fichiers[index];
						final filename = path.basename(file.path);
						return ListTile(
								title: Text(filename),
								leading: Icon(Icons.picture_as_pdf, color: Colors.red),
								onTap: (){
									setState(() {
										fichier = file;
									});
								}
						);
					},
				): Text("No file selected"),
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

	@override
	Widget buildReader(BuildContext context){
		PdfControllerPinch pcp = PdfControllerPinch(document: PdfDocument.openFile(fichier!.path));

		return Scaffold(
			appBar: AppBar(title: const Text("Reader"), elevation: 15),
			body:Column(children: [
				Expanded(child: PdfViewPinch(controller: pcp))
			]),
			floatingActionButton: FloatingActionButton(
					onPressed: (){
						setState(() {
						  fichier = null;
						});
					},
					child:Icon(Icons.folder)
			),
		);
	}

	@override
	Widget build(BuildContext context){
		if(fichier == null){
			return buildSelector(context);
		}else{
			return buildReader(context);
		}
	}
}