using DotAReplayManagerExtension.Properties;
using System;
using System.ComponentModel;
using System.Drawing;
using System.IO;
using System.Windows.Forms;

namespace DotAReplayManagerExtension
{
	public class guiResult : Form
	{
		private string SelectedLines;

		private IContainer components = null;

		public ListView guiMainResult_listview;

		private SaveFileDialog guiMainResult_SaveFile;

		private ComboBox guiResult_SearchKeywords;

		private Button guiResult_cmdSearch;

		private Label guiResult_FoundResult;

		private ToolTip guiResult_SearchInfo;

		public guiResult()
		{
			InitializeComponent();
			guiMainResult_listview.View = View.Details;
			string[] array = Settings.Default.Keywords.Split(',');
			string[] array2 = array;
			foreach (string text in array2)
			{
				if (text != "")
				{
					guiResult_SearchKeywords.Items.Add(text);
				}
			}
			if (GlobalVars.Playerlist != null)
			{
				string[] array3 = GlobalVars.Playerlist.Split(',');
				guiResult_SearchKeywords.Items.Add("");
				array2 = array3;
				foreach (string text2 in array2)
				{
					if (text2 != "")
					{
						guiResult_SearchKeywords.Items.Add(text2);
					}
				}
			}
			MainMenu mainMenu = new MainMenu();
			MenuItem menuItem = new MenuItem("&Save as..");
			mainMenu.MenuItems.Add(menuItem);
			menuItem.Click += SaveMenuClicked;
			base.Menu = mainMenu;
		}

		public void SaveMenuClicked(object sender, EventArgs e)
		{
			guiMainResult_SaveFile.ShowDialog();
		}

		public void guiMainResult_SaveFile_FileOk(object sender, CancelEventArgs e)
		{
			string fileName = guiMainResult_SaveFile.FileName;
			string defaultExt = guiMainResult_SaveFile.DefaultExt;
			if (defaultExt == "*.txt")
			{
				File.WriteAllText(fileName, GlobalVars.ActionLog);
			}
		}

		private void guiMainResult_Load(object sender, EventArgs e)
		{
			using (StringReader stringReader = new StringReader(GlobalVars.ActionLog))
			{
				int num = 0;
				string text;
				while ((text = stringReader.ReadLine()) != null)
				{
					guiMainResult_listview.Items.Add("[" + ++num + "]" + text, num);
				}
				guiMainResult_listview.Columns.Add("Log Lines: " + GlobalVars.MaxIndex + " | Found: " + num + " | " + GlobalVars.LogPath, base.Width - 25);
				guiMainResult_listview.AutoResizeColumn(0, ColumnHeaderAutoResizeStyle.ColumnContent);
			}
		}

		private void guiMainResult_Resize(object sender, EventArgs e)
		{
			guiMainResult_listview.Size = new Size(base.Size.Width - 25, base.Size.Height - 45);
		}

		private void CopySelectedLines(object sender, ColumnClickEventArgs e)
		{
			int num = 0;
			for (int i = 0; i < guiMainResult_listview.SelectedItems.Count; i++)
			{
				num++;
				SelectedLines = string.Concat(SelectedLines, guiMainResult_listview.SelectedItems[i], "\n");
			}
			SelectedLines = SelectedLines.Replace("ListViewItem: {", "");
			SelectedLines = SelectedLines.Replace("}", "");
			Clipboard.SetText(SelectedLines);
			guiResult_FoundResult.Text = "Copied " + num + " lines.";
		}

		private void guiMainResult_listview_DoubleClick(object sender, EventArgs e)
		{
			Clipboard.Clear();
			guiResult_FoundResult.Text = "Clipboard cleared.";
		}

		private void guiResult_cmdSearch_Click(object sender, EventArgs e)
		{
			int num = 0;
			int num2 = 0;
			foreach (ListViewItem item in guiMainResult_listview.Items)
			{
				num++;
				if (guiMainResult_listview.Items[num - 1].Selected)
				{
					guiMainResult_listview.Items[num - 1].Selected = false;
				}
				if (num >= GlobalVars.MaxIndex)
				{
					break;
				}
				if (item.Text.Contains(guiResult_SearchKeywords.Text))
				{
					guiMainResult_listview.Items[num - 1].Selected = true;
					num2++;
					if (num2 == 1)
					{
						guiMainResult_listview.Items[num - 1].Focused = true;
					}
				}
				guiMainResult_listview.Focus();
				guiResult_FoundResult.Text = "Found " + num2 + " results.";
			}
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
			System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(DotAReplayManagerExtension.guiResult));
			guiMainResult_listview = new System.Windows.Forms.ListView();
			guiMainResult_SaveFile = new System.Windows.Forms.SaveFileDialog();
			guiResult_SearchKeywords = new System.Windows.Forms.ComboBox();
			guiResult_cmdSearch = new System.Windows.Forms.Button();
			guiResult_FoundResult = new System.Windows.Forms.Label();
			guiResult_SearchInfo = new System.Windows.Forms.ToolTip(components);
			SuspendLayout();
			resources.ApplyResources(guiMainResult_listview, "guiMainResult_listview");
			guiMainResult_listview.FullRowSelect = true;
			guiMainResult_listview.GridLines = true;
			guiMainResult_listview.HideSelection = false;
			guiMainResult_listview.Name = "guiMainResult_listview";
			guiMainResult_listview.UseCompatibleStateImageBehavior = false;
			guiMainResult_listview.View = System.Windows.Forms.View.Details;
			guiMainResult_listview.ColumnClick += new System.Windows.Forms.ColumnClickEventHandler(CopySelectedLines);
			guiMainResult_listview.DoubleClick += new System.EventHandler(guiMainResult_listview_DoubleClick);
			guiMainResult_SaveFile.DefaultExt = "*.txt";
			guiMainResult_SaveFile.FileName = ".txt";
			resources.ApplyResources(guiMainResult_SaveFile, "guiMainResult_SaveFile");
			guiMainResult_SaveFile.FileOk += new System.ComponentModel.CancelEventHandler(guiMainResult_SaveFile_FileOk);
			resources.ApplyResources(guiResult_SearchKeywords, "guiResult_SearchKeywords");
			guiResult_SearchKeywords.FormattingEnabled = true;
			guiResult_SearchKeywords.Name = "guiResult_SearchKeywords";
			resources.ApplyResources(guiResult_cmdSearch, "guiResult_cmdSearch");
			guiResult_cmdSearch.Name = "guiResult_cmdSearch";
			guiResult_SearchInfo.SetToolTip(guiResult_cmdSearch, resources.GetString("guiResult_cmdSearch.ToolTip"));
			guiResult_cmdSearch.UseVisualStyleBackColor = true;
			guiResult_cmdSearch.Click += new System.EventHandler(guiResult_cmdSearch_Click);
			resources.ApplyResources(guiResult_FoundResult, "guiResult_FoundResult");
			guiResult_FoundResult.Name = "guiResult_FoundResult";
			guiResult_SearchInfo.AutoPopDelay = 5000;
			guiResult_SearchInfo.BackColor = System.Drawing.SystemColors.GradientActiveCaption;
			guiResult_SearchInfo.InitialDelay = 250;
			guiResult_SearchInfo.ReshowDelay = 100;
			guiResult_SearchInfo.ToolTipIcon = System.Windows.Forms.ToolTipIcon.Info;
			guiResult_SearchInfo.ToolTipTitle = "Info";
			resources.ApplyResources(this, "$this");
			base.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			base.Controls.Add(guiResult_FoundResult);
			base.Controls.Add(guiResult_cmdSearch);
			base.Controls.Add(guiResult_SearchKeywords);
			base.Controls.Add(guiMainResult_listview);
			base.Name = "guiResult";
			base.Load += new System.EventHandler(guiMainResult_Load);
			base.Resize += new System.EventHandler(guiMainResult_Resize);
			ResumeLayout(false);
			PerformLayout();
		}
	}
}
