using DotAReplayManagerExtension.Properties;
using System;
using System.ComponentModel;
using System.Diagnostics;
using System.Drawing;
using System.Windows.Forms;

namespace DotAReplayManagerExtension
{
	public class guiSettings : Form
	{
		private IContainer components = null;

		private TableLayoutPanel tableLayoutPanel1;

		private Label label1;

		private Label label2;

		private Label label3;

		private Label label4;

		private Label label5;

		private Label label8;

		private LinkLabel guiMainSettings_Readme;

		private Label guiMainSettings_Version;

		private LinkLabel guiMainSettings_Changelog;

		private TextBox guiMainSettings_DRMpath;

		private TextBox guiMainSettings_LOGpath;

		private TextBox guiMainSettings_RSpath;

		private TextBox guiMainSettings_QlogPath;

		private OpenFileDialog guiMainSettings_DRMpathOpen;

		private OpenFileDialog guiMainSettings_LogpathOpen;

		private OpenFileDialog guiMainSettings_RSpathOpen;

		private OpenFileDialog guiMainSettings_QlogpathOpen;

		private TextBox guiMainSettings_Keywords;

		private Button guiSettings_cmdSave;

		private Label label7;

		private Label label6;

		public guiSettings()
		{
			InitializeComponent();
			string version = Settings.Default.Version;
			string readme = Settings.Default.Readme;
			string changelog = Settings.Default.Changelog;
			string dotAReplayManagerPath = Settings.Default.DotAReplayManagerPath;
			string replaySeekerPath = Settings.Default.ReplaySeekerPath;
			string logPath = GlobalVars.LogPath;
			string qlogExePath = Settings.Default.QlogExePath;
			string keywords = Settings.Default.Keywords;
			guiMainSettings_Version.Text = version;
			guiMainSettings_Readme.Text = readme;
			guiMainSettings_Changelog.Text = changelog;
			guiMainSettings_DRMpath.Text = dotAReplayManagerPath;
			guiMainSettings_RSpath.Text = replaySeekerPath;
			guiMainSettings_LOGpath.Text = logPath;
			guiMainSettings_QlogPath.Text = qlogExePath;
			guiMainSettings_Keywords.Text = keywords;
		}

		private void guiMainSettings_Changelog_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
		{
			try
			{
				Process.Start(Settings.Default.Changelog);
			}
			catch (Exception arg)
			{
				MessageBox.Show("Changelog could not be opened.\n\n" + arg, "DRMF# Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
			}
		}

		private void guiMainSettings_Readme_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
		{
			try
			{
				Process.Start(Settings.Default.Readme);
			}
			catch (Exception arg)
			{
				MessageBox.Show("Readme could not be opened.\n\n" + arg, "DRMF# Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
			}
		}

		private void guiMainSettings_DRMpath_Click(object sender, EventArgs e)
		{
			DialogResult dialogResult = guiMainSettings_DRMpathOpen.ShowDialog();
			if (dialogResult == DialogResult.OK)
			{
				string fileName = guiMainSettings_DRMpathOpen.FileName;
				string defaultExt = guiMainSettings_DRMpathOpen.DefaultExt;
				if (defaultExt == "exe")
				{
					guiMainSettings_DRMpath.Text = fileName;
					Settings.Default.DotAReplayManagerPath = fileName;
					Settings.Default.Save();
				}
				else
				{
					MessageBox.Show("Extension is invalid.", "DRMF# Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				}
			}
		}

		private void guiMainSettings_LOGpath_Click(object sender, EventArgs e)
		{
			DialogResult dialogResult = guiMainSettings_LogpathOpen.ShowDialog();
			if (dialogResult == DialogResult.OK)
			{
				string fileName = guiMainSettings_LogpathOpen.FileName;
				string defaultExt = guiMainSettings_LogpathOpen.DefaultExt;
				if (defaultExt == "txt")
				{
					guiMainSettings_LOGpath.Text = fileName;
					Settings.Default.LogPath = fileName;
					Settings.Default.Save();
				}
				else
				{
					MessageBox.Show("Extension is invalid.", "DRMF# Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				}
			}
		}

		private void guiMainSettings_RSpath_Click(object sender, EventArgs e)
		{
			DialogResult dialogResult = guiMainSettings_RSpathOpen.ShowDialog();
			if (dialogResult == DialogResult.OK)
			{
				string fileName = guiMainSettings_RSpathOpen.FileName;
				string defaultExt = guiMainSettings_RSpathOpen.DefaultExt;
				if (defaultExt == "exe")
				{
					guiMainSettings_RSpath.Text = fileName;
					Settings.Default.ReplaySeekerPath = fileName;
					Settings.Default.Save();
				}
				else
				{
					MessageBox.Show("Extension is invalid.", "DRMF# Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				}
			}
		}

		private void guiMainSettings_QlogPath_Click(object sender, EventArgs e)
		{
			DialogResult dialogResult = guiMainSettings_QlogpathOpen.ShowDialog();
			if (dialogResult == DialogResult.OK)
			{
				string fileName = guiMainSettings_QlogpathOpen.FileName;
				string defaultExt = guiMainSettings_QlogpathOpen.DefaultExt;
				if (defaultExt == "exe")
				{
					guiMainSettings_QlogPath.Text = fileName;
					Settings.Default.QlogExePath = fileName;
					Settings.Default.Save();
				}
				else
				{
					MessageBox.Show("Extension is invalid.", "DRMF# Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				}
			}
		}

		private void guiSettings_cmdSave_Click(object sender, EventArgs e)
		{
			Settings.Default.Keywords = guiMainSettings_Keywords.Text;
			Settings.Default.Save();
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
			System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(DotAReplayManagerExtension.guiSettings));
			tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
			guiSettings_cmdSave = new System.Windows.Forms.Button();
			guiMainSettings_Readme = new System.Windows.Forms.LinkLabel();
			label1 = new System.Windows.Forms.Label();
			label3 = new System.Windows.Forms.Label();
			label4 = new System.Windows.Forms.Label();
			label5 = new System.Windows.Forms.Label();
			guiMainSettings_Version = new System.Windows.Forms.Label();
			guiMainSettings_Changelog = new System.Windows.Forms.LinkLabel();
			guiMainSettings_RSpath = new System.Windows.Forms.TextBox();
			label7 = new System.Windows.Forms.Label();
			label6 = new System.Windows.Forms.Label();
			guiMainSettings_Keywords = new System.Windows.Forms.TextBox();
			guiMainSettings_QlogPath = new System.Windows.Forms.TextBox();
			guiMainSettings_DRMpath = new System.Windows.Forms.TextBox();
			guiMainSettings_LOGpath = new System.Windows.Forms.TextBox();
			label2 = new System.Windows.Forms.Label();
			label8 = new System.Windows.Forms.Label();
			guiMainSettings_DRMpathOpen = new System.Windows.Forms.OpenFileDialog();
			guiMainSettings_LogpathOpen = new System.Windows.Forms.OpenFileDialog();
			guiMainSettings_RSpathOpen = new System.Windows.Forms.OpenFileDialog();
			guiMainSettings_QlogpathOpen = new System.Windows.Forms.OpenFileDialog();
			tableLayoutPanel1.SuspendLayout();
			SuspendLayout();
			tableLayoutPanel1.ColumnCount = 2;
			tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 150f));
			tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle());
			tableLayoutPanel1.Controls.Add(guiSettings_cmdSave, 1, 8);
			tableLayoutPanel1.Controls.Add(guiMainSettings_Readme, 1, 2);
			tableLayoutPanel1.Controls.Add(label1, 0, 0);
			tableLayoutPanel1.Controls.Add(label3, 0, 5);
			tableLayoutPanel1.Controls.Add(label4, 0, 2);
			tableLayoutPanel1.Controls.Add(label5, 0, 1);
			tableLayoutPanel1.Controls.Add(guiMainSettings_Version, 1, 0);
			tableLayoutPanel1.Controls.Add(guiMainSettings_Changelog, 1, 1);
			tableLayoutPanel1.Controls.Add(guiMainSettings_RSpath, 1, 5);
			tableLayoutPanel1.Controls.Add(label7, 0, 6);
			tableLayoutPanel1.Controls.Add(label6, 0, 7);
			tableLayoutPanel1.Controls.Add(guiMainSettings_Keywords, 1, 7);
			tableLayoutPanel1.Controls.Add(guiMainSettings_QlogPath, 1, 6);
			tableLayoutPanel1.Controls.Add(guiMainSettings_DRMpath, 1, 4);
			tableLayoutPanel1.Controls.Add(guiMainSettings_LOGpath, 1, 3);
			tableLayoutPanel1.Controls.Add(label2, 0, 3);
			tableLayoutPanel1.Controls.Add(label8, 0, 4);
			tableLayoutPanel1.Location = new System.Drawing.Point(1, 12);
			tableLayoutPanel1.Name = "tableLayoutPanel1";
			tableLayoutPanel1.RowCount = 9;
			tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 28f));
			tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 28f));
			tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 28f));
			tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 28f));
			tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 28f));
			tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 28f));
			tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 28f));
			tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 28f));
			tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 20f));
			tableLayoutPanel1.Size = new System.Drawing.Size(733, 253);
			tableLayoutPanel1.TabIndex = 0;
			guiSettings_cmdSave.Location = new System.Drawing.Point(153, 227);
			guiSettings_cmdSave.Name = "guiSettings_cmdSave";
			guiSettings_cmdSave.Size = new System.Drawing.Size(109, 23);
			guiSettings_cmdSave.TabIndex = 1;
			guiSettings_cmdSave.Text = "Save";
			guiSettings_cmdSave.UseVisualStyleBackColor = true;
			guiSettings_cmdSave.Click += new System.EventHandler(guiSettings_cmdSave_Click);
			guiMainSettings_Readme.ActiveLinkColor = System.Drawing.Color.Red;
			guiMainSettings_Readme.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
			guiMainSettings_Readme.Dock = System.Windows.Forms.DockStyle.Fill;
			guiMainSettings_Readme.LinkBehavior = System.Windows.Forms.LinkBehavior.NeverUnderline;
			guiMainSettings_Readme.LinkColor = System.Drawing.Color.Black;
			guiMainSettings_Readme.Location = new System.Drawing.Point(153, 56);
			guiMainSettings_Readme.Name = "guiMainSettings_Readme";
			guiMainSettings_Readme.Size = new System.Drawing.Size(590, 28);
			guiMainSettings_Readme.TabIndex = 12;
			guiMainSettings_Readme.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(guiMainSettings_Readme_LinkClicked);
			label1.AutoSize = true;
			label1.Dock = System.Windows.Forms.DockStyle.Fill;
			label1.Font = new System.Drawing.Font("Sparkasse Rg", 9.75f, System.Drawing.FontStyle.Bold);
			label1.Location = new System.Drawing.Point(3, 0);
			label1.Name = "label1";
			label1.Size = new System.Drawing.Size(144, 28);
			label1.TabIndex = 0;
			label1.Text = "Version";
			label3.AutoSize = true;
			label3.Dock = System.Windows.Forms.DockStyle.Fill;
			label3.Font = new System.Drawing.Font("Sparkasse Rg", 9.75f, System.Drawing.FontStyle.Bold);
			label3.Location = new System.Drawing.Point(3, 140);
			label3.Name = "label3";
			label3.Size = new System.Drawing.Size(144, 28);
			label3.TabIndex = 2;
			label3.Text = "Replay Seeker Path";
			label4.AutoSize = true;
			label4.Dock = System.Windows.Forms.DockStyle.Fill;
			label4.Font = new System.Drawing.Font("Sparkasse Rg", 9.75f, System.Drawing.FontStyle.Bold);
			label4.Location = new System.Drawing.Point(3, 56);
			label4.Name = "label4";
			label4.Size = new System.Drawing.Size(144, 28);
			label4.TabIndex = 3;
			label4.Text = "Readme";
			label5.AutoSize = true;
			label5.Dock = System.Windows.Forms.DockStyle.Fill;
			label5.Font = new System.Drawing.Font("Sparkasse Rg", 9.75f, System.Drawing.FontStyle.Bold);
			label5.Location = new System.Drawing.Point(3, 28);
			label5.Name = "label5";
			label5.Size = new System.Drawing.Size(144, 28);
			label5.TabIndex = 4;
			label5.Text = "Changelog";
			guiMainSettings_Version.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
			guiMainSettings_Version.Dock = System.Windows.Forms.DockStyle.Fill;
			guiMainSettings_Version.Location = new System.Drawing.Point(153, 0);
			guiMainSettings_Version.Name = "guiMainSettings_Version";
			guiMainSettings_Version.Size = new System.Drawing.Size(590, 28);
			guiMainSettings_Version.TabIndex = 9;
			guiMainSettings_Changelog.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
			guiMainSettings_Changelog.Dock = System.Windows.Forms.DockStyle.Fill;
			guiMainSettings_Changelog.LinkBehavior = System.Windows.Forms.LinkBehavior.NeverUnderline;
			guiMainSettings_Changelog.LinkColor = System.Drawing.Color.Black;
			guiMainSettings_Changelog.Location = new System.Drawing.Point(153, 28);
			guiMainSettings_Changelog.Name = "guiMainSettings_Changelog";
			guiMainSettings_Changelog.Size = new System.Drawing.Size(590, 28);
			guiMainSettings_Changelog.TabIndex = 10;
			guiMainSettings_Changelog.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(guiMainSettings_Changelog_LinkClicked);
			guiMainSettings_RSpath.Dock = System.Windows.Forms.DockStyle.Fill;
			guiMainSettings_RSpath.Location = new System.Drawing.Point(153, 143);
			guiMainSettings_RSpath.Name = "guiMainSettings_RSpath";
			guiMainSettings_RSpath.Size = new System.Drawing.Size(590, 20);
			guiMainSettings_RSpath.TabIndex = 24;
			guiMainSettings_RSpath.Click += new System.EventHandler(guiMainSettings_RSpath_Click);
			label7.AutoSize = true;
			label7.Dock = System.Windows.Forms.DockStyle.Fill;
			label7.Font = new System.Drawing.Font("Sparkasse Rg", 9.75f, System.Drawing.FontStyle.Bold);
			label7.Location = new System.Drawing.Point(3, 168);
			label7.Name = "label7";
			label7.Size = new System.Drawing.Size(144, 28);
			label7.TabIndex = 28;
			label7.Text = "Qlog Path";
			label6.AutoSize = true;
			label6.Dock = System.Windows.Forms.DockStyle.Fill;
			label6.Font = new System.Drawing.Font("Sparkasse Rg", 9.75f, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, 0);
			label6.Location = new System.Drawing.Point(3, 196);
			label6.Name = "label6";
			label6.Size = new System.Drawing.Size(144, 28);
			label6.TabIndex = 29;
			label6.Text = "Filter queries";
			guiMainSettings_Keywords.Dock = System.Windows.Forms.DockStyle.Fill;
			guiMainSettings_Keywords.Location = new System.Drawing.Point(153, 199);
			guiMainSettings_Keywords.Name = "guiMainSettings_Keywords";
			guiMainSettings_Keywords.Size = new System.Drawing.Size(590, 20);
			guiMainSettings_Keywords.TabIndex = 27;
			guiMainSettings_QlogPath.Dock = System.Windows.Forms.DockStyle.Fill;
			guiMainSettings_QlogPath.Location = new System.Drawing.Point(153, 171);
			guiMainSettings_QlogPath.Name = "guiMainSettings_QlogPath";
			guiMainSettings_QlogPath.Size = new System.Drawing.Size(590, 20);
			guiMainSettings_QlogPath.TabIndex = 25;
			guiMainSettings_QlogPath.Click += new System.EventHandler(guiMainSettings_QlogPath_Click);
			guiMainSettings_DRMpath.Dock = System.Windows.Forms.DockStyle.Fill;
			guiMainSettings_DRMpath.Location = new System.Drawing.Point(153, 115);
			guiMainSettings_DRMpath.Name = "guiMainSettings_DRMpath";
			guiMainSettings_DRMpath.Size = new System.Drawing.Size(590, 20);
			guiMainSettings_DRMpath.TabIndex = 22;
			guiMainSettings_DRMpath.Click += new System.EventHandler(guiMainSettings_DRMpath_Click);
			guiMainSettings_LOGpath.Dock = System.Windows.Forms.DockStyle.Fill;
			guiMainSettings_LOGpath.Location = new System.Drawing.Point(153, 87);
			guiMainSettings_LOGpath.Name = "guiMainSettings_LOGpath";
			guiMainSettings_LOGpath.Size = new System.Drawing.Size(590, 20);
			guiMainSettings_LOGpath.TabIndex = 23;
			guiMainSettings_LOGpath.Click += new System.EventHandler(guiMainSettings_LOGpath_Click);
			label2.AutoSize = true;
			label2.Dock = System.Windows.Forms.DockStyle.Fill;
			label2.Font = new System.Drawing.Font("Sparkasse Rg", 9.75f, System.Drawing.FontStyle.Bold);
			label2.Location = new System.Drawing.Point(3, 84);
			label2.Name = "label2";
			label2.Size = new System.Drawing.Size(144, 28);
			label2.TabIndex = 1;
			label2.Text = "Log Path";
			label8.AutoSize = true;
			label8.Dock = System.Windows.Forms.DockStyle.Fill;
			label8.Font = new System.Drawing.Font("Sparkasse Rg", 9.75f, System.Drawing.FontStyle.Bold);
			label8.Location = new System.Drawing.Point(3, 112);
			label8.Name = "label8";
			label8.Size = new System.Drawing.Size(144, 28);
			label8.TabIndex = 7;
			label8.Text = "DRM Path";
			guiMainSettings_DRMpathOpen.DefaultExt = "exe";
			guiMainSettings_DRMpathOpen.FileName = "DotAReplayManager.exe";
			guiMainSettings_DRMpathOpen.Filter = "exe|*.exe";
			guiMainSettings_DRMpathOpen.Title = "Please select the DotA Replay Manager.exe";
			guiMainSettings_LogpathOpen.DefaultExt = "txt";
			guiMainSettings_LogpathOpen.FileName = "log.txt";
			guiMainSettings_LogpathOpen.Filter = "txt|*.txt";
			guiMainSettings_LogpathOpen.Title = "Please select the DRM log text file.";
			guiMainSettings_RSpathOpen.DefaultExt = "exe";
			guiMainSettings_RSpathOpen.FileName = "ReplaySeeker.exe";
			guiMainSettings_RSpathOpen.Filter = "exe|*.exe";
			guiMainSettings_RSpathOpen.Title = "Please select the ReplaySeeker.exe";
			guiMainSettings_QlogpathOpen.DefaultExt = "exe";
			guiMainSettings_QlogpathOpen.FileName = "qlog.exe";
			guiMainSettings_QlogpathOpen.Filter = "exe|*.exe";
			guiMainSettings_QlogpathOpen.Title = "Please select the qlog.exe";
			base.AutoScaleDimensions = new System.Drawing.SizeF(6f, 13f);
			base.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			base.ClientSize = new System.Drawing.Size(746, 263);
			base.Controls.Add(tableLayoutPanel1);
			base.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Fixed3D;
			base.Icon = (System.Drawing.Icon)resources.GetObject("$this.Icon");
			base.MaximizeBox = false;
			base.Name = "guiSettings";
			Text = "DotA Replay Manager Filter-Sharp :: Settings";
			tableLayoutPanel1.ResumeLayout(false);
			tableLayoutPanel1.PerformLayout();
			ResumeLayout(false);
		}
	}
}
