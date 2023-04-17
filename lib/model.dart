import 'package:flutter/material.dart';

List<Color> WorkListColor = [Colors.red, Colors.yellow, Colors.green, Colors.blue, Colors.purple] ;
enum FilterType 
{ 
	filterToday(0), filterTomorrow(1), filterWeek(2), filterUnlimit(3), filterAll(4) ;
	final int num;
	const FilterType(this.num);
}
//-----------------------------------------------------------------------------------------
class WorkListProperty
{
  final int id;
  final String name ;
  final int count ;
  final int colorIndex ;

  WorkListProperty({required this.id, required this.name, required this.count,required this.colorIndex}) ;

  Map<String, dynamic> toMap() 
  {
    return 
    {
      'id': id,
      'name': name,
      'count': count,
      'colorindex' : colorIndex,
    };
  }
}
//-----------------------------------------------------------------------------------------
class ItemProperty 
{
	String name ;
	int count ;
	Icon icon ;

	ItemProperty(this.name, this.count, this.icon) ;
}
//-----------------------------------------------------------------------------------------
class ChangeCountValue with ChangeNotifier
{    
	final List<ItemProperty> _filterItems = [
										                  ItemProperty('Today', 0, const Icon(Icons.arrow_downward, color: Colors.red)),
																			ItemProperty('Tomorrow', 0, const Icon(Icons.arrow_forward, color: Colors.lightBlue)),
																			ItemProperty('This Week', 0, const Icon(Icons.window, color: Colors.lightBlue)),
																			ItemProperty('Unlimitted', 0, const Icon(Icons.calendar_month, color: Colors.lightBlue)),
																			ItemProperty('All', 0, const Icon(Icons.hive_rounded, color: Colors.lightBlue)),
																 		    ] ;

	final List<ItemProperty> _workList = [
		 								                  ItemProperty('My Work', 0, const Icon(Icons.circle, color: Colors.lightBlue),),
								 			                ItemProperty('Purchase', 0, const Icon(Icons.circle, color: Colors.red),),
										                  ] ;

	final List<ItemProperty>  _finishWork = [ ItemProperty('Finish', 0, const Icon(Icons.check_circle_outline, color: Colors.lightBlue)),];

	List<ItemProperty> get filterItems => _filterItems ;
	List<ItemProperty> get workList => _workList ;
	List<ItemProperty> get finishWork => _finishWork ;
	//-----------------------------------------------------------------------------------------
	void changeFilterCount(FilterType type, int value)
	{
		_filterItems[type.num].count = value ;
		notifyListeners();  
	}
	//-----------------------------------------------------------------------------------------
	void removeAt(int index)
	{
		if(index >= 2)   // 0,1 은 지우지 않는다.
		{
			_workList.remove(index) ;
			notifyListeners();  
		}
	}
	//-----------------------------------------------------------------------------------------
	void Append(ItemProperty Item)
	{
		_workList.add(Item) ;
		notifyListeners();  
	}
} 
//-----------------------------------------------------------------------------------------
 