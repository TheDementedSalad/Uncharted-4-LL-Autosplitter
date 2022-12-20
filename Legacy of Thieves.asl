//Uncharted: Legacy of Thieves Collection Autosplitter v 1.0.6 19/12/2022
//Supports IGT and Autosplits for both Uncharted 4 & Lost Legacy
//Script by TheDementedSalad & Mattmatt


state("u4", "u4 Patch 1")
{
	byte menu			: 0x3D82C78;
	int IGT				: 0x3B7CA90;
	string2 chapter		: 0x358D778, 0x34;
}

state("u4", "u4 Patch 2")
{
	byte menu			: 0x3D860D8;
	int IGT				: 0x3B7FF10;
	string2 chapter		: 0x3590BF8, 0x34;
}

state("tll", "tll Patch 1")
{
	byte menu			: 0x3F2CC88;
	int IGT				: 0x37EB308;
	string2 chapter		: 0x3728B78, 0x34;
}

state("tll", "tll Patch 2")
{
	byte menu			: 0x3F2E168;
	int IGT				: 0x37EC808;
	string2 chapter		: 0x3729FF8, 0x34;
}

start
{
	return current.IGT > 0 && old.IGT == 0 && current.chapter == "Ne" && current.menu == 0;
}

startup
{
	vars.completedSplits = new List<string>();
	
	vars.splits = new List<string>()
	{"1.","2.","3.","4.","5.","6.","7.","8.","9.","10","11","12","13","14","15","16","17","18","19","20","21","22","Ep","CO"};
}

init
{
	switch (modules.First().ModuleMemorySize)
	{
		case (115699712):
			version = "u4 Patch 1";
			break;
		case (115712000):
			version = "u4 Patch 2";
			break;
		case (117776384):
			version = "tll Patch 1";
			break;
		case (117780480):
			version = "tll Patch 2";
			break;
	}
}

update
{
	//print(modules.First().ModuleMemorySize.ToString());
	
	if(timer.CurrentPhase == TimerPhase.NotRunning)
	{
		vars.completedSplits.Clear();
	}
}

split
{
	if (current.chapter != old.chapter && vars.splits.Contains(current.chapter) && !vars.completedSplits.Contains(current.chapter)){
		vars.completedSplits.Add(current.chapter);
		return true;
	}
	
}

isLoading
{
	return true;
}

gameTime
{
	return TimeSpan.FromMilliseconds(current.IGT);
}

reset
{
	return current.IGT > 0 && old.IGT == 0 && current.chapter == "Ne" && current.menu == 0;
}
