using DotAReplayManagerExtension.Properties;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Windows.Forms;

namespace DotAReplayManagerExtension
{
	public class guiMain : Form
	{
		private Form _guiMainSettings;

		private IContainer components = null;

		private CheckBox guiMainID_checkboxSyncFree;

		private RadioButton guiMainID_radioCommands;

		private RadioButton guiMainID_radioShare;

		private RadioButton guiMainID_radioSpells;

		private RadioButton guiMainID_radioPings;

		private RadioButton guiMainID_radioItemUsage;

		private RadioButton guiMainID_radioDetonation;

		private RadioButton guiMainID_radioSubgroups;

		private RadioButton guiMainID_radioChangeSelections;

		private RadioButton guiMainID_radioClicksOnGround;

		private RadioButton guiMainID_radioBuildingsTargeted;

		private TableLayoutPanel tableLayoutPanel3;

		private Label label2;

		private Label label3;

		private RadioButton guiMainID_radioTitan;

		private RadioButton guiMainID_radioBuilders;

		private RadioButton guiMainID_radioNeutrals;

		private Button guiMainID_cmdFilter;

		private ComboBox guiMainID_comboboxPlayerlist;

		private ToolTip guiMainID_tooltipPlayerlist;

		private LinkLabel guiMainID_LinkLog;

		private ProgressBar guiMainID_ProgessBar;

		private BackgroundWorker guiMainID_ProgessBarIndex;

		private ToolTip guiMainID_ToolTipLogPath;

		private RadioButton guiMainID_radioGroupHotkey;

		private RadioButton guiMainID_radioHeroes;

		private RadioButton guiMainID_radioCouriers;

		private RadioButton guiMainID_radioScourge;

		private RadioButton guiMainID_radioSentinel;

		private Label label4;

		private ComboBox guiMainID_HeroSpecificBox;

		private RadioButton guiMainID_radioAntistuck;

		private RadioButton guiMainID_radioUnitsTowers;

		private RadioButton guiMainID_radioHeroSpecific;

		private ComboBox guiMainID_Genre;

		private RadioButton guiMainID_radioboxShift;

		private RadioButton guiMainID_radioboxEverything;

		private ContextMenuStrip TrayIconMenu;

		private ToolStripMenuItem TrayIconMenu_Information;

		private ToolStripMenuItem TrayIconMenu_Readme;

		private ToolStripMenuItem TrayIconMenu_Changelog;

		private ToolStripMenuItem TrayIconMenu_Exit;

		public NotifyIcon TrayIcon;

		public guiMain()
		{
			InitializeComponent();
			guiMainID_cmdFilter.Enabled = false;
			AllowDrop = true;
			GlobalVars.replaceIDs = !GlobalVars.replaceIDs;
			GlobalVars.LogPath = Settings.Default.LogPath;
			guiMainID_LinkLog.Text = GlobalVars.LogPath;
			guiMainID_ToolTipLogPath.SetToolTip(guiMainID_LinkLog, GlobalVars.LogPath.ToString());
			MenuForm();
			if (Settings.Default.Installed == 0)
			{
				string version = Settings.Default.Version;
				string name = Settings.Default.Name;
				DialogResult dialogResult = MessageBox.Show("Welcome to the " + name + "\n\n(" + version + ").\nhttp://code.google.com/p/pdrmf/\n\nHow it works:\nAfter clicking Ok, open the settings which you can find in the menu and only select the path for the qlog.exe. Once you closed the settings, drag and drop a replay or log.txt on the DRMF# and enjoy.\n\nThis tool does not need the Log, DotA Replay Manager or Replay Seeker paths, however, you can add them to allow a quick launch.", "DRMF# Information", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
				if (dialogResult == DialogResult.OK)
				{
					Settings.Default.Installed = 1;
					Settings.Default.Save();
				}
			}
		}

		public void MenuForm()
		{
			MainMenu mainMenu = new MainMenu();
			MenuItem menuItem = new MenuItem("&Tools");
			mainMenu.MenuItems.Add(menuItem);
			MenuItem menuItem2 = new MenuItem("ID Replacements");
			mainMenu.MenuItems.Add(menuItem2);
			MenuItem menuItem3 = new MenuItem("&Miscellaneous");
			mainMenu.MenuItems.Add(menuItem3);
			MenuItem menuItem4 = new MenuItem("&Settings");
			mainMenu.MenuItems.Add(menuItem4);
			MenuItem menuItem5 = new MenuItem("DotA Replay &Manager");
			menuItem.MenuItems.Add(menuItem5);
			MenuItem menuItem6 = new MenuItem("Replay &Seeker");
			menuItem.MenuItems.Add(menuItem6);
			MenuItem menuItem7 = new MenuItem("&Download Qlog.exe");
			menuItem.MenuItems.Add(menuItem7);
			MenuItem menuItem8 = new MenuItem("&Feedback");
			menuItem3.MenuItems.Add(menuItem8);
			MenuItem menuItem9 = new MenuItem("&Update");
			menuItem3.MenuItems.Add(menuItem9);
			MenuItem menuItem10 = new MenuItem("&Readme");
			menuItem3.MenuItems.Add(menuItem10);
			menuItem5.Click += DRMmenuClicked;
			menuItem6.Click += ReplaySeekerMenuClicked;
			menuItem7.Click += DLqlogMenuClicked;
			menuItem2.Click += IDreplacementsMenuClicked;
			menuItem8.Click += FeedbackMenuClicked;
			menuItem9.Click += UpdateMenuClicked;
			menuItem10.Click += ReadmeMenuClicked;
			menuItem4.Click += SettingsMenuClicked;
			base.Menu = mainMenu;
		}

		private void DRMmenuClicked(object sender, EventArgs e)
		{
			string dotAReplayManagerPath = Settings.Default.DotAReplayManagerPath;
			try
			{
				Process.Start(dotAReplayManagerPath);
			}
			catch (Exception arg)
			{
				MessageBox.Show("The DotA Replay Manager path does not exist.\n\n" + arg, "DRMF# Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
			}
		}

		private void ReplaySeekerMenuClicked(object sender, EventArgs e)
		{
			string replaySeekerPath = Settings.Default.ReplaySeekerPath;
			try
			{
				Process.Start(replaySeekerPath);
			}
			catch (Exception arg)
			{
				MessageBox.Show("The Replay Seeker path does not exist.\n\n" + arg, "DRMF# Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
			}
		}

		private void DLqlogMenuClicked(object sender, EventArgs e)
		{
			string downloadQlog = Settings.Default.DownloadQlog;
			try
			{
				Process.Start(downloadQlog);
			}
			catch (Exception ex)
			{
				MessageBox.Show("Starting the qlog download page does not seem to work.\nYou can access it manually here: " + downloadQlog + "\n\n" + ex, "DRMF# Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
			}
		}

		private void IDreplacementsMenuClicked(object sender, EventArgs e)
		{
			GlobalVars.replaceIDs = !GlobalVars.replaceIDs;
			TrayIcon.BalloonTipIcon = ToolTipIcon.Info;
			TrayIcon.BalloonTipTitle = "DRMF# Information";
			TrayIcon.BalloonTipText = "IDs are being replaced: " + GlobalVars.replaceIDs;
			TrayIcon.ShowBalloonTip(3000);
		}

		private void SettingsMenuClicked(object sender, EventArgs e)
		{
			_guiMainSettings = new guiSettings();
			_guiMainSettings.FormClosed += _guiMainSettings_FormClosed;
			_guiMainSettings.ShowDialog();
		}

		private void _guiMainSettings_FormClosed(object sender, EventArgs e)
		{
		}

		private void FeedbackMenuClicked(object sender, EventArgs e)
		{
			Process.Start("mailto:ProjectDRMF@gmail.com?subject=DRMF_Feedback&Body=Hello_aRt)Y,");
		}

		private void UpdateMenuClicked(object sender, EventArgs e)
		{
			string changelog = Settings.Default.Changelog;
			try
			{
				Process.Start(changelog);
			}
			catch (Exception ex)
			{
				MessageBox.Show("Starting the changelog page does not seem to work.\nYou can access it manually here: " + changelog + "\n\n" + ex, "DRMF# Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
			}
		}

		private void ReadmeMenuClicked(object sender, EventArgs e)
		{
			string readme = Settings.Default.Readme;
			try
			{
				Process.Start(readme);
			}
			catch (Exception ex)
			{
				MessageBox.Show("Starting the readme page does not seem to work.\nYou can access it manually here: " + readme + "\n\n" + ex, "DRMF# Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
			}
		}

		private void guiMainID_droppedFile(object sender, DragEventArgs e)
		{
			string[] array = (string[])e.Data.GetData(DataFormats.FileDrop);
			string[] array2 = array;
			foreach (string text in array2)
			{
				string extension = Path.GetExtension(text);
				switch (extension)
				{
				case ".txt":
					guiMainID_comboboxPlayerlist.Text = "Loading log & playerlist. This may take some seconds.";
					Refresh();
					GlobalVars.LogPath = text;
					guiMainID_LinkLog.Text = GlobalVars.LogPath;
					guiMainID_ToolTipLogPath.SetToolTip(guiMainID_LinkLog, GlobalVars.LogPath.ToString());
					Settings.Default.LogPath = text;
					GeneratePlayerlist(GlobalVars.LogPath);
					if (guiMainID_Genre.Text != "")
					{
						guiMainID_cmdFilter.Enabled = true;
					}
					break;
				case ".w3g":
				{
					string qlogExePath = Settings.Default.QlogExePath;
					if (File.Exists(qlogExePath))
					{
						string directoryName = Path.GetDirectoryName(text);
						GlobalVars.LogPath = directoryName + "\\log.txt";
						File.Delete(GlobalVars.LogPath);
						try
						{
							guiMainID_comboboxPlayerlist.Text = "Loading log & playerlist. This may take some seconds.";
							ProcessStartInfo processStartInfo = new ProcessStartInfo();
							processStartInfo.WindowStyle = ProcessWindowStyle.Hidden;
							processStartInfo.FileName = qlogExePath;
							processStartInfo.Arguments = text;
							processStartInfo.WorkingDirectory = directoryName;
							Process.Start(processStartInfo).WaitForExit();
							guiMainID_LinkLog.Text = GlobalVars.LogPath;
							GlobalVars.LogContent = File.ReadAllText(GlobalVars.LogPath);
							guiMainID_comboboxPlayerlist.Enabled = false;
							GeneratePlayerlist(GlobalVars.LogPath);
							if (guiMainID_Genre.Text != "")
							{
								guiMainID_cmdFilter.Enabled = true;
							}
						}
						catch
						{
							MessageBox.Show("There was an issue reading the replay via qlog.exe", "DRMF# Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
						}
					}
					else
					{
						MessageBox.Show("qlog.exe does not exist.", "DRMF# Error", MessageBoxButtons.OK, MessageBoxIcon.Hand);
					}
					break;
				}
				default:
					MessageBox.Show(extension + " is an invalid extension.\n\nOnly .txt and .w3g files are allowed.", "DRMF# Information", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
					break;
				}
			}
		}

		private void guiMainID_draggedFile(object sender, DragEventArgs e)
		{
			if (e.Data.GetDataPresent(DataFormats.FileDrop))
			{
				e.Effect = DragDropEffects.Copy;
			}
		}

		private void guiMainID_cmdFilter_Click(object sender, EventArgs e)
		{
			GlobalVars.LogContent = File.ReadAllText(GlobalVars.LogPath);
			GlobalVars.ActionLog = "";
			if (guiMainID_HeroSpecificBox.Text.Contains("="))
			{
				MessageBox.Show("Please select a hero and not a category.", "DRMF# Information", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
				return;
			}
			if (guiMainID_comboboxPlayerlist.Text == "" && guiMainID_radioboxEverything.Checked)
			{
				MessageBox.Show("Please enter a player name or a search query.", "DRMF# Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				return;
			}
			Console.WriteLine("Prepare string arrays.");
			string[] keywords = new string[14]
			{
				"Give item",
				"0x000D002A",
				"0x000D002B",
				"0x000D002C",
				"0x000D002D",
				"0x000D0021",
				"0x000D0022",
				"0x000D0023",
				"0x000D0024",
				"0x000D0025",
				"0x000D0026",
				"0x000D0027",
				"0x000D0028",
				"0x000D0029"
			};
			string[] keywords2 = new string[2]
			{
				"0x1C",
				"object=0xFFFFFFFFFFFFFFFF"
			};
			string[] array = new string[27]
			{
				"h037",
				"h00X",
				"h009",
				"h04I",
				"h007",
				"O01Q",
				"h043",
				"h00Q",
				"u00I",
				"u009",
				"h01T",
				"h049",
				"h02S",
				"u00W",
				"h008",
				"h021",
				"h023",
				"h03K",
				"h01B",
				"h035",
				"h01O",
				"n00W",
				"n01G",
				"n00X",
				"n01M",
				"n01N",
				"n01O"
			};
			string[] keywords3 = new string[60]
			{
				"u010",
				"E016",
				"h004",
				"h001",
				"n01B",
				"n01A",
				"n01U",
				"n01V",
				"n01W",
				"n01X",
				"u015",
				"n00C",
				"n019",
				"n018",
				"h02E",
				"A043",
				"n008",
				"u008",
				"n00B",
				"nske",
				"A06R",
				"u00R",
				"u00C",
				"u000",
				"u00Z",
				"u005",
				"u006",
				"u00H",
				"u002",
				"n007",
				"h018",
				"h005",
				"h017",
				"h019",
				"U00B",
				"U00D",
				"U007",
				"U013",
				"U00Q",
				"U012",
				"U00G",
				"U00Y",
				"U004",
				"U003",
				"U001",
				"U016",
				"E016",
				"E00K",
				"E00I",
				"E00J",
				"E00E",
				"E00F",
				"E00B",
				"E00C",
				"E01D",
				"E018",
				"E00O",
				"n00Z",
				"n00M",
				"E015"
			};
			string[] array2 = new string[14]
			{
				"E016",
				"E00K",
				"E00I",
				"E00J",
				"E00E",
				"E00F",
				"E00B",
				"E00C",
				"E01D",
				"E018",
				"E00O",
				"n00Z",
				"n00M",
				"E015"
			};
			string[] array3 = new string[12]
			{
				"U00B",
				"U00D",
				"U007",
				"U013",
				"U00Q",
				"U012",
				"U00G",
				"U00Y",
				"U004",
				"U003",
				"U001",
				"U016"
			};
			string[] array4 = new string[14]
			{
				"H00S",
				"H00N",
				"H00O",
				"H00M",
				"H00Z",
				"H020",
				"H039",
				"H03D",
				"H04K",
				"H046",
				"H04C",
				"H04D",
				"H04K",
				"H02L"
			};
			string[] array5 = new string[17]
			{
				"e014",
				"h01X",
				"h038",
				"h033",
				"h02T",
				"h03H",
				"h03F",
				"h022",
				"h044",
				"h04A",
				"h00Y",
				"h00W",
				"h00A",
				"h00C",
				"h00B",
				"h04F",
				"h01A"
			};
			string[] keywords4 = new string[27]
			{
				"id='n00Y",
				"id='nskk",
				"id='ncrb",
				"id='nech",
				"id='nfro",
				"id='necr",
				"id='nrac",
				"id='nhmc",
				"id='nalb",
				"id='npng",
				"id='npnw",
				"id='nrat",
				"id='nsno",
				"id='nfbr",
				"id='n00H",
				"id='n00J",
				"id='n011",
				"id='n00Q",
				"id='n00T",
				"id='n020",
				"id='n023",
				"id='n012",
				"id='nd0g",
				"id='npig",
				"id='nshe",
				"id='nshf",
				"id='nshw"
			};
			string[] array6 = new string[16]
			{
				"n00F",
				"n00G",
				"n00E",
				"n00D",
				"e01A",
				"h04E",
				"I00F",
				"h04G",
				"n01I",
				"n014",
				"n001",
				"H04R",
				"H04P",
				"A0JG",
				"A0J5",
				"A0JF"
			};
			string[] keywords5 = new string[24]
			{
				"id='n002",
				"id='uC74",
				"id='ncop",
				"id='n00V",
				"id='u010",
				"id='n0HE",
				"id='n01K",
				"id='nC38",
				"id='u00Z",
				"id='n009",
				"id='n00W",
				"id='n00X",
				"id='n0GJ",
				"id='n01P",
				"id='n007",
				"id='n01N",
				"id='n008",
				"id='n01B",
				"id='n005",
				"id='n01D",
				"id='n0GK",
				"id='n0LH",
				"id='n0LI",
				"id='n0LJ"
			};
			string[] keywords6 = new string[34]
			{
				"id='n00L",
				"id='njga",
				"id='njg1",
				"id='nbwm",
				"id='nbdk",
				"id='n0LC",
				"id='n0LD",
				"id='nbdo",
				"id='nbds",
				"id='nfpu",
				"id='nfpc",
				"id='ngh1",
				"id='npfl",
				"id='ncen",
				"id='ncnk",
				"id='ndtw",
				"id='ndtr",
				"id='nftb",
				"id='nkol",
				"id='n00S",
				"id='nwlg",
				" id='nowe",
				"id='nowb",
				"id='n0HW",
				"id='n0HX",
				"id='nstl",
				"id='nsth",
				"id='nsat",
				"id='nfsh",
				"id='nomg",
				"id='nogm",
				"id='n026",
				"id='ngns",
				"id='nomg"
			};
			string[] keywords7 = new string[114]
			{
				"Admiral",
				"Beastmaster",
				"Centaur Warchief",
				"Earthshaker",
				"Earth Spirit",
				"Omniknight",
				"Pandaren Brewmaster",
				"Rogue Knight",
				"Tiny",
				"Stone Giant",
				" Tauren Chieftain",
				"Treant Protector",
				"Guadian Wisp",
				"Alchemist",
				"Clockwerk Goblin",
				"Dragon Knight",
				"Sacred Warrior",
				"Bristleback",
				"Phoenix",
				"Tuskarr",
				"Legion Commander",
				"Goblin Shredder",
				"Axe",
				"Chaos Knight",
				"Doom Bringer",
				"Lifestealer",
				"Lord of Avernus",
				"Lycanthrope",
				"Night Stalker",
				"Pit Lord",
				"Butcher",
				"Skeleton King",
				"Slithereen Guard",
				"Undying",
				"Tidehunter",
				"Magnataur",
				"Spiritbreaker",
				"Sand King",
				"Anti-Mage",
				"Dwarven Sniper",
				"Juggernaut",
				"Lone Druid",
				"Moon Rider",
				"Morphling",
				"Slithice",
				"Phantom Lancer",
				"Priestess of the Moon",
				"Stealth assassin",
				"Arc Warden",
				"Troll Warlord",
				"Gyrocopter",
				"Drow Ranger",
				"Templar Assassin",
				"Ursa Warrior",
				"Vengeful",
				"Bounty Hunter",
				"Ember Spirit",
				"Bloodseeker",
				"Bone Fletcher",
				"Broodmother",
				"Nerubian Assassin",
				"Nerubian Weaver",
				"Phantom Assassin",
				"Shadow Fiend",
				"Soul Keeper",
				"Spectre",
				"Venomancer",
				"Nehterdrake",
				"Geomancer",
				"Lightning Revenant",
				"Murloc Nightcrawler",
				"Faceless Void",
				"Gorgon",
				"Crystal Maiden",
				"Enchantress",
				"Faerie Dragon",
				"Holy Knight",
				"Keeper of the Light",
				"Lord of Olympus",
				"Prophet",
				"Silencer",
				"Slayer",
				"Storm Spirit",
				"Windrunner",
				"Disruptor",
				"Ogre Magi",
				"Goblin Techies",
				"Twin Head Dragon",
				"Tinker",
				"Shadow Shaman",
				"Grand Magus",
				"Skywrath Mage",
				"Bane Elemental",
				"Dark Seer",
				"Death Prophet",
				"Demon Witch",
				"Enigma",
				"Lich",
				"Necrolyte",
				"Oblivion",
				"Obsidian Destroyer",
				"Queen of Pain",
				"Warlock",
				"Shadow Demon",
				"Batrider",
				"Shadow Priest",
				"Invoker",
				"Necro'lic",
				"Tormented Soul",
				"Vol'Jin",
				"Ancient Apparition",
				"Winter Wyvern",
				"Guardian Wisp",
				"Oracle"
			};
			string[] keywords8 = new string[3]
			{
				"id='nfoh",
				"id='e025",
				"id='hC95"
			};
			string[] keywords9 = new string[3]
			{
				"id='nC35",
				"id='u00Q",
				"id='ndfl"
			};
			string[] keywords10 = new string[16]
			{
				"id='n00M",
				"id='n0HV",
				"id='e02S",
				"id='h02F",
				"id='h03Q",
				"id='e02R",
				"id='e02T",
				"id='e030",
				"id='e01H",
				"id='n0LE",
				"id='n00I",
				"id='n0M4",
				"id='n021",
				"id='n022",
				"id='n0KY",
				"id='e01Z"
			};
			string[] keywords11 = new string[2]
			{
				"ancestralspirit",
				"0x000D020A"
			};
			string[] keywords12 = new string[23]
			{
				"id='h023",
				"id='h0A1",
				"id='h024",
				"id='h0A4",
				"id='h095",
				"id='h0A5",
				"id='h096",
				"id='h0A6",
				"id='h097",
				"id='h098",
				"id='h099",
				"id='h09A",
				"id='h09B",
				"id='h08C",
				"id='h09C",
				"id='h08D",
				"id='h09J",
				"id='h0B0",
				"id='h05C",
				"id='h05D",
				"id='h05E",
				"id='h05F",
				"id='h0AZ"
			};
			string[] keywords13 = new string[400]
			{
				"id='h010",
				"id='u010",
				"id='h020",
				"id='h030",
				"id='h040",
				"id='h050",
				"id='h060",
				"id='h070",
				"id='h080",
				"id='h090",
				"id='h0A0",
				"id='h0C0",
				"id='h0D0",
				"id='n001",
				"id='o001",
				"id='h011",
				"id='u011",
				"id='h021",
				"id='h031",
				"id='h041",
				"id='h051",
				"id='h061",
				"id='h071",
				"id='h081",
				"id='h091",
				"id='h0C1",
				"id='h0D1",
				"id='n002",
				"id='o002",
				"id='h012",
				"id='h022",
				"id='h032",
				"id='h042",
				"id='h072",
				"id='h082",
				"id='h092",
				"id='h0A2",
				"id='h0B2",
				"id='h0C2",
				"id='h0D2",
				"id='h003",
				"id='n003",
				"id='h013",
				"id='h033",
				"id='h043",
				"id='h053",
				"id='h063",
				"id='h073",
				"id='h083",
				"id='h093",
				"id='h0A3",
				"id='h0C3",
				"id='h0D3",
				"id='h014",
				"id='h034",
				"id='h044",
				"id='h064",
				"id='h074",
				"id='h084",
				"id='h094",
				"id='h0C4",
				"id='h015",
				"id='h035",
				"id='h045",
				"id='h065",
				"id='h075",
				"id='h085",
				"id='h0C5",
				"id='h0D5",
				"id='h016",
				"id='h036",
				"id='h046",
				"id='h076",
				"id='h086",
				"id='h0C6",
				"id='h007",
				"id='u007",
				"id='h017",
				"id='h037",
				"id='h047",
				"id='h077",
				"id='h087",
				"id='h0A7",
				"id='h0C7",
				"id='h008",
				"id='h018",
				"id='h028",
				"id='h038",
				"id='h048",
				"id='h068",
				"id='h078",
				"id='h088",
				"id='h0A8",
				"id='h0C8",
				"id='h019",
				"id='h029",
				"id='h039",
				"id='h049",
				"id='h069",
				"id='h079",
				"id='h089",
				"id='h0A9",
				"id='h0B9",
				"id='h0C9",
				"id='h01A",
				"id='h02A",
				"id='h03A",
				"id='h04A",
				"id='h05A",
				"id='h06A",
				"id='h08A",
				"id='h0AA",
				"id='h0CA",
				"id='hpea",
				"id='n00B",
				"id='h01B",
				"id='h02B",
				"id='h03B",
				"id='h04B",
				"id='A05B",
				"id='h06B",
				"id='h08B",
				"id='h0BB",
				"id='h0CB",
				"id='n00C",
				"id='u00C",
				"id='h01C",
				"id='h02C",
				"id='h03C",
				"id='h04C",
				"id='A06C",
				"id='h06C",
				"id='h0BC",
				"id='h0CC",
				"id='n00D",
				"id='h01D",
				"id='h02D",
				"id='h03D",
				"id='h04D",
				"id='h06D",
				"id='h09D",
				"id='h0AD",
				"id='h0BD",
				"id='h0CD",
				"id='h00E",
				"id='n00E",
				"id='h01E",
				"id='h02E",
				"id='h03E",
				"id='h04E",
				"id='h06E",
				"id='h08E",
				"id='h09E",
				"id='h0AE",
				"id='h0BE",
				"id='h0CE",
				"id='n00F",
				"id='h01F",
				"id='h02F",
				"id='h03F",
				"id='h04F",
				"id='h06F",
				"id='h08F",
				"id='h09F",
				"id='h0AF",
				"id='h0BF",
				"id='h0CF",
				"id='h00G",
				"id='n00G",
				"id='u00G",
				"id='h01G",
				"id='h02G",
				"id='h03G",
				"id='h04G",
				"id='h06G",
				"id='h08G",
				"id='h09G",
				"id='h0AG",
				"id='h0BG",
				"id='h0CG",
				"id='oang",
				"id='n00H",
				"id='h01H",
				"id='h02H",
				"id='h03H",
				"id='h04H",
				"id='h08H",
				"id='h09H",
				"id='h0AH",
				"id='h0BH",
				"id='h0CH",
				"id='n00I",
				"id='h01I",
				"id='h02I",
				"id='h03I",
				"id='h04I",
				"id='h06I",
				"id='h08I",
				"id='h09I",
				"id='h0AI",
				"id='h0BI",
				"id='h0CI",
				"id='n00J",
				"id='h01J",
				"id='h02J",
				"id='h03J",
				"id='h04J",
				"id='h06J",
				"id='h07J",
				"id='h08J",
				"id='h0AJ",
				"id='h0BJ",
				"id='h0CJ",
				"id='n00K",
				"id='h01K",
				"id='h03K",
				"id='h04K",
				"id='H05K",
				"id='h06K",
				"id='h07K",
				"id='h08K",
				"id='h09K",
				"id='h0AK",
				"id='h0BK",
				"id='h0CK",
				"id='h00L",
				"id='h01L",
				"id='h02L",
				"id='h03L",
				"id='h04L",
				"id='h06L",
				"id='h07L",
				"id='h08L",
				"id='h09L",
				"id='h0AL",
				"id='h0BL",
				"id='h0CL",
				"id='h00M",
				"id='h01M",
				"id='A02M",
				"id='h02M",
				"id='h03M",
				"id='h04M",
				"id='h06M",
				"id='h07M",
				"id='h08M",
				"id='h09M",
				"id='h0AM",
				"id='h0BM",
				"id='h0CM",
				"id='edtm",
				"id='h00N",
				"id='h01N",
				"id='A02N",
				"id='h02N",
				"id='h03N",
				"id='h04N",
				"id='h05N",
				"id='h06N",
				"id='h07N",
				"id='h08N",
				"id='h09N",
				"id='h0AN",
				"id='h0BN",
				"id='h0CN",
				"id='h00O",
				"id='h01O",
				"id='h02O",
				"id='h04O",
				"id='h05O",
				"id='h06O",
				"id='h07O",
				"id='h08O",
				"id='h09O",
				"id='h0AO",
				"id='h0BO",
				"id='h0CO",
				"id='h00P",
				"id='n00P",
				"id='h01P",
				"id='h02P",
				"id='h05P",
				"id='h06P",
				"id='h07P",
				"id='h08P",
				"id='h09P",
				"id='h0AP",
				"id='h0BP",
				"id='h0CP",
				"id='h00Q",
				"id='h01Q",
				"id='h02Q",
				"id='h06Q",
				"id='h07Q",
				"id='h09Q",
				"id='h0AQ",
				"id='h0CQ",
				"id='h01R",
				"id='h02R",
				"id='h04R",
				"id='h05R",
				"id='h06R",
				"id='h07R",
				"id='h09R",
				"id='h0AR",
				"id='h0CR",
				"id='hgyr",
				"id='h00S",
				"id='h01S",
				"id='h02S",
				"id='h05S",
				"id='h06S",
				"id='h07S",
				"id='h09S",
				"id='h0AS",
				"id='h0BS",
				"id='h0CS",
				"id='h00T",
				"id='h01T",
				"id='h02T",
				"id='h03T",
				"id='h05T",
				"id='h06T",
				"id='h07T",
				"id='h09T",
				"id='h0AT",
				"id='h0BT",
				"id='h0CT",
				"id='h00U",
				"id='h01U",
				"id='h02U",
				"id='h05U",
				"id='h06U",
				"id='h07U",
				"id='h09U",
				"id='h0AU",
				"id='h0BU",
				"id='h0CU",
				"id='h00V",
				"id='h01V",
				"id='h02V",
				"id='h03V",
				"id='h05V",
				"id='h06V",
				"id='h07V",
				"id='h08V",
				"id='h09V",
				"id='h0AV",
				"id='h0BV",
				"id='h0CV",
				"id='h00W",
				"id='h01W",
				"id='h02W",
				"id='h05W",
				"id='h06W",
				"id='h07W",
				"id='h08W",
				"id='h09W",
				"id='h0AW",
				"id='h0BW",
				"id='h0CW",
				"id='h00X",
				"id='h01X",
				"id='h02X",
				"id='h03X",
				"id='h04X",
				"id='h05X",
				"id='h06X",
				"id='h07X",
				"id='h08X",
				"id='h09X",
				"id='h0AX",
				"id='h0BX",
				"id='h0CX",
				"id='h00Y",
				"id='h01Y",
				"id='h02Y",
				"id='h03Y",
				"id='h05Y",
				"id='h06Y",
				"id='h07Y",
				"id='h08Y",
				"id='h09Y",
				"id='h0AY",
				"id='h0BY",
				"id='h0CY",
				"id='hgry",
				"id='h00Z",
				"id='h01Z",
				"id='h02Z",
				"id='h05Z",
				"id='h06Z",
				"id='h07Z",
				"id='h08Z",
				"id='h09Z",
				"id='h0BZ",
				"id='h0CZ",
				"id='hgry",
				"id='hpea",
				"id='edtm"
			};
			string[] keywords14 = new string[18]
			{
				"id='u001",
				"id='u000",
				"id='u003",
				"id='u002",
				"id='u00C",
				"id='u00H",
				"id='u00J",
				"id='u00G",
				"id='u00T",
				"id='u00I",
				"id='u00K",
				"id='u00M",
				"id='u00O",
				"id='u00L",
				"id='u00U",
				"id='u00Z",
				"id='u00P",
				"id='e000"
			};
			try
			{
				Console.WriteLine("Loop through radioboxes." + DateTime.Now);
				GlobalVars.MaxIndex = CountIndexLines(GlobalVars.LogContent);
				guiMainID_ProgessBar.Maximum = GlobalVars.MaxIndex;
				if (guiMainID_radioboxEverything.Checked)
				{
					FindKeyword(guiMainID_comboboxPlayerlist.Text);
				}
				if (guiMainID_radioCommands.Checked)
				{
					FindKeyword("0x60");
				}
				if (guiMainID_radioDetonation.Checked)
				{
					FindKeyword("0x000D00B1");
					Replace();
				}
				if (guiMainID_radioItemUsage.Checked)
				{
					FindArray(keywords);
					Replace();
				}
				if (guiMainID_radioSpells.Checked)
				{
					FindKeyword("flags=66");
					Replace();
				}
				if (guiMainID_radioPings.Checked)
				{
					FindKeyword("0x68");
				}
				if (guiMainID_radioSubgroups.Checked)
				{
					FindKeyword("0x19: Select subgroup");
					Replace();
				}
				if (guiMainID_radioChangeSelections.Checked)
				{
					FindKeyword("0x16: Change selection");
				}
				if (!guiMainID_radioBuildingsTargeted.Checked)
				{
					goto IL_271e;
				}
				if (!(guiMainID_Genre.Text == "Island Defense"))
				{
					if (guiMainID_Genre.Text == "Defense of the Ancients")
					{
						FindArray(keywords5);
					}
					if (guiMainID_Genre.Text == "Legion TD")
					{
						FindArray(keywords12);
					}
					Replace();
					goto IL_271e;
				}
				MessageBox.Show("Filtering for buildings in Island Defense does not work, yet.", "DRMF# Information", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
				goto end_IL_250b;
				IL_2906:
				if (guiMainID_radioHeroes.Checked)
				{
					Replace();
					FindArray(keywords7);
				}
				if (guiMainID_radioSentinel.Checked)
				{
					FindArray(keywords8);
					Replace();
				}
				if (guiMainID_radioScourge.Checked)
				{
					FindArray(keywords9);
					Replace();
				}
				if (guiMainID_radioCouriers.Checked)
				{
					FindArray(keywords10);
					Replace();
				}
				if (guiMainID_radioHeroSpecific.Checked)
				{
					FindKeyword("0x19: Select subgroup");
					Replace();
					Console.WriteLine("FindKeywords HeroSpecific" + DateTime.Now);
					GlobalVars.LogContent = GlobalVars.ActionLog;
					FindKeyword(guiMainID_HeroSpecificBox.Text);
				}
				if (guiMainID_checkboxSyncFree.Checked)
				{
					using (StringReader stringReader = new StringReader(GlobalVars.ActionLog))
					{
						string text = "";
						string text2 = "";
						while ((text2 = stringReader.ReadLine()) != null)
						{
							if (!text2.Contains("0x6B"))
							{
								text = text + text2 + "\r\n";
							}
						}
						GlobalVars.ActionLog = text;
					}
				}
				if (GlobalVars.ActionLog != "")
				{
					guiMainID_ProgessBar.Value = GlobalVars.MaxIndex;
					guiMainID_ProgessBar.Text = GlobalVars.MaxIndex.ToString();
					Console.WriteLine("Output Result" + DateTime.Now);
					guiResult guiResult = new guiResult();
					guiResult.Show();
					if (guiMainID_comboboxPlayerlist.Text != "")
					{
						Console.WriteLine("Playerbox not empty");
						string keywords15 = Settings.Default.Keywords;
						if (!keywords15.Contains(guiMainID_comboboxPlayerlist.Text))
						{
							Console.WriteLine("Keywords does not contain word");
							Settings @default = Settings.Default;
							@default.Keywords = @default.Keywords + ", " + guiMainID_comboboxPlayerlist.Text;
							guiMainID_comboboxPlayerlist.Items.Add(guiMainID_comboboxPlayerlist.Text);
						}
					}
				}
				else
				{
					MessageBox.Show("No result found.", "DRMF# Information", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
				}
				goto end_IL_250b;
				IL_271e:
				if (guiMainID_radioNeutrals.Checked)
				{
					if (guiMainID_Genre.Text == "Island Defense")
					{
						FindArray(keywords4);
					}
					if (guiMainID_Genre.Text == "Defense of the Anicents")
					{
						FindArray(keywords6);
					}
					Replace();
				}
				if (guiMainID_radioShare.Checked)
				{
					FindKeyword("0x50");
				}
				if (guiMainID_radioAntistuck.Checked)
				{
					FindArray(keywords11);
					Replace();
				}
				if (guiMainID_radioboxShift.Checked)
				{
					FindKeyword("flags: 0x0001");
					Replace();
				}
				if (guiMainID_radioGroupHotkey.Checked)
				{
					FindKeyword("0x18");
				}
				if (guiMainID_radioClicksOnGround.Checked)
				{
					FindArray(keywords2);
				}
				if (guiMainID_radioUnitsTowers.Checked)
				{
					FindArray(keywords13);
					Replace();
				}
				if (guiMainID_radioTitan.Checked)
				{
					FindArray(keywords3);
					Replace();
				}
				if (!guiMainID_radioBuilders.Checked)
				{
					goto IL_2906;
				}
				if (!(guiMainID_Genre.Text == "Island Defense"))
				{
					if (guiMainID_Genre.Text == "Legion TD")
					{
						FindArray(keywords14);
					}
					Replace();
					goto IL_2906;
				}
				MessageBox.Show("Filtering for builders in Island Defense does not work, yet.", "DRMF# Information", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
				end_IL_250b:;
			}
			catch (FileNotFoundException arg)
			{
				MessageBox.Show("Path to the log.txt is invalid. The file could not be read.\n\n" + arg, "DRMF# Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
			}
			catch (ArgumentNullException arg2)
			{
				MessageBox.Show("Path to the log.txt is invalid. The file could not be read.\n\n" + arg2, "DRMF# Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
			}
		}

		private void Replace()
		{
			Console.WriteLine("Replace General IDs" + DateTime.Now);
			StringBuilder stringBuilder = new StringBuilder(GlobalVars.ActionLog);
			stringBuilder.Replace("[group=3]", "[group=4]");
			stringBuilder.Replace("[group=2]", "[group=3]");
			stringBuilder.Replace("[group=1]", "[group=2]");
			stringBuilder.Replace("[group=0]", "[group=1]");
			stringBuilder.Replace("mode=2", "Removed");
			stringBuilder.Replace("mode=1", "Added");
			stringBuilder.Replace("flags: 0x0001", "queue command (shift held down)");
			stringBuilder.Replace("unknownA: 0xFFFFFFFF, unknownB: 0xFFFFFFFF", "Ground click:");
			stringBuilder.Replace("object=0xFFFFFFFFFFFFFFFF", "object=Ground");
			stringBuilder.Replace("id='unknownA: 0xFFFFFFFF", "on ground");
			stringBuilder.Replace("id='unknownB: 0xFFFFFFFF", "on ground");
			stringBuilder.Replace("id='0x000D000F", "on ground");
			stringBuilder.Replace("id='0x000D0003", "on ground");
			stringBuilder.Replace("id='0x000D0028'", "Item 1");
			stringBuilder.Replace("id='0x000D0029'", "Item 2");
			stringBuilder.Replace("id='0x000D002A'", "Item 3");
			stringBuilder.Replace("id='0x000D002B'", "Item 4");
			stringBuilder.Replace("id='0x000D002C'", "Item 5");
			stringBuilder.Replace("id='0x000D002D'", "Item 6");
			stringBuilder.Replace("id='0x000D0022'", "<swap item with 1>");
			stringBuilder.Replace("id='0x000D0023'", "<swap item with 2>");
			stringBuilder.Replace("id='0x000D0024'", "<swap item with 3>");
			stringBuilder.Replace("id='0x000D0025'", "<swap item with 4>");
			stringBuilder.Replace("id='0x000D0026'", "<swap item with 5>");
			stringBuilder.Replace("id='0x000D0027'", "<swap item with 6>");
			stringBuilder.Replace("id='0x000D0021'", "drop item");
			stringBuilder.Replace("id='Give item", "drop item");
			stringBuilder.Replace("id='0x000D00B1", "Detonation");
			stringBuilder.Replace("id='0x000D00A1", "Windwalk");
			GlobalVars.ActionLog = stringBuilder.ToString();
			switch (guiMainID_Genre.Text)
			{
			case "Island Defense":
				if (guiMainID_radioSpells.Checked)
				{
					GlobalVars.ActionLog = objectIDs.StringReplaceSpellsID(GlobalVars.ActionLog);
				}
				else
				{
					GlobalVars.ActionLog = objectIDs.StringReplaceUnitsID(GlobalVars.ActionLog);
				}
				break;
			case "Defense of the Ancients":
				if (guiMainID_radioSpells.Checked)
				{
					GlobalVars.ActionLog = objectIDs.StringReplaceSpellsDotA(GlobalVars.ActionLog);
				}
				else
				{
					GlobalVars.ActionLog = objectIDs.StringReplaceUnitsDotA(GlobalVars.ActionLog);
				}
				break;
			case "Legion TD":
				GlobalVars.ActionLog = objectIDs.StringReplaceUnitsLTD(GlobalVars.ActionLog);
				break;
			case "Tree Tag":
				GlobalVars.ActionLog = objectIDs.StringReplaceUnitsLTD(GlobalVars.ActionLog);
				break;
			}
		}

		private string FindKeyword(string Keyword)
		{
			Console.WriteLine("FindKeyword Method started." + DateTime.Now);
			string text = "";
			int num = 0;
			using (StringReader stringReader = new StringReader(GlobalVars.LogContent))
			{
				string text2 = "";
				if (guiMainID_comboboxPlayerlist.Text == "")
				{
					while ((text2 = stringReader.ReadLine()) != null)
					{
						if (GlobalVars.MaxIndex >= num)
						{
							num = (guiMainID_ProgessBar.Value = num + 1);
							guiMainID_ProgessBar.Text = num.ToString();
						}
						if (text2.Contains(Keyword))
						{
							text = text + text2 + "\r\n";
						}
					}
				}
				else
				{
					while ((text2 = stringReader.ReadLine()) != null)
					{
						num = (guiMainID_ProgessBar.Value = num + 1);
						if (GlobalVars.MaxIndex > num)
						{
							guiMainID_ProgessBar.Text = num.ToString();
						}
						if (text2.Contains(Keyword) && text2.Contains(guiMainID_comboboxPlayerlist.Text))
						{
							text = text + text2 + "\r\n";
						}
					}
				}
			}
			Console.WriteLine("Return FindKeyword Result." + DateTime.Now);
			return GlobalVars.ActionLog = text;
		}

		private string FindArray(Array Keywords)
		{
			Console.WriteLine("FindArray Method started." + DateTime.Now);
			string text = "";
			int num = 0;
			using (StringReader stringReader = new StringReader(GlobalVars.LogContent))
			{
				string text2 = "";
				if (guiMainID_comboboxPlayerlist.Text == "")
				{
					while ((text2 = stringReader.ReadLine()) != null)
					{
						num = (guiMainID_ProgessBar.Value = num + 1);
						if (GlobalVars.MaxIndex > num)
						{
							guiMainID_ProgessBar.Text = num.ToString();
						}
						foreach (string Keyword in Keywords)
						{
							if (text2.Contains(Keyword))
							{
								text = text + text2 + "\r\n";
							}
						}
					}
				}
				else
				{
					while ((text2 = stringReader.ReadLine()) != null)
					{
						num = (guiMainID_ProgessBar.Value = num + 1);
						if (GlobalVars.MaxIndex > num)
						{
							guiMainID_ProgessBar.Text = num.ToString();
						}
						foreach (string Keyword2 in Keywords)
						{
							if (text2.Contains(Keyword2) && text2.Contains(guiMainID_comboboxPlayerlist.Text))
							{
								text = text + text2 + "\r\n";
							}
						}
					}
				}
			}
			Console.WriteLine("FindArray Method ended." + DateTime.Now);
			return GlobalVars.ActionLog = text;
		}

		private string IgnoreArray(Array Keywords, string Find = "")
		{
			Console.WriteLine("IgnoreArray Method started." + DateTime.Now);
			string text = "";
			int num = 0;
			using (StringReader stringReader = new StringReader(GlobalVars.LogContent))
			{
				string text2 = "";
				if (guiMainID_comboboxPlayerlist.Text == "")
				{
					while ((text2 = stringReader.ReadLine()) != null)
					{
						num = (guiMainID_ProgessBar.Value = num + 1);
						if (GlobalVars.MaxIndex > num)
						{
							guiMainID_ProgessBar.Text = num.ToString();
						}
						foreach (string Keyword in Keywords)
						{
							if (!text2.Contains(Keyword) && text2.Contains(Find))
							{
								text = text + text2 + "\r\n";
							}
						}
					}
				}
				else
				{
					while ((text2 = stringReader.ReadLine()) != null)
					{
						num = (guiMainID_ProgessBar.Value = num + 1);
						if (GlobalVars.MaxIndex > num)
						{
							guiMainID_ProgessBar.Text = num.ToString();
						}
						foreach (string Keyword2 in Keywords)
						{
							if (!text2.Contains(Keyword2) && text2.Contains(Find) && text2.Contains(guiMainID_comboboxPlayerlist.Text))
							{
								text = text + text2 + "\r\n";
							}
						}
					}
				}
			}
			Console.WriteLine("IgnoreArray Method ended." + DateTime.Now);
			return GlobalVars.ActionLog = text;
		}

		private static int CountIndexLines(string s)
		{
			int num = 1;
			int startIndex = 0;
			while ((startIndex = s.IndexOf('\n', startIndex)) != -1)
			{
				num++;
				startIndex++;
			}
			return num;
		}

		private void guiMainID_LinkLog_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
		{
			try
			{
				Process.Start(GlobalVars.LogPath);
			}
			catch (Exception arg)
			{
				MessageBox.Show("Log file could not be opened.\n\n" + arg, "DRMF# Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
			}
		}

		private void guiMainID_Genre_SelectedValueChanged(object sender, EventArgs e)
		{
			if (File.Exists(GlobalVars.LogPath))
			{
				guiMainID_cmdFilter.Enabled = true;
			}
		}

		private void GeneratePlayerlist(string Log)
		{
			guiMainID_comboboxPlayerlist.Items.Clear();
			string[] array = Settings.Default.Keywords.Split(',');
			string[] array2 = array;
			foreach (string text in array2)
			{
				if (text != "")
				{
					guiMainID_comboboxPlayerlist.Items.Add(text);
				}
			}
			guiMainID_comboboxPlayerlist.Items.Add("");
			int num = 0;
			List<string> list = new List<string>();
			string text2 = File.ReadAllText(Log);
			string text3 = "";
			if (!text2.Contains("Player: "))
			{
				string pattern = "[0-9]{1,2}:[0-9]{2,2}.[A-Za-z0-9_.]{1,15}(.|\n)";
				foreach (Match item in Regex.Matches(text2, pattern))
				{
					num++;
					text3 = Regex.Replace(item.Value, "([0-9]{1,2}:[0-9]{2,2}.)", "");
					text3 = text3.Replace(" ", "");
					if (!list.Contains(text3))
					{
						list.Add(text3);
						GlobalVars.Playerlist = GlobalVars.Playerlist + text3 + ",";
						guiMainID_comboboxPlayerlist.Items.Add(text3);
					}
				}
			}
			else
			{
				string pattern2 = "Player: [A-Za-z0-9_.]{1,15}(.|\n)";
				foreach (Match item2 in Regex.Matches(text2, pattern2))
				{
					num++;
					text3 = Regex.Replace(item2.Value, "([0-9]{1,2}:[0-9]{2,2}.)", "");
					text3 = text3.Replace(" ", "");
					if (!list.Contains(text3))
					{
						list.Add(text3);
						GlobalVars.Playerlist = GlobalVars.Playerlist + text3 + ",";
						guiMainID_comboboxPlayerlist.Items.Add(text3);
					}
				}
			}
			guiMainID_comboboxPlayerlist.Enabled = true;
			guiMainID_comboboxPlayerlist.Text = "";
		}

		private void guiMain_Resize(object sender, EventArgs e)
		{
			if (FormWindowState.Minimized == base.WindowState)
			{
				Hide();
			}
		}

		private void TrayIcon_DoubleClick(object sender, EventArgs e)
		{
			Show();
			base.WindowState = FormWindowState.Normal;
		}

		private void TrayIconMenu_Exit_Click(object sender, EventArgs e)
		{
			Close();
		}

		private void TrayIconMenu_Information_Click(object sender, EventArgs e)
		{
			string version = Settings.Default.Version;
			string name = Settings.Default.Name;
			MessageBox.Show(name + "\n" + version + "\n\nhttp://code.google.com/p/pdrmf/wiki/DRMFsharpReadme\nhttp://code.google.com/p/pdrmf/wiki/DRMFsharpChangelog", "DRMF# Information", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
		}

		protected override void Dispose(bool disposing)
		{
			if (disposing && components != null)
			{
				components.Dispose();
			}
			base.Dispose(disposing);
		}

		private void InitializeComponent()
		{
			components = new System.ComponentModel.Container();
			System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(DotAReplayManagerExtension.guiMain));
			guiMainID_checkboxSyncFree = new System.Windows.Forms.CheckBox();
			guiMainID_radioCommands = new System.Windows.Forms.RadioButton();
			guiMainID_radioShare = new System.Windows.Forms.RadioButton();
			guiMainID_radioSpells = new System.Windows.Forms.RadioButton();
			guiMainID_radioPings = new System.Windows.Forms.RadioButton();
			guiMainID_radioItemUsage = new System.Windows.Forms.RadioButton();
			guiMainID_radioDetonation = new System.Windows.Forms.RadioButton();
			guiMainID_radioSubgroups = new System.Windows.Forms.RadioButton();
			guiMainID_radioChangeSelections = new System.Windows.Forms.RadioButton();
			guiMainID_radioBuildingsTargeted = new System.Windows.Forms.RadioButton();
			guiMainID_radioClicksOnGround = new System.Windows.Forms.RadioButton();
			tableLayoutPanel3 = new System.Windows.Forms.TableLayoutPanel();
			label3 = new System.Windows.Forms.Label();
			label2 = new System.Windows.Forms.Label();
			guiMainID_radioAntistuck = new System.Windows.Forms.RadioButton();
			guiMainID_radioGroupHotkey = new System.Windows.Forms.RadioButton();
			guiMainID_radioboxShift = new System.Windows.Forms.RadioButton();
			guiMainID_radioBuilders = new System.Windows.Forms.RadioButton();
			guiMainID_radioCouriers = new System.Windows.Forms.RadioButton();
			guiMainID_radioUnitsTowers = new System.Windows.Forms.RadioButton();
			guiMainID_radioHeroes = new System.Windows.Forms.RadioButton();
			guiMainID_radioNeutrals = new System.Windows.Forms.RadioButton();
			guiMainID_radioSentinel = new System.Windows.Forms.RadioButton();
			guiMainID_radioScourge = new System.Windows.Forms.RadioButton();
			guiMainID_radioTitan = new System.Windows.Forms.RadioButton();
			guiMainID_HeroSpecificBox = new System.Windows.Forms.ComboBox();
			guiMainID_radioHeroSpecific = new System.Windows.Forms.RadioButton();
			guiMainID_radioboxEverything = new System.Windows.Forms.RadioButton();
			guiMainID_cmdFilter = new System.Windows.Forms.Button();
			guiMainID_comboboxPlayerlist = new System.Windows.Forms.ComboBox();
			guiMainID_tooltipPlayerlist = new System.Windows.Forms.ToolTip(components);
			guiMainID_LinkLog = new System.Windows.Forms.LinkLabel();
			guiMainID_ProgessBar = new System.Windows.Forms.ProgressBar();
			guiMainID_ProgessBarIndex = new System.ComponentModel.BackgroundWorker();
			guiMainID_ToolTipLogPath = new System.Windows.Forms.ToolTip(components);
			label4 = new System.Windows.Forms.Label();
			guiMainID_Genre = new System.Windows.Forms.ComboBox();
			TrayIcon = new System.Windows.Forms.NotifyIcon(components);
			TrayIconMenu = new System.Windows.Forms.ContextMenuStrip(components);
			TrayIconMenu_Information = new System.Windows.Forms.ToolStripMenuItem();
			TrayIconMenu_Readme = new System.Windows.Forms.ToolStripMenuItem();
			TrayIconMenu_Changelog = new System.Windows.Forms.ToolStripMenuItem();
			TrayIconMenu_Exit = new System.Windows.Forms.ToolStripMenuItem();
			tableLayoutPanel3.SuspendLayout();
			TrayIconMenu.SuspendLayout();
			SuspendLayout();
			resources.ApplyResources(guiMainID_checkboxSyncFree, "guiMainID_checkboxSyncFree");
			guiMainID_checkboxSyncFree.Name = "guiMainID_checkboxSyncFree";
			guiMainID_checkboxSyncFree.UseVisualStyleBackColor = true;
			resources.ApplyResources(guiMainID_radioCommands, "guiMainID_radioCommands");
			guiMainID_radioCommands.Name = "guiMainID_radioCommands";
			guiMainID_radioCommands.TabStop = true;
			guiMainID_radioCommands.UseVisualStyleBackColor = true;
			resources.ApplyResources(guiMainID_radioShare, "guiMainID_radioShare");
			guiMainID_radioShare.Name = "guiMainID_radioShare";
			guiMainID_radioShare.TabStop = true;
			guiMainID_radioShare.UseVisualStyleBackColor = true;
			resources.ApplyResources(guiMainID_radioSpells, "guiMainID_radioSpells");
			guiMainID_radioSpells.Name = "guiMainID_radioSpells";
			guiMainID_radioSpells.TabStop = true;
			guiMainID_radioSpells.UseVisualStyleBackColor = true;
			resources.ApplyResources(guiMainID_radioPings, "guiMainID_radioPings");
			guiMainID_radioPings.Name = "guiMainID_radioPings";
			guiMainID_radioPings.TabStop = true;
			guiMainID_radioPings.UseVisualStyleBackColor = true;
			resources.ApplyResources(guiMainID_radioItemUsage, "guiMainID_radioItemUsage");
			guiMainID_radioItemUsage.Name = "guiMainID_radioItemUsage";
			guiMainID_radioItemUsage.TabStop = true;
			guiMainID_radioItemUsage.UseVisualStyleBackColor = true;
			resources.ApplyResources(guiMainID_radioDetonation, "guiMainID_radioDetonation");
			guiMainID_radioDetonation.Name = "guiMainID_radioDetonation";
			guiMainID_radioDetonation.TabStop = true;
			guiMainID_radioDetonation.UseVisualStyleBackColor = true;
			resources.ApplyResources(guiMainID_radioSubgroups, "guiMainID_radioSubgroups");
			guiMainID_radioSubgroups.Checked = true;
			guiMainID_radioSubgroups.Name = "guiMainID_radioSubgroups";
			guiMainID_radioSubgroups.TabStop = true;
			guiMainID_radioSubgroups.UseVisualStyleBackColor = true;
			resources.ApplyResources(guiMainID_radioChangeSelections, "guiMainID_radioChangeSelections");
			guiMainID_radioChangeSelections.Name = "guiMainID_radioChangeSelections";
			guiMainID_radioChangeSelections.TabStop = true;
			guiMainID_radioChangeSelections.UseVisualStyleBackColor = true;
			resources.ApplyResources(guiMainID_radioBuildingsTargeted, "guiMainID_radioBuildingsTargeted");
			guiMainID_radioBuildingsTargeted.Name = "guiMainID_radioBuildingsTargeted";
			guiMainID_radioBuildingsTargeted.TabStop = true;
			guiMainID_radioBuildingsTargeted.UseVisualStyleBackColor = true;
			resources.ApplyResources(guiMainID_radioClicksOnGround, "guiMainID_radioClicksOnGround");
			guiMainID_radioClicksOnGround.Name = "guiMainID_radioClicksOnGround";
			guiMainID_radioClicksOnGround.TabStop = true;
			guiMainID_radioClicksOnGround.UseVisualStyleBackColor = true;
			resources.ApplyResources(tableLayoutPanel3, "tableLayoutPanel3");
			tableLayoutPanel3.Controls.Add(label3, 0, 5);
			tableLayoutPanel3.Controls.Add(label2, 0, 0);
			tableLayoutPanel3.Controls.Add(guiMainID_radioAntistuck, 0, 1);
			tableLayoutPanel3.Controls.Add(guiMainID_radioChangeSelections, 1, 1);
			tableLayoutPanel3.Controls.Add(guiMainID_radioCommands, 2, 1);
			tableLayoutPanel3.Controls.Add(guiMainID_radioDetonation, 3, 1);
			tableLayoutPanel3.Controls.Add(guiMainID_radioClicksOnGround, 0, 2);
			tableLayoutPanel3.Controls.Add(guiMainID_radioGroupHotkey, 1, 2);
			tableLayoutPanel3.Controls.Add(guiMainID_radioItemUsage, 2, 2);
			tableLayoutPanel3.Controls.Add(guiMainID_radioShare, 3, 2);
			tableLayoutPanel3.Controls.Add(guiMainID_radioboxShift, 0, 3);
			tableLayoutPanel3.Controls.Add(guiMainID_radioSpells, 1, 3);
			tableLayoutPanel3.Controls.Add(guiMainID_radioSubgroups, 2, 3);
			tableLayoutPanel3.Controls.Add(guiMainID_radioPings, 3, 3);
			tableLayoutPanel3.Controls.Add(guiMainID_radioBuilders, 0, 6);
			tableLayoutPanel3.Controls.Add(guiMainID_radioBuildingsTargeted, 1, 6);
			tableLayoutPanel3.Controls.Add(guiMainID_radioCouriers, 2, 6);
			tableLayoutPanel3.Controls.Add(guiMainID_radioUnitsTowers, 0, 8);
			tableLayoutPanel3.Controls.Add(guiMainID_radioHeroes, 3, 6);
			tableLayoutPanel3.Controls.Add(guiMainID_radioNeutrals, 0, 7);
			tableLayoutPanel3.Controls.Add(guiMainID_radioSentinel, 2, 7);
			tableLayoutPanel3.Controls.Add(guiMainID_radioScourge, 1, 7);
			tableLayoutPanel3.Controls.Add(guiMainID_radioTitan, 3, 7);
			tableLayoutPanel3.Controls.Add(guiMainID_HeroSpecificBox, 0, 10);
			tableLayoutPanel3.Controls.Add(guiMainID_radioHeroSpecific, 1, 10);
			tableLayoutPanel3.Controls.Add(guiMainID_radioboxEverything, 3, 10);
			tableLayoutPanel3.Controls.Add(guiMainID_checkboxSyncFree, 2, 10);
			tableLayoutPanel3.Name = "tableLayoutPanel3";
			tableLayoutPanel3.DragDrop += new System.Windows.Forms.DragEventHandler(guiMainID_droppedFile);
			tableLayoutPanel3.DragEnter += new System.Windows.Forms.DragEventHandler(guiMainID_draggedFile);
			resources.ApplyResources(label3, "label3");
			label3.Name = "label3";
			resources.ApplyResources(label2, "label2");
			label2.Name = "label2";
			resources.ApplyResources(guiMainID_radioAntistuck, "guiMainID_radioAntistuck");
			guiMainID_radioAntistuck.Name = "guiMainID_radioAntistuck";
			guiMainID_radioAntistuck.TabStop = true;
			guiMainID_radioAntistuck.UseVisualStyleBackColor = true;
			resources.ApplyResources(guiMainID_radioGroupHotkey, "guiMainID_radioGroupHotkey");
			guiMainID_radioGroupHotkey.Name = "guiMainID_radioGroupHotkey";
			guiMainID_radioGroupHotkey.TabStop = true;
			guiMainID_radioGroupHotkey.UseVisualStyleBackColor = true;
			resources.ApplyResources(guiMainID_radioboxShift, "guiMainID_radioboxShift");
			guiMainID_radioboxShift.Name = "guiMainID_radioboxShift";
			guiMainID_radioboxShift.TabStop = true;
			guiMainID_radioboxShift.UseVisualStyleBackColor = true;
			resources.ApplyResources(guiMainID_radioBuilders, "guiMainID_radioBuilders");
			guiMainID_radioBuilders.Name = "guiMainID_radioBuilders";
			guiMainID_radioBuilders.TabStop = true;
			guiMainID_radioBuilders.UseVisualStyleBackColor = true;
			resources.ApplyResources(guiMainID_radioCouriers, "guiMainID_radioCouriers");
			guiMainID_radioCouriers.Name = "guiMainID_radioCouriers";
			guiMainID_radioCouriers.TabStop = true;
			guiMainID_radioCouriers.UseVisualStyleBackColor = true;
			resources.ApplyResources(guiMainID_radioUnitsTowers, "guiMainID_radioUnitsTowers");
			guiMainID_radioUnitsTowers.Name = "guiMainID_radioUnitsTowers";
			guiMainID_radioUnitsTowers.TabStop = true;
			guiMainID_radioUnitsTowers.UseVisualStyleBackColor = true;
			resources.ApplyResources(guiMainID_radioHeroes, "guiMainID_radioHeroes");
			guiMainID_radioHeroes.Name = "guiMainID_radioHeroes";
			guiMainID_radioHeroes.TabStop = true;
			guiMainID_radioHeroes.UseVisualStyleBackColor = true;
			resources.ApplyResources(guiMainID_radioNeutrals, "guiMainID_radioNeutrals");
			guiMainID_radioNeutrals.Name = "guiMainID_radioNeutrals";
			guiMainID_radioNeutrals.TabStop = true;
			guiMainID_radioNeutrals.UseVisualStyleBackColor = true;
			resources.ApplyResources(guiMainID_radioSentinel, "guiMainID_radioSentinel");
			guiMainID_radioSentinel.Name = "guiMainID_radioSentinel";
			guiMainID_radioSentinel.TabStop = true;
			guiMainID_radioSentinel.UseVisualStyleBackColor = true;
			resources.ApplyResources(guiMainID_radioScourge, "guiMainID_radioScourge");
			guiMainID_radioScourge.Name = "guiMainID_radioScourge";
			guiMainID_radioScourge.TabStop = true;
			guiMainID_radioScourge.UseVisualStyleBackColor = true;
			resources.ApplyResources(guiMainID_radioTitan, "guiMainID_radioTitan");
			guiMainID_radioTitan.Name = "guiMainID_radioTitan";
			guiMainID_radioTitan.TabStop = true;
			guiMainID_radioTitan.UseVisualStyleBackColor = true;
			resources.ApplyResources(guiMainID_HeroSpecificBox, "guiMainID_HeroSpecificBox");
			guiMainID_HeroSpecificBox.FormattingEnabled = true;
			guiMainID_HeroSpecificBox.Items.AddRange(new object[360]
			{
				resources.GetString("guiMainID_HeroSpecificBox.Items"),
				resources.GetString("guiMainID_HeroSpecificBox.Items1"),
				resources.GetString("guiMainID_HeroSpecificBox.Items2"),
				resources.GetString("guiMainID_HeroSpecificBox.Items3"),
				resources.GetString("guiMainID_HeroSpecificBox.Items4"),
				resources.GetString("guiMainID_HeroSpecificBox.Items5"),
				resources.GetString("guiMainID_HeroSpecificBox.Items6"),
				resources.GetString("guiMainID_HeroSpecificBox.Items7"),
				resources.GetString("guiMainID_HeroSpecificBox.Items8"),
				resources.GetString("guiMainID_HeroSpecificBox.Items9"),
				resources.GetString("guiMainID_HeroSpecificBox.Items10"),
				resources.GetString("guiMainID_HeroSpecificBox.Items11"),
				resources.GetString("guiMainID_HeroSpecificBox.Items12"),
				resources.GetString("guiMainID_HeroSpecificBox.Items13"),
				resources.GetString("guiMainID_HeroSpecificBox.Items14"),
				resources.GetString("guiMainID_HeroSpecificBox.Items15"),
				resources.GetString("guiMainID_HeroSpecificBox.Items16"),
				resources.GetString("guiMainID_HeroSpecificBox.Items17"),
				resources.GetString("guiMainID_HeroSpecificBox.Items18"),
				resources.GetString("guiMainID_HeroSpecificBox.Items19"),
				resources.GetString("guiMainID_HeroSpecificBox.Items20"),
				resources.GetString("guiMainID_HeroSpecificBox.Items21"),
				resources.GetString("guiMainID_HeroSpecificBox.Items22"),
				resources.GetString("guiMainID_HeroSpecificBox.Items23"),
				resources.GetString("guiMainID_HeroSpecificBox.Items24"),
				resources.GetString("guiMainID_HeroSpecificBox.Items25"),
				resources.GetString("guiMainID_HeroSpecificBox.Items26"),
				resources.GetString("guiMainID_HeroSpecificBox.Items27"),
				resources.GetString("guiMainID_HeroSpecificBox.Items28"),
				resources.GetString("guiMainID_HeroSpecificBox.Items29"),
				resources.GetString("guiMainID_HeroSpecificBox.Items30"),
				resources.GetString("guiMainID_HeroSpecificBox.Items31"),
				resources.GetString("guiMainID_HeroSpecificBox.Items32"),
				resources.GetString("guiMainID_HeroSpecificBox.Items33"),
				resources.GetString("guiMainID_HeroSpecificBox.Items34"),
				resources.GetString("guiMainID_HeroSpecificBox.Items35"),
				resources.GetString("guiMainID_HeroSpecificBox.Items36"),
				resources.GetString("guiMainID_HeroSpecificBox.Items37"),
				resources.GetString("guiMainID_HeroSpecificBox.Items38"),
				resources.GetString("guiMainID_HeroSpecificBox.Items39"),
				resources.GetString("guiMainID_HeroSpecificBox.Items40"),
				resources.GetString("guiMainID_HeroSpecificBox.Items41"),
				resources.GetString("guiMainID_HeroSpecificBox.Items42"),
				resources.GetString("guiMainID_HeroSpecificBox.Items43"),
				resources.GetString("guiMainID_HeroSpecificBox.Items44"),
				resources.GetString("guiMainID_HeroSpecificBox.Items45"),
				resources.GetString("guiMainID_HeroSpecificBox.Items46"),
				resources.GetString("guiMainID_HeroSpecificBox.Items47"),
				resources.GetString("guiMainID_HeroSpecificBox.Items48"),
				resources.GetString("guiMainID_HeroSpecificBox.Items49"),
				resources.GetString("guiMainID_HeroSpecificBox.Items50"),
				resources.GetString("guiMainID_HeroSpecificBox.Items51"),
				resources.GetString("guiMainID_HeroSpecificBox.Items52"),
				resources.GetString("guiMainID_HeroSpecificBox.Items53"),
				resources.GetString("guiMainID_HeroSpecificBox.Items54"),
				resources.GetString("guiMainID_HeroSpecificBox.Items55"),
				resources.GetString("guiMainID_HeroSpecificBox.Items56"),
				resources.GetString("guiMainID_HeroSpecificBox.Items57"),
				resources.GetString("guiMainID_HeroSpecificBox.Items58"),
				resources.GetString("guiMainID_HeroSpecificBox.Items59"),
				resources.GetString("guiMainID_HeroSpecificBox.Items60"),
				resources.GetString("guiMainID_HeroSpecificBox.Items61"),
				resources.GetString("guiMainID_HeroSpecificBox.Items62"),
				resources.GetString("guiMainID_HeroSpecificBox.Items63"),
				resources.GetString("guiMainID_HeroSpecificBox.Items64"),
				resources.GetString("guiMainID_HeroSpecificBox.Items65"),
				resources.GetString("guiMainID_HeroSpecificBox.Items66"),
				resources.GetString("guiMainID_HeroSpecificBox.Items67"),
				resources.GetString("guiMainID_HeroSpecificBox.Items68"),
				resources.GetString("guiMainID_HeroSpecificBox.Items69"),
				resources.GetString("guiMainID_HeroSpecificBox.Items70"),
				resources.GetString("guiMainID_HeroSpecificBox.Items71"),
				resources.GetString("guiMainID_HeroSpecificBox.Items72"),
				resources.GetString("guiMainID_HeroSpecificBox.Items73"),
				resources.GetString("guiMainID_HeroSpecificBox.Items74"),
				resources.GetString("guiMainID_HeroSpecificBox.Items75"),
				resources.GetString("guiMainID_HeroSpecificBox.Items76"),
				resources.GetString("guiMainID_HeroSpecificBox.Items77"),
				resources.GetString("guiMainID_HeroSpecificBox.Items78"),
				resources.GetString("guiMainID_HeroSpecificBox.Items79"),
				resources.GetString("guiMainID_HeroSpecificBox.Items80"),
				resources.GetString("guiMainID_HeroSpecificBox.Items81"),
				resources.GetString("guiMainID_HeroSpecificBox.Items82"),
				resources.GetString("guiMainID_HeroSpecificBox.Items83"),
				resources.GetString("guiMainID_HeroSpecificBox.Items84"),
				resources.GetString("guiMainID_HeroSpecificBox.Items85"),
				resources.GetString("guiMainID_HeroSpecificBox.Items86"),
				resources.GetString("guiMainID_HeroSpecificBox.Items87"),
				resources.GetString("guiMainID_HeroSpecificBox.Items88"),
				resources.GetString("guiMainID_HeroSpecificBox.Items89"),
				resources.GetString("guiMainID_HeroSpecificBox.Items90"),
				resources.GetString("guiMainID_HeroSpecificBox.Items91"),
				resources.GetString("guiMainID_HeroSpecificBox.Items92"),
				resources.GetString("guiMainID_HeroSpecificBox.Items93"),
				resources.GetString("guiMainID_HeroSpecificBox.Items94"),
				resources.GetString("guiMainID_HeroSpecificBox.Items95"),
				resources.GetString("guiMainID_HeroSpecificBox.Items96"),
				resources.GetString("guiMainID_HeroSpecificBox.Items97"),
				resources.GetString("guiMainID_HeroSpecificBox.Items98"),
				resources.GetString("guiMainID_HeroSpecificBox.Items99"),
				resources.GetString("guiMainID_HeroSpecificBox.Items100"),
				resources.GetString("guiMainID_HeroSpecificBox.Items101"),
				resources.GetString("guiMainID_HeroSpecificBox.Items102"),
				resources.GetString("guiMainID_HeroSpecificBox.Items103"),
				resources.GetString("guiMainID_HeroSpecificBox.Items104"),
				resources.GetString("guiMainID_HeroSpecificBox.Items105"),
				resources.GetString("guiMainID_HeroSpecificBox.Items106"),
				resources.GetString("guiMainID_HeroSpecificBox.Items107"),
				resources.GetString("guiMainID_HeroSpecificBox.Items108"),
				resources.GetString("guiMainID_HeroSpecificBox.Items109"),
				resources.GetString("guiMainID_HeroSpecificBox.Items110"),
				resources.GetString("guiMainID_HeroSpecificBox.Items111"),
				resources.GetString("guiMainID_HeroSpecificBox.Items112"),
				resources.GetString("guiMainID_HeroSpecificBox.Items113"),
				resources.GetString("guiMainID_HeroSpecificBox.Items114"),
				resources.GetString("guiMainID_HeroSpecificBox.Items115"),
				resources.GetString("guiMainID_HeroSpecificBox.Items116"),
				resources.GetString("guiMainID_HeroSpecificBox.Items117"),
				resources.GetString("guiMainID_HeroSpecificBox.Items118"),
				resources.GetString("guiMainID_HeroSpecificBox.Items119"),
				resources.GetString("guiMainID_HeroSpecificBox.Items120"),
				resources.GetString("guiMainID_HeroSpecificBox.Items121"),
				resources.GetString("guiMainID_HeroSpecificBox.Items122"),
				resources.GetString("guiMainID_HeroSpecificBox.Items123"),
				resources.GetString("guiMainID_HeroSpecificBox.Items124"),
				resources.GetString("guiMainID_HeroSpecificBox.Items125"),
				resources.GetString("guiMainID_HeroSpecificBox.Items126"),
				resources.GetString("guiMainID_HeroSpecificBox.Items127"),
				resources.GetString("guiMainID_HeroSpecificBox.Items128"),
				resources.GetString("guiMainID_HeroSpecificBox.Items129"),
				resources.GetString("guiMainID_HeroSpecificBox.Items130"),
				resources.GetString("guiMainID_HeroSpecificBox.Items131"),
				resources.GetString("guiMainID_HeroSpecificBox.Items132"),
				resources.GetString("guiMainID_HeroSpecificBox.Items133"),
				resources.GetString("guiMainID_HeroSpecificBox.Items134"),
				resources.GetString("guiMainID_HeroSpecificBox.Items135"),
				resources.GetString("guiMainID_HeroSpecificBox.Items136"),
				resources.GetString("guiMainID_HeroSpecificBox.Items137"),
				resources.GetString("guiMainID_HeroSpecificBox.Items138"),
				resources.GetString("guiMainID_HeroSpecificBox.Items139"),
				resources.GetString("guiMainID_HeroSpecificBox.Items140"),
				resources.GetString("guiMainID_HeroSpecificBox.Items141"),
				resources.GetString("guiMainID_HeroSpecificBox.Items142"),
				resources.GetString("guiMainID_HeroSpecificBox.Items143"),
				resources.GetString("guiMainID_HeroSpecificBox.Items144"),
				resources.GetString("guiMainID_HeroSpecificBox.Items145"),
				resources.GetString("guiMainID_HeroSpecificBox.Items146"),
				resources.GetString("guiMainID_HeroSpecificBox.Items147"),
				resources.GetString("guiMainID_HeroSpecificBox.Items148"),
				resources.GetString("guiMainID_HeroSpecificBox.Items149"),
				resources.GetString("guiMainID_HeroSpecificBox.Items150"),
				resources.GetString("guiMainID_HeroSpecificBox.Items151"),
				resources.GetString("guiMainID_HeroSpecificBox.Items152"),
				resources.GetString("guiMainID_HeroSpecificBox.Items153"),
				resources.GetString("guiMainID_HeroSpecificBox.Items154"),
				resources.GetString("guiMainID_HeroSpecificBox.Items155"),
				resources.GetString("guiMainID_HeroSpecificBox.Items156"),
				resources.GetString("guiMainID_HeroSpecificBox.Items157"),
				resources.GetString("guiMainID_HeroSpecificBox.Items158"),
				resources.GetString("guiMainID_HeroSpecificBox.Items159"),
				resources.GetString("guiMainID_HeroSpecificBox.Items160"),
				resources.GetString("guiMainID_HeroSpecificBox.Items161"),
				resources.GetString("guiMainID_HeroSpecificBox.Items162"),
				resources.GetString("guiMainID_HeroSpecificBox.Items163"),
				resources.GetString("guiMainID_HeroSpecificBox.Items164"),
				resources.GetString("guiMainID_HeroSpecificBox.Items165"),
				resources.GetString("guiMainID_HeroSpecificBox.Items166"),
				resources.GetString("guiMainID_HeroSpecificBox.Items167"),
				resources.GetString("guiMainID_HeroSpecificBox.Items168"),
				resources.GetString("guiMainID_HeroSpecificBox.Items169"),
				resources.GetString("guiMainID_HeroSpecificBox.Items170"),
				resources.GetString("guiMainID_HeroSpecificBox.Items171"),
				resources.GetString("guiMainID_HeroSpecificBox.Items172"),
				resources.GetString("guiMainID_HeroSpecificBox.Items173"),
				resources.GetString("guiMainID_HeroSpecificBox.Items174"),
				resources.GetString("guiMainID_HeroSpecificBox.Items175"),
				resources.GetString("guiMainID_HeroSpecificBox.Items176"),
				resources.GetString("guiMainID_HeroSpecificBox.Items177"),
				resources.GetString("guiMainID_HeroSpecificBox.Items178"),
				resources.GetString("guiMainID_HeroSpecificBox.Items179"),
				resources.GetString("guiMainID_HeroSpecificBox.Items180"),
				resources.GetString("guiMainID_HeroSpecificBox.Items181"),
				resources.GetString("guiMainID_HeroSpecificBox.Items182"),
				resources.GetString("guiMainID_HeroSpecificBox.Items183"),
				resources.GetString("guiMainID_HeroSpecificBox.Items184"),
				resources.GetString("guiMainID_HeroSpecificBox.Items185"),
				resources.GetString("guiMainID_HeroSpecificBox.Items186"),
				resources.GetString("guiMainID_HeroSpecificBox.Items187"),
				resources.GetString("guiMainID_HeroSpecificBox.Items188"),
				resources.GetString("guiMainID_HeroSpecificBox.Items189"),
				resources.GetString("guiMainID_HeroSpecificBox.Items190"),
				resources.GetString("guiMainID_HeroSpecificBox.Items191"),
				resources.GetString("guiMainID_HeroSpecificBox.Items192"),
				resources.GetString("guiMainID_HeroSpecificBox.Items193"),
				resources.GetString("guiMainID_HeroSpecificBox.Items194"),
				resources.GetString("guiMainID_HeroSpecificBox.Items195"),
				resources.GetString("guiMainID_HeroSpecificBox.Items196"),
				resources.GetString("guiMainID_HeroSpecificBox.Items197"),
				resources.GetString("guiMainID_HeroSpecificBox.Items198"),
				resources.GetString("guiMainID_HeroSpecificBox.Items199"),
				resources.GetString("guiMainID_HeroSpecificBox.Items200"),
				resources.GetString("guiMainID_HeroSpecificBox.Items201"),
				resources.GetString("guiMainID_HeroSpecificBox.Items202"),
				resources.GetString("guiMainID_HeroSpecificBox.Items203"),
				resources.GetString("guiMainID_HeroSpecificBox.Items204"),
				resources.GetString("guiMainID_HeroSpecificBox.Items205"),
				resources.GetString("guiMainID_HeroSpecificBox.Items206"),
				resources.GetString("guiMainID_HeroSpecificBox.Items207"),
				resources.GetString("guiMainID_HeroSpecificBox.Items208"),
				resources.GetString("guiMainID_HeroSpecificBox.Items209"),
				resources.GetString("guiMainID_HeroSpecificBox.Items210"),
				resources.GetString("guiMainID_HeroSpecificBox.Items211"),
				resources.GetString("guiMainID_HeroSpecificBox.Items212"),
				resources.GetString("guiMainID_HeroSpecificBox.Items213"),
				resources.GetString("guiMainID_HeroSpecificBox.Items214"),
				resources.GetString("guiMainID_HeroSpecificBox.Items215"),
				resources.GetString("guiMainID_HeroSpecificBox.Items216"),
				resources.GetString("guiMainID_HeroSpecificBox.Items217"),
				resources.GetString("guiMainID_HeroSpecificBox.Items218"),
				resources.GetString("guiMainID_HeroSpecificBox.Items219"),
				resources.GetString("guiMainID_HeroSpecificBox.Items220"),
				resources.GetString("guiMainID_HeroSpecificBox.Items221"),
				resources.GetString("guiMainID_HeroSpecificBox.Items222"),
				resources.GetString("guiMainID_HeroSpecificBox.Items223"),
				resources.GetString("guiMainID_HeroSpecificBox.Items224"),
				resources.GetString("guiMainID_HeroSpecificBox.Items225"),
				resources.GetString("guiMainID_HeroSpecificBox.Items226"),
				resources.GetString("guiMainID_HeroSpecificBox.Items227"),
				resources.GetString("guiMainID_HeroSpecificBox.Items228"),
				resources.GetString("guiMainID_HeroSpecificBox.Items229"),
				resources.GetString("guiMainID_HeroSpecificBox.Items230"),
				resources.GetString("guiMainID_HeroSpecificBox.Items231"),
				resources.GetString("guiMainID_HeroSpecificBox.Items232"),
				resources.GetString("guiMainID_HeroSpecificBox.Items233"),
				resources.GetString("guiMainID_HeroSpecificBox.Items234"),
				resources.GetString("guiMainID_HeroSpecificBox.Items235"),
				resources.GetString("guiMainID_HeroSpecificBox.Items236"),
				resources.GetString("guiMainID_HeroSpecificBox.Items237"),
				resources.GetString("guiMainID_HeroSpecificBox.Items238"),
				resources.GetString("guiMainID_HeroSpecificBox.Items239"),
				resources.GetString("guiMainID_HeroSpecificBox.Items240"),
				resources.GetString("guiMainID_HeroSpecificBox.Items241"),
				resources.GetString("guiMainID_HeroSpecificBox.Items242"),
				resources.GetString("guiMainID_HeroSpecificBox.Items243"),
				resources.GetString("guiMainID_HeroSpecificBox.Items244"),
				resources.GetString("guiMainID_HeroSpecificBox.Items245"),
				resources.GetString("guiMainID_HeroSpecificBox.Items246"),
				resources.GetString("guiMainID_HeroSpecificBox.Items247"),
				resources.GetString("guiMainID_HeroSpecificBox.Items248"),
				resources.GetString("guiMainID_HeroSpecificBox.Items249"),
				resources.GetString("guiMainID_HeroSpecificBox.Items250"),
				resources.GetString("guiMainID_HeroSpecificBox.Items251"),
				resources.GetString("guiMainID_HeroSpecificBox.Items252"),
				resources.GetString("guiMainID_HeroSpecificBox.Items253"),
				resources.GetString("guiMainID_HeroSpecificBox.Items254"),
				resources.GetString("guiMainID_HeroSpecificBox.Items255"),
				resources.GetString("guiMainID_HeroSpecificBox.Items256"),
				resources.GetString("guiMainID_HeroSpecificBox.Items257"),
				resources.GetString("guiMainID_HeroSpecificBox.Items258"),
				resources.GetString("guiMainID_HeroSpecificBox.Items259"),
				resources.GetString("guiMainID_HeroSpecificBox.Items260"),
				resources.GetString("guiMainID_HeroSpecificBox.Items261"),
				resources.GetString("guiMainID_HeroSpecificBox.Items262"),
				resources.GetString("guiMainID_HeroSpecificBox.Items263"),
				resources.GetString("guiMainID_HeroSpecificBox.Items264"),
				resources.GetString("guiMainID_HeroSpecificBox.Items265"),
				resources.GetString("guiMainID_HeroSpecificBox.Items266"),
				resources.GetString("guiMainID_HeroSpecificBox.Items267"),
				resources.GetString("guiMainID_HeroSpecificBox.Items268"),
				resources.GetString("guiMainID_HeroSpecificBox.Items269"),
				resources.GetString("guiMainID_HeroSpecificBox.Items270"),
				resources.GetString("guiMainID_HeroSpecificBox.Items271"),
				resources.GetString("guiMainID_HeroSpecificBox.Items272"),
				resources.GetString("guiMainID_HeroSpecificBox.Items273"),
				resources.GetString("guiMainID_HeroSpecificBox.Items274"),
				resources.GetString("guiMainID_HeroSpecificBox.Items275"),
				resources.GetString("guiMainID_HeroSpecificBox.Items276"),
				resources.GetString("guiMainID_HeroSpecificBox.Items277"),
				resources.GetString("guiMainID_HeroSpecificBox.Items278"),
				resources.GetString("guiMainID_HeroSpecificBox.Items279"),
				resources.GetString("guiMainID_HeroSpecificBox.Items280"),
				resources.GetString("guiMainID_HeroSpecificBox.Items281"),
				resources.GetString("guiMainID_HeroSpecificBox.Items282"),
				resources.GetString("guiMainID_HeroSpecificBox.Items283"),
				resources.GetString("guiMainID_HeroSpecificBox.Items284"),
				resources.GetString("guiMainID_HeroSpecificBox.Items285"),
				resources.GetString("guiMainID_HeroSpecificBox.Items286"),
				resources.GetString("guiMainID_HeroSpecificBox.Items287"),
				resources.GetString("guiMainID_HeroSpecificBox.Items288"),
				resources.GetString("guiMainID_HeroSpecificBox.Items289"),
				resources.GetString("guiMainID_HeroSpecificBox.Items290"),
				resources.GetString("guiMainID_HeroSpecificBox.Items291"),
				resources.GetString("guiMainID_HeroSpecificBox.Items292"),
				resources.GetString("guiMainID_HeroSpecificBox.Items293"),
				resources.GetString("guiMainID_HeroSpecificBox.Items294"),
				resources.GetString("guiMainID_HeroSpecificBox.Items295"),
				resources.GetString("guiMainID_HeroSpecificBox.Items296"),
				resources.GetString("guiMainID_HeroSpecificBox.Items297"),
				resources.GetString("guiMainID_HeroSpecificBox.Items298"),
				resources.GetString("guiMainID_HeroSpecificBox.Items299"),
				resources.GetString("guiMainID_HeroSpecificBox.Items300"),
				resources.GetString("guiMainID_HeroSpecificBox.Items301"),
				resources.GetString("guiMainID_HeroSpecificBox.Items302"),
				resources.GetString("guiMainID_HeroSpecificBox.Items303"),
				resources.GetString("guiMainID_HeroSpecificBox.Items304"),
				resources.GetString("guiMainID_HeroSpecificBox.Items305"),
				resources.GetString("guiMainID_HeroSpecificBox.Items306"),
				resources.GetString("guiMainID_HeroSpecificBox.Items307"),
				resources.GetString("guiMainID_HeroSpecificBox.Items308"),
				resources.GetString("guiMainID_HeroSpecificBox.Items309"),
				resources.GetString("guiMainID_HeroSpecificBox.Items310"),
				resources.GetString("guiMainID_HeroSpecificBox.Items311"),
				resources.GetString("guiMainID_HeroSpecificBox.Items312"),
				resources.GetString("guiMainID_HeroSpecificBox.Items313"),
				resources.GetString("guiMainID_HeroSpecificBox.Items314"),
				resources.GetString("guiMainID_HeroSpecificBox.Items315"),
				resources.GetString("guiMainID_HeroSpecificBox.Items316"),
				resources.GetString("guiMainID_HeroSpecificBox.Items317"),
				resources.GetString("guiMainID_HeroSpecificBox.Items318"),
				resources.GetString("guiMainID_HeroSpecificBox.Items319"),
				resources.GetString("guiMainID_HeroSpecificBox.Items320"),
				resources.GetString("guiMainID_HeroSpecificBox.Items321"),
				resources.GetString("guiMainID_HeroSpecificBox.Items322"),
				resources.GetString("guiMainID_HeroSpecificBox.Items323"),
				resources.GetString("guiMainID_HeroSpecificBox.Items324"),
				resources.GetString("guiMainID_HeroSpecificBox.Items325"),
				resources.GetString("guiMainID_HeroSpecificBox.Items326"),
				resources.GetString("guiMainID_HeroSpecificBox.Items327"),
				resources.GetString("guiMainID_HeroSpecificBox.Items328"),
				resources.GetString("guiMainID_HeroSpecificBox.Items329"),
				resources.GetString("guiMainID_HeroSpecificBox.Items330"),
				resources.GetString("guiMainID_HeroSpecificBox.Items331"),
				resources.GetString("guiMainID_HeroSpecificBox.Items332"),
				resources.GetString("guiMainID_HeroSpecificBox.Items333"),
				resources.GetString("guiMainID_HeroSpecificBox.Items334"),
				resources.GetString("guiMainID_HeroSpecificBox.Items335"),
				resources.GetString("guiMainID_HeroSpecificBox.Items336"),
				resources.GetString("guiMainID_HeroSpecificBox.Items337"),
				resources.GetString("guiMainID_HeroSpecificBox.Items338"),
				resources.GetString("guiMainID_HeroSpecificBox.Items339"),
				resources.GetString("guiMainID_HeroSpecificBox.Items340"),
				resources.GetString("guiMainID_HeroSpecificBox.Items341"),
				resources.GetString("guiMainID_HeroSpecificBox.Items342"),
				resources.GetString("guiMainID_HeroSpecificBox.Items343"),
				resources.GetString("guiMainID_HeroSpecificBox.Items344"),
				resources.GetString("guiMainID_HeroSpecificBox.Items345"),
				resources.GetString("guiMainID_HeroSpecificBox.Items346"),
				resources.GetString("guiMainID_HeroSpecificBox.Items347"),
				resources.GetString("guiMainID_HeroSpecificBox.Items348"),
				resources.GetString("guiMainID_HeroSpecificBox.Items349"),
				resources.GetString("guiMainID_HeroSpecificBox.Items350"),
				resources.GetString("guiMainID_HeroSpecificBox.Items351"),
				resources.GetString("guiMainID_HeroSpecificBox.Items352"),
				resources.GetString("guiMainID_HeroSpecificBox.Items353"),
				resources.GetString("guiMainID_HeroSpecificBox.Items354"),
				resources.GetString("guiMainID_HeroSpecificBox.Items355"),
				resources.GetString("guiMainID_HeroSpecificBox.Items356"),
				resources.GetString("guiMainID_HeroSpecificBox.Items357"),
				resources.GetString("guiMainID_HeroSpecificBox.Items358"),
				resources.GetString("guiMainID_HeroSpecificBox.Items359")
			});
			guiMainID_HeroSpecificBox.Name = "guiMainID_HeroSpecificBox";
			resources.ApplyResources(guiMainID_radioHeroSpecific, "guiMainID_radioHeroSpecific");
			guiMainID_radioHeroSpecific.Name = "guiMainID_radioHeroSpecific";
			guiMainID_radioHeroSpecific.TabStop = true;
			guiMainID_radioHeroSpecific.UseVisualStyleBackColor = true;
			resources.ApplyResources(guiMainID_radioboxEverything, "guiMainID_radioboxEverything");
			guiMainID_radioboxEverything.Name = "guiMainID_radioboxEverything";
			guiMainID_radioboxEverything.TabStop = true;
			guiMainID_radioboxEverything.UseVisualStyleBackColor = true;
			resources.ApplyResources(guiMainID_cmdFilter, "guiMainID_cmdFilter");
			guiMainID_cmdFilter.Name = "guiMainID_cmdFilter";
			guiMainID_cmdFilter.UseVisualStyleBackColor = true;
			guiMainID_cmdFilter.Click += new System.EventHandler(guiMainID_cmdFilter_Click);
			guiMainID_comboboxPlayerlist.AllowDrop = true;
			resources.ApplyResources(guiMainID_comboboxPlayerlist, "guiMainID_comboboxPlayerlist");
			guiMainID_comboboxPlayerlist.FormattingEnabled = true;
			guiMainID_comboboxPlayerlist.Name = "guiMainID_comboboxPlayerlist";
			guiMainID_tooltipPlayerlist.SetToolTip(guiMainID_comboboxPlayerlist, resources.GetString("guiMainID_comboboxPlayerlist.ToolTip"));
			guiMainID_tooltipPlayerlist.AutoPopDelay = 5000;
			guiMainID_tooltipPlayerlist.InitialDelay = 250;
			guiMainID_tooltipPlayerlist.ReshowDelay = 100;
			guiMainID_tooltipPlayerlist.ToolTipIcon = System.Windows.Forms.ToolTipIcon.Info;
			guiMainID_tooltipPlayerlist.ToolTipTitle = "Filter Information";
			guiMainID_LinkLog.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
			resources.ApplyResources(guiMainID_LinkLog, "guiMainID_LinkLog");
			guiMainID_LinkLog.LinkBehavior = System.Windows.Forms.LinkBehavior.NeverUnderline;
			guiMainID_LinkLog.LinkColor = System.Drawing.Color.Black;
			guiMainID_LinkLog.Name = "guiMainID_LinkLog";
			guiMainID_LinkLog.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(guiMainID_LinkLog_LinkClicked);
			resources.ApplyResources(guiMainID_ProgessBar, "guiMainID_ProgessBar");
			guiMainID_ProgessBar.Maximum = 100000000;
			guiMainID_ProgessBar.Name = "guiMainID_ProgessBar";
			guiMainID_ProgessBar.Step = 1;
			guiMainID_ToolTipLogPath.AutoPopDelay = 5000;
			guiMainID_ToolTipLogPath.InitialDelay = 250;
			guiMainID_ToolTipLogPath.ReshowDelay = 100;
			guiMainID_ToolTipLogPath.ToolTipIcon = System.Windows.Forms.ToolTipIcon.Info;
			guiMainID_ToolTipLogPath.ToolTipTitle = "Path";
			resources.ApplyResources(label4, "label4");
			label4.Name = "label4";
			guiMainID_Genre.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
			resources.ApplyResources(guiMainID_Genre, "guiMainID_Genre");
			guiMainID_Genre.FormattingEnabled = true;
			guiMainID_Genre.Items.AddRange(new object[4]
			{
				resources.GetString("guiMainID_Genre.Items"),
				resources.GetString("guiMainID_Genre.Items1"),
				resources.GetString("guiMainID_Genre.Items2"),
				resources.GetString("guiMainID_Genre.Items3")
			});
			guiMainID_Genre.Name = "guiMainID_Genre";
			guiMainID_Genre.SelectedValueChanged += new System.EventHandler(guiMainID_Genre_SelectedValueChanged);
			TrayIcon.ContextMenuStrip = TrayIconMenu;
			resources.ApplyResources(TrayIcon, "TrayIcon");
			TrayIcon.DoubleClick += new System.EventHandler(TrayIcon_DoubleClick);
			TrayIconMenu.Items.AddRange(new System.Windows.Forms.ToolStripItem[4]
			{
				TrayIconMenu_Information,
				TrayIconMenu_Readme,
				TrayIconMenu_Changelog,
				TrayIconMenu_Exit
			});
			TrayIconMenu.Name = "TrayIconMenu";
			resources.ApplyResources(TrayIconMenu, "TrayIconMenu");
			TrayIconMenu_Information.Name = "TrayIconMenu_Information";
			resources.ApplyResources(TrayIconMenu_Information, "TrayIconMenu_Information");
			TrayIconMenu_Information.Click += new System.EventHandler(TrayIconMenu_Information_Click);
			TrayIconMenu_Readme.Name = "TrayIconMenu_Readme";
			resources.ApplyResources(TrayIconMenu_Readme, "TrayIconMenu_Readme");
			TrayIconMenu_Readme.Click += new System.EventHandler(ReadmeMenuClicked);
			TrayIconMenu_Changelog.Name = "TrayIconMenu_Changelog";
			resources.ApplyResources(TrayIconMenu_Changelog, "TrayIconMenu_Changelog");
			TrayIconMenu_Changelog.Click += new System.EventHandler(UpdateMenuClicked);
			TrayIconMenu_Exit.Name = "TrayIconMenu_Exit";
			resources.ApplyResources(TrayIconMenu_Exit, "TrayIconMenu_Exit");
			TrayIconMenu_Exit.Click += new System.EventHandler(TrayIconMenu_Exit_Click);
			AllowDrop = true;
			resources.ApplyResources(this, "$this");
			base.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			base.Controls.Add(guiMainID_Genre);
			base.Controls.Add(label4);
			base.Controls.Add(guiMainID_ProgessBar);
			base.Controls.Add(guiMainID_LinkLog);
			base.Controls.Add(guiMainID_comboboxPlayerlist);
			base.Controls.Add(guiMainID_cmdFilter);
			base.Controls.Add(tableLayoutPanel3);
			base.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
			base.Name = "guiMain";
			base.DragDrop += new System.Windows.Forms.DragEventHandler(guiMainID_droppedFile);
			base.DragEnter += new System.Windows.Forms.DragEventHandler(guiMainID_draggedFile);
			base.Resize += new System.EventHandler(guiMain_Resize);
			tableLayoutPanel3.ResumeLayout(false);
			tableLayoutPanel3.PerformLayout();
			TrayIconMenu.ResumeLayout(false);
			ResumeLayout(false);
			PerformLayout();
		}
	}
}
