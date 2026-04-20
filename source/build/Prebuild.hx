package source.build; // seriously?...

import haxe.Json;
import hxp.*;
import lime.tools.*;
import sys.io.File;
import sys.io.Process;

using StringTools;

class Prebuild
{
	public static function main()
	{
		trace("Prebuild script running...");

		logFlags();

		var gitBranch = getGitBranch();
		var gitCommit = getGitCommit();
		var gitDirty = getGitDirty();

		trace('Git Branch: ' + gitBranch);
		trace('Git Commit: ' + gitCommit);
		trace('Git Modified: ' + gitDirty);

		generateBuildInfo(gitBranch, gitCommit, gitDirty);

		trace("Prebuild script done! Onto building the game!");
	}

	static function logFlags()
	{
		#if FEATURE_DISCORD_RPC
		trace("FEATURE_DISCORD_RPC: ON");
		#else
		trace("FEATURE_DISCORD_RPC: OFF");
		#end
	}

	static function generateBuildInfo(branch:String, commit:String, dirty:Bool)
	{
		var data = {
			version: "TEMPLATE",
			buildTime: Date.now().toString(),
			gitBranch: branch,
			gitCommit: commit,
			gitDirty: dirty
		};

		File.saveContent("assets/build.json", Json.stringify(data, "\t"));
	}

	static function getGitCommit():String
	{
		return runGit(["rev-parse", "--short", "HEAD"]);
	}

	static function getGitBranch():String
	{
		return runGit(["rev-parse", "--abbrev-ref", "HEAD"]);
	}

	static function getGitDirty():Bool
	{
		var result = runGit(["status", "--porcelain"]);
		return result.length > 0;
	}

	static function runGit(args:Array<String>):String
	{
		try
		{
			var proc = new Process("git", args);
			var output = proc.stdout.readAll().toString().trim();
			proc.close();
			return output;
		}
		catch (e)
		{
			return "unknown";
		}
	}
}