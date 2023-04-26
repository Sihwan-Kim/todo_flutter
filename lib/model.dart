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
  String name ;
  int count ;
  int colorIndex ;

  WorkListProperty(this.name, this.count, this.colorIndex) ;

  Map<String, dynamic> toMap() 
  {
    return 
    {
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
ListValueControl listValueControl = ListValueControl() ;

class ListValueControl with ChangeNotifier
{    
	final List<ItemProperty> _filterItems = [
										                        ItemProperty('Today', 0, const Icon(Icons.arrow_downward, color: Colors.red)),
																			      ItemProperty('Tomorrow', 0, const Icon(Icons.arrow_forward, color: Colors.lightBlue)),
																			      ItemProperty('This Week', 0, const Icon(Icons.window, color: Colors.lightBlue)),
																			      ItemProperty('Unlimitted', 0, const Icon(Icons.calendar_month, color: Colors.lightBlue)),
																			      ItemProperty('All', 0, const Icon(Icons.hive_rounded, color: Colors.lightBlue)),
																 		      ] ;

	final List<ItemProperty> _workList =  [
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
		if(_workList.isNotEmpty && index < _workList.length)   
		{
			_workList.removeAt(index);
			notifyListeners();  
		}
	}
	//-----------------------------------------------------------------------------------------
	void append(WorkListProperty item)
	{
		_workList.add(ItemProperty(item.name, item.count, Icon(Icons.circle, color: WorkListColor[item.colorIndex],) ) );
		notifyListeners();  
	}
} 
//-----------------------------------------------------------------------------------------
 