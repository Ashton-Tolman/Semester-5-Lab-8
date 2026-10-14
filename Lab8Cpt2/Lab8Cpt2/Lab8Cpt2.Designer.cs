namespace Lab8Cpt2
{
    partial class Lab8Cpt2
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            components = new System.ComponentModel.Container();
            ComListBox = new ListBox();
            PortsComboBox = new ComboBox();
            SerialTextBox = new TextBox();
            DataBitsTextBox = new TextBox();
            AN1CheckBox = new CheckBox();
            ExitButton = new Button();
            ConnectButton = new Button();
            ReadButton = new Button();
            SendButton = new Button();
            statusStrip1 = new StatusStrip();
            StatusLabel = new ToolStripStatusLabel();
            StatusTimer = new System.Windows.Forms.Timer(components);
            AnalogTimer = new System.Windows.Forms.Timer(components);
            statusStrip1.SuspendLayout();
            SuspendLayout();
            // 
            // ComListBox
            // 
            ComListBox.FormattingEnabled = true;
            ComListBox.Location = new Point(168, 12);
            ComListBox.Name = "ComListBox";
            ComListBox.Size = new Size(620, 154);
            ComListBox.TabIndex = 0;
            // 
            // PortsComboBox
            // 
            PortsComboBox.FormattingEnabled = true;
            PortsComboBox.Location = new Point(12, 12);
            PortsComboBox.Name = "PortsComboBox";
            PortsComboBox.Size = new Size(150, 33);
            PortsComboBox.TabIndex = 1;
            // 
            // SerialTextBox
            // 
            SerialTextBox.Location = new Point(12, 51);
            SerialTextBox.Name = "SerialTextBox";
            SerialTextBox.Size = new Size(150, 31);
            SerialTextBox.TabIndex = 2;
            // 
            // DataBitsTextBox
            // 
            DataBitsTextBox.Location = new Point(12, 88);
            DataBitsTextBox.Name = "DataBitsTextBox";
            DataBitsTextBox.Size = new Size(150, 31);
            DataBitsTextBox.TabIndex = 3;
            // 
            // AN1CheckBox
            // 
            AN1CheckBox.AutoSize = true;
            AN1CheckBox.Location = new Point(12, 125);
            AN1CheckBox.Name = "AN1CheckBox";
            AN1CheckBox.Size = new Size(73, 29);
            AN1CheckBox.TabIndex = 4;
            AN1CheckBox.Text = "AN1";
            AN1CheckBox.UseVisualStyleBackColor = true;
            // 
            // ExitButton
            // 
            ExitButton.Location = new Point(667, 172);
            ExitButton.Name = "ExitButton";
            ExitButton.Size = new Size(121, 62);
            ExitButton.TabIndex = 5;
            ExitButton.Text = "E&xit";
            ExitButton.UseVisualStyleBackColor = true;
            ExitButton.Click += ExitButton_Click;
            // 
            // ConnectButton
            // 
            ConnectButton.Location = new Point(540, 172);
            ConnectButton.Name = "ConnectButton";
            ConnectButton.Size = new Size(121, 62);
            ConnectButton.TabIndex = 6;
            ConnectButton.Text = "&Connect";
            ConnectButton.UseVisualStyleBackColor = true;
            ConnectButton.Click += ConnectButton_Click;
            // 
            // ReadButton
            // 
            ReadButton.Location = new Point(413, 172);
            ReadButton.Name = "ReadButton";
            ReadButton.Size = new Size(121, 62);
            ReadButton.TabIndex = 7;
            ReadButton.Text = "&Read";
            ReadButton.UseVisualStyleBackColor = true;
            ReadButton.Click += ReadButton_Click;
            // 
            // SendButton
            // 
            SendButton.Location = new Point(286, 172);
            SendButton.Name = "SendButton";
            SendButton.Size = new Size(121, 62);
            SendButton.TabIndex = 8;
            SendButton.Text = "&Send";
            SendButton.UseVisualStyleBackColor = true;
            SendButton.Click += SendButton_Click;
            // 
            // statusStrip1
            // 
            statusStrip1.ImageScalingSize = new Size(24, 24);
            statusStrip1.Items.AddRange(new ToolStripItem[] { StatusLabel });
            statusStrip1.Location = new Point(0, 418);
            statusStrip1.Name = "statusStrip1";
            statusStrip1.Size = new Size(800, 32);
            statusStrip1.TabIndex = 9;
            statusStrip1.Text = "statusStrip1";
            // 
            // StatusLabel
            // 
            StatusLabel.Name = "StatusLabel";
            StatusLabel.Size = new Size(42, 25);
            StatusLabel.Text = "Text";
            // 
            // StatusTimer
            // 
            StatusTimer.Enabled = true;
            StatusTimer.Tick += StatusTimer_Tick;
            // 
            // AnalogTimer
            // 
            AnalogTimer.Interval = 250;
            // 
            // Lab8Cpt2
            // 
            AutoScaleDimensions = new SizeF(10F, 25F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 450);
            Controls.Add(statusStrip1);
            Controls.Add(SendButton);
            Controls.Add(ReadButton);
            Controls.Add(ConnectButton);
            Controls.Add(ExitButton);
            Controls.Add(AN1CheckBox);
            Controls.Add(DataBitsTextBox);
            Controls.Add(SerialTextBox);
            Controls.Add(PortsComboBox);
            Controls.Add(ComListBox);
            Name = "Lab8Cpt2";
            Text = "Lab8Cpt2";
            statusStrip1.ResumeLayout(false);
            statusStrip1.PerformLayout();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private ListBox ComListBox;
        private ComboBox PortsComboBox;
        private TextBox SerialTextBox;
        private TextBox DataBitsTextBox;
        private CheckBox AN1CheckBox;
        private Button ExitButton;
        private Button ConnectButton;
        private Button ReadButton;
        private Button SendButton;
        private StatusStrip statusStrip1;
        private ToolStripStatusLabel StatusLabel;
        private System.Windows.Forms.Timer StatusTimer;
        private System.Windows.Forms.Timer AnalogTimer;
    }
}
