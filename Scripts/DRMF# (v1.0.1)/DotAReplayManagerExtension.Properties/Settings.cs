using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Configuration;
using System.Diagnostics;
using System.Runtime.CompilerServices;

namespace DotAReplayManagerExtension.Properties
{
	[GeneratedCode("Microsoft.VisualStudio.Editors.SettingsDesigner.SettingsSingleFileGenerator", "12.0.0.0")]
	[CompilerGenerated]
	internal sealed class Settings : ApplicationSettingsBase
	{
		private static Settings defaultInstance = (Settings)SettingsBase.Synchronized(new Settings());

		public static Settings Default => defaultInstance;

		[DefaultSettingValue("DotA Replay Manager Filter # (C-Sharp)")]
		[ApplicationScopedSetting]
		[DebuggerNonUserCode]
		public string Name => (string)this["Name"];

		[ApplicationScopedSetting]
		[DebuggerNonUserCode]
		[DefaultSettingValue("1.0.1 © 2012-2015 aRt)Y / ProjectDRMF@gmail.com")]
		public string Version => (string)this["Version"];

		[DebuggerNonUserCode]
		[UserScopedSetting]
		[DefaultSettingValue("C:\\\\DotAReplayManager.exe")]
		public string DotAReplayManagerPath
		{
			get
			{
				return (string)this["DotAReplayManagerPath"];
			}
			set
			{
				this["DotAReplayManagerPath"] = value;
			}
		}

		[UserScopedSetting]
		[DebuggerNonUserCode]
		[DefaultSettingValue("C:\\\\ReplaySeeker.exe")]
		public string ReplaySeekerPath
		{
			get
			{
				return (string)this["ReplaySeekerPath"];
			}
			set
			{
				this["ReplaySeekerPath"] = value;
			}
		}

		[DebuggerNonUserCode]
		[UserScopedSetting]
		[DefaultSettingValue("C:\\Users\\praktikant\\Desktop\\qlog.exe")]
		public string QlogExePath
		{
			get
			{
				return (string)this["QlogExePath"];
			}
			set
			{
				this["QlogExePath"] = value;
			}
		}

		[SpecialSetting(SpecialSetting.WebServiceUrl)]
		[ApplicationScopedSetting]
		[DefaultSettingValue("http://code.google.com/p/pdrmf/wiki/DRMFsharpReadme")]
		[DebuggerNonUserCode]
		public string Readme => (string)this["Readme"];

		[SpecialSetting(SpecialSetting.WebServiceUrl)]
		[DefaultSettingValue("http://code.google.com/p/pdrmf/wiki/DRMFsharpChangelog")]
		[DebuggerNonUserCode]
		[ApplicationScopedSetting]
		public string Changelog => (string)this["Changelog"];

		[SpecialSetting(SpecialSetting.WebServiceUrl)]
		[ApplicationScopedSetting]
		[DefaultSettingValue("http://entwiki.net/index.php?title=EntGaming:Qlog")]
		[DebuggerNonUserCode]
		public string DownloadQlog => (string)this["DownloadQlog"];

		[UserScopedSetting]
		[DefaultSettingValue("C:\\\\log.txt")]
		[DebuggerNonUserCode]
		public string LogPath
		{
			get
			{
				return (string)this["LogPath"];
			}
			set
			{
				this["LogPath"] = value;
			}
		}

		[DefaultSettingValue("Offline,jarofgreen,test3,test4")]
		[DebuggerNonUserCode]
		[UserScopedSetting]
		public string Keywords
		{
			get
			{
				return (string)this["Keywords"];
			}
			set
			{
				this["Keywords"] = value;
			}
		}

		[DefaultSettingValue("0")]
		[DebuggerNonUserCode]
		[UserScopedSetting]
		public int Installed
		{
			get
			{
				return (int)this["Installed"];
			}
			set
			{
				this["Installed"] = value;
			}
		}

		private void SettingChangingEventHandler(object sender, SettingChangingEventArgs e)
		{
		}

		private void SettingsSavingEventHandler(object sender, CancelEventArgs e)
		{
		}
	}
}
