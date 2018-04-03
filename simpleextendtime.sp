#pragma newdecls required
#pragma semicolon 1

#include <sourcemod>
#include <sdktools>

#define PLUGIN_AUTHOR "Ruto"
#define PLUGIN_VERSION "0.01"

public Plugin myinfo = 
{
	name = "Ruto's Simple Extend Time",
	author = PLUGIN_AUTHOR,
	description = "Simple Time Extender for admins",
	version = PLUGIN_VERSION,
	url = "https://github.com/RutoTV/SMSimpleExtendTime"
};

ConVar g_timelimit;

public void OnPluginStart()
{
    RegAdminCmd("sm_extendtime", Command_ExtendTime, ADMFLAG_GENERIC, "Extends the timelimit of the map");
    g_timelimit = FindConVar("mp_timelimit");
}

public Action Command_ExtendTime(int client, int args) 
{
    if (args < 1) 
    {
        PrintToConsole(client, "Usage: sm_extendtime <length,max:9999> or sm_extendtime 0 for infinite until RTV");
        return Plugin_Handled;
    }

    char sarg[6];
    GetCmdArg(1, sarg, sizeof(sarg));
    int length = 0;
    if ((length = StringToInt(sarg)) == 0) 
    {
        PrintToConsole(client, "Usage: sm_extendtime <length,max:9999> or sm_extendtime 0 for infinity until RTV");
        return Plugin_Handled;
    }

    g_timelimit.SetInt(length, false, true);

    return Plugin_Handled;
}