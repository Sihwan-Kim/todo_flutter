import 'package:flutter/material.dart';
import 'package:todo_flutter/model.dart';
import 'package:todo_flutter/addwork.dart';
import 'package:provider/provider.dart';
//----------------------------------------------------------------------------
void main() 
{
	runApp
	(
		MultiProvider
		(
			providers: [ ChangeNotifierProvider(create: (_) => ChangeListValue()),],
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
			home: const MainPage(),
		);
	}
}
//----------------------------------------------------------------------------
class MainPage extends StatefulWidget 
{
  const MainPage({super.key,});

  @override
  State<MainPage> createState() => MainPageState();  
}
//----------------------------------------------------------------------------
class MainPageState extends State<MainPage> 
{
  var _visibility = false;  

  set setVisible(value) => setState(() {_visibility = value;});
  get visible => _visibility ;

  @override
	Widget build(BuildContext context)
	{
		return Scaffold
		(
			appBar: AppBar
			(
				backgroundColor: const Color.fromARGB(255, 40, 40, 40),
				title: const Text('List', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
				centerTitle: true,
				leading: const IconButton(icon: Icon(Icons.settings, color: Colors.white,), onPressed: null),
    		actions: 
				[
					TextButton
					(
						style: TextButton.styleFrom(foregroundColor: Colors.white,), 
						onPressed: () 
            { 
              setState(() {_visibility = !_visibility;});
            },
						child: const Text('Edit', style: TextStyle(fontSize: 20, color: Colors.white),), 
					),
				],
			),
			body: ChangeNotifierProvider
			(
				create: (BuildContext context) => ChangeListValue(),  
			 	child: Column
				(
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: 
					[
						const Text('Filter', style: TextStyle(fontSize: 20, color: Colors.grey),),
            Flexible(flex: 2, fit: FlexFit.loose , child: ListViewBuilder(listItems: context.watch<ChangeListValue>().filterItems,),),
						const Text('Work List', style: TextStyle(fontSize: 20, color: Colors.grey),),
            Visibility
            (
              visible: _visibility,
              child: const AppendListWidget(),
            ),
						Flexible(flex: 1, child: WorkListViewBuilder(listItems: context.watch<ChangeListValue>().workList,),),
						Flexible(flex: 1, child: ListViewBuilder(listItems: context.watch<ChangeListValue>().finishWork,),),
					],
				),
			),
			floatingActionButton: FloatingActionButton
			(
        onPressed: () 
				{ 
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AppendList()),);
				},    

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
        child: ItemIdentity(property: listItems[index]),
				onDismissed: (direction) 
				{
					if(direction == DismissDirection.endToStart) 
					{
						context.read<ChangeListValue>().removeAt(index) ;
          }
				},
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
class WorkListViewBuilder extends StatelessWidget
{
	const WorkListViewBuilder({super.key, required this.listItems});
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
        child: WorkListItemIdentity(property: listItems[index]),
				onDismissed: (direction) 
				{
					if(direction == DismissDirection.endToStart) 
					{
						context.read<ChangeListValue>().removeAt(index) ;
          }
				},
			),			
		);
	}
}
//-----------------------------------------------------------------------------------------
class WorkListItemIdentity extends StatelessWidget
{
	const WorkListItemIdentity({super.key, required this.property});
	final ItemProperty property ;

	@override
	Widget build(BuildContext context)
	{
    MainPageState? parent = context.findAncestorStateOfType<MainPageState>(); 

		return Container
		(
			color:const Color.fromARGB(255, 40, 40, 40),
			child: Row
      (
        children :
        [
          Visibility
          (
            visible: parent!.visible ,
            child: const Icon(Icons.delete_forever_outlined, color: Colors.red,),
          ),
          Flexible                      // Flexible에 사용해야지만 에러가 발생하지 않는다. 
          (
            child: ListTile
            (
              leading: property.icon, 
              title: Text(property.name, style: const TextStyle(fontSize: 20, color: Colors.white),),
              trailing: Text
              (
                property.count.toString(), 
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            )
          ), 
        ]
      ),
		);
	}
}
//-----------------------------------------------------------------------------------------
class AppendListWidget extends StatelessWidget
{
	const AppendListWidget({super.key});

	@override
	Widget build(BuildContext context)
	{
    MainPageState? parent = context.findAncestorStateOfType<MainPageState>(); // Main Widget의 State에 접근하기 위해 필요하다. 

		return Container
		(
			color:const Color.fromARGB(255, 40, 40, 40),
			child: ListTile
			(
				leading: const Icon(Icons.add_circle_outline, color: Colors.green),
				title: const Text('Append Work List', style: TextStyle(fontSize: 20, color: Colors.white),),
        onTap: () 
        {
          parent!.setVisible = false ;  
//          Navigator.push(context, MaterialPageRoute(builder: (context) => const AppendList()),); 
        }, 
			) ,
		);
	}
}
//-----------------------------------------------------------------------------------------
