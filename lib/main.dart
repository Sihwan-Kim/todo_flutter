import 'package:flutter/material.dart';
import 'package:todo_flutter/model.dart';
import 'package:todo_flutter/viewmodel.dart';
import 'package:todo_flutter/addwork.dart';
import 'package:provider/provider.dart';
//----------------------------------------------------------------------------
void main() 
{
	runApp
	(
		MultiProvider
		(
			providers: [ ChangeNotifierProvider(create: (_) => ChangeCountValue()),],
			child: const MyToDoApp(),
		),
  );
}
//----------------------------------------------------------------------------
class MyToDoApp extends StatelessWidget 
{
	const MyToDoApp({super.key});

	@override
	Widget build(BuildContext context) 
	{
		return MaterialApp
		(
      builder: (context, child) 
      {
        return MediaQuery
        (
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child!,
        );
      },  
			title: 'ToDo Application',
			theme: ThemeData( primarySwatch: Colors.blue,),
			home: const MainPage(title: 'List'),
		);
	}
}
//----------------------------------------------------------------------------
class MainPage extends StatelessWidget 
{
  const MainPage({super.key, required this.title});
  final String title;

  @override
	Widget build(BuildContext context)
	{
		return Scaffold
		(
			appBar: AppBar
			(
				backgroundColor: const Color.fromARGB(255, 40, 40, 40),
				title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
				centerTitle: true,
				leading: const IconButton(icon: Icon(Icons.settings, color: Colors.white,), onPressed: null),
    		actions: 
				[
					TextButton
					(
						style: TextButton.styleFrom(foregroundColor: Colors.white,), 
						onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => AppendList()),);},
						child: const Text('Edit', style: TextStyle(fontSize: 20, color: Colors.white),), 
					),
				],
			),
			body: ChangeNotifierProvider
			(
				create: (BuildContext context) => ChangeCountValue(),
			 	child: Column
				(
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: 
					[
						const Text('Filter', style: TextStyle(fontSize: 20, color: Colors.grey),),
						Expanded(flex: 2, child: ListViewBuilder(listItems: context.watch<ChangeCountValue>().filterItems,),),
						const Text('Work List', style: TextStyle(fontSize: 20, color: Colors.grey),),
						Expanded(flex: 2, child: ListViewBuilder(listItems: context.watch<ChangeCountValue>().workList,),),
						Expanded(flex: 1, child: ListViewBuilder(listItems: context.watch<ChangeCountValue>().finishWork,),),
					],
				),
			),
			floatingActionButton: FloatingActionButton
			(
        onPressed: () async
				{ 
					// context.read<ChangeCountValue>().changeFilterCount(FilterType.filterToday, 10); 
//					context.read<ChangeCountValue>().Append(ItemProperty('test', 0, const Icon(Icons.circle, color: Colors.yellow)));
          await DatabaseHelper().initDB();
				},   // debug 

        backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.add, size: 40,),
      ),
			backgroundColor: Colors.black,
		);
	}
}
//----------------------------------------------------------------------------
class ListViewBuilder extends StatelessWidget
{
	const ListViewBuilder({super.key, required this.listItems});
	final List<ItemProperty>  listItems ;

	@override
	Widget build(BuildContext context)
	{
		return ListView.builder
		(
			itemCount: listItems.length, //리스트의 개수
			itemBuilder: (BuildContext context, int index) => Dismissible
			(
        key: Key(listItems[index].name),
				onDismissed: (direction) 
				{
					if(direction == DismissDirection.endToStart) 
					{
						context.read<ChangeCountValue>().removeAt(index) ;
          }
				},
				child: ItemIdentity(property: listItems[index]),
			),			
		);
	}
}
//-----------------------------------------------------------------------------------------
class ItemIdentity extends StatelessWidget
{
	const ItemIdentity({super.key, required this.property});
	final ItemProperty property ;

	@override
	Widget build(BuildContext context)
	{
		return Container
		(
			color:const Color.fromARGB(255, 40, 40, 40),
			child: ListTile
			(
				leading: property.icon,
				title: Text(property.name, style: const TextStyle(fontSize: 20, color: Colors.white),),
				trailing: Text
				(
					property.count.toString(), 
					style: const TextStyle(fontSize: 20, color: Colors.white),
				), 
			) ,
		);
	}
}
//-----------------------------------------------------------------------------------------
