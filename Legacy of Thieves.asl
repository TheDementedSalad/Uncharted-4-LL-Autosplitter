//Uncharted: Legacy of Thieves Collection Autosplitter v 2.0 31 March 2024
//Supports IGT and Autosplits for both Uncharted 4 & Lost Legacy
//Script by TheDementedSalad
//Original Pointers by Mattmatt

state("u4", "Uncharted 4"){}
state("tll", "tll Patch 1"){}

startup
{
	Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
	
	vars.completedSplits = new List<string>();
	
	vars.splits = new List<string>()
	{"1.","2.","3.","4.","5.","6.","7.","8.","9.","10","11","12","13","14","15","16","17","18","19","20","21","22","Ep","CO"};
}

init
{
	IntPtr InGameTime = vars.Helper.ScanRel(3, "48 89 05 ?? ?? ?? ?? 89 05 ?? ?? ?? ?? 8b de");
	IntPtr CurrLevel = vars.Helper.ScanRel(3, "48 8b 05 ?? ?? ?? ?? 48 89 05 ?? ?? ?? ?? 48 8d 05 ?? ?? ?? ?? 48 89 44 24");

	vars.Helper["IGT"] = vars.Helper.Make<int>(InGameTime);
	vars.Helper["Level"] = vars.Helper.MakeString(CurrLevel, 0x34);

	
	if (InGameTime == IntPtr.Zero || CurrLevel == IntPtr.Zero)
	{
		const string Msg = "Not all required addresses could be found by scanning.";
		throw new Exception(Msg);
	}
}

update
{
	//print(modules.First().ModuleMemorySize.ToString());
	vars.Helper.Update();
	vars.Helper.MapPointers();

	
	if(timer.CurrentPhase == TimerPhase.NotRunning)
	{
		vars.completedSplits.Clear();
	}
	
	current.Lvl = current.Level.Substring(0, 2);
}

start
{
	return current.IGT > 0 && old.IGT == 0 && current.Lvl == "Ne";
}

split
{
	if (current.Lvl != old.Lvl && vars.splits.Contains(current.Lvl) && !vars.completedSplits.Contains(current.Lvl)){
		vars.completedSplits.Add(current.Lvl);
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
	return current.IGT > 0 && old.IGT == 0 && current.Lvl == "Ne";
}
