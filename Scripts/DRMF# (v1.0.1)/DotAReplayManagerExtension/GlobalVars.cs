namespace DotAReplayManagerExtension
{
	internal class GlobalVars
	{
		private static string _ActionLog = "";

		private static string _LogPath;

		private static string _LogContent;

		private static bool _replaceIDs;

		private static int _MaxIndex;

		private static string _Playerlist;

		public static string ActionLog
		{
			get
			{
				return _ActionLog;
			}
			set
			{
				_ActionLog = value;
			}
		}

		public static string LogPath
		{
			get
			{
				return _LogPath;
			}
			set
			{
				_LogPath = value;
			}
		}

		public static string LogContent
		{
			get
			{
				return _LogContent;
			}
			set
			{
				_LogContent = value;
			}
		}

		public static bool replaceIDs
		{
			get
			{
				return _replaceIDs;
			}
			set
			{
				_replaceIDs = value;
			}
		}

		public static int MaxIndex
		{
			get
			{
				return _MaxIndex;
			}
			set
			{
				_MaxIndex = value;
			}
		}

		public static string Playerlist
		{
			get
			{
				return _Playerlist;
			}
			set
			{
				_Playerlist = value;
			}
		}
	}
}
