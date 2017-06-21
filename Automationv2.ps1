<#
    .INFO
        - Author: Perry Trinh
        - Company: Ariento
        - Start Date: June 1 2017

    .OVERVIEW
        - Automate software installation

    .INPUT
        - Nothing, user selects which software to install
        - Might need user credentials

    .OUTPUT
        - Nothing, directly installs

    .SUPPORTS
        - Changing Computer Name
        - Defering feature updates
        - Installing Windows Update
        - Sophos
        - Office 365
        - Disabling Bluetooth
        - NinitePro (Chrome, Firefox ESR, Reader, Java, Silverlight)
        - Firefox Stig cfg
        - Cloudberry
        - OpenDNS
        - Prey
        - Virtru
        - Safenet
#>

function main {
    $userName = 'phtrinh'
    #Copy-Item "D:\Install\" ("C:\users\" + $userName + "\Desktop\") -Recurse
    #$installPath = ("C:\Users\" + $userName + "\Desktop\Install")

    $selectedSoftware = SoftwareForm
    $selectedSoftware | foreach {
        if ($_ -eq "Change Computer Name") {
            $newComputerName = promptNewCompName
            #$comp = gmwi win32_computersystem
	        #$comp.Rename($newComputerName)
        }
        if ($_ -eq "Defer Feature Updates") {
            Write-Output "Deferring Feature Updates..."
            
        }
        if ($_ -eq "Install Windows Updates") {
            Write-Output "Installing Windows Updates..."
            #cmd /c net stop wuauserv
        }
        if ($_ -eq "Sophos") {
            Write-Output "Installing Sophos..."
            
        }
        if ($_ -eq "Office 365") {
            Write-Output "Installing Office365..."
            #cmd /c start /b /wait ($installPath + '\Microsoft\setupo365proplusretail.x86.en-us_b_64_.exe')
        }
        if ($_ -eq "Disable Bluetooth") {
            Write-Output "Disabling Bluetooth..."
        }
        if ($_ -eq "NinitePro-Chrome, Firefox, Reader, Java, Silverlight") {
            Write-Output "Installing with NinitePro..."
            #cmd /c start /b /wait ($installPath + '\NinitePro\NinitePro.exe') /select Chrome "Firefox ESR" Java Silverlight Reader
        }
        if ($_ -eq "Firefox Stig cfg") {
            Write-Output "Moving Firefox stig cfg files..."
            #Copy-Item ($installPath + '\Mozilla Firefox\ariento-default.cfg') 'C:\Program Files (x86)\Mozilla Firefox\'
	        #Copy-Item ($installPath + '\Mozilla Firefox\defaults\') 'C:\Program Files (x86)\Mozilla Firefox\' -Recurse
        }
        if ($_ -eq "Cloudberry") {
            Write-Output "Installing Cloudberry..."
            #cmd /c start /b /wait ($installPath + '\Cloudberry\vcredit_x64.exe') /qb
	        #cmd /c start /b /wait ($installPath + '\Cloudberry\CB_GUI_v5.5.2.32.exe') /s
        }
        if ($_ -eq "OpenDNS") {
            Write-Output "Installing OpenDNS..."
            Add-Type -Assembly "system.io.compression.filesystem"
	    $zippath = ($installPath + "\OpenDNS\ARIENTO-OpenDNS.zip")
	    $destination = ("C:\users\" + $userName + "\desktop\")
	    [io.compression.zipfile]::ExtractToDirectory($zippath, $destination)
	    
        }
        if ($_ -eq "Prey") {
            Write-Output "Installing Prey..."

        }
        if ($_ -eq "Virtru") {
            Write-Output "Installing Virtru..."

        }
        if ($_ -eq "SafeNet") {
            Write-Output "Installing Safenet..."

        }
    }
}

function promptNewCompName {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Rename Computer"
    $form.StartPosition = "CenterScreen"
    $form.Size = New-Object System.Drawing.Size(300,150)
    $form.MaximizeBox = $False
    $form.WindowState = "Normal"
    $form.SizeGripStyle = "Hide"
    $form.TopMost = $True
    $form.FormBorderStyle = "Fixed3D"
    $form.Icon = New-Object System.Drawing.Icon ("D:\Install\00 WIN10\PostInstall\arientosupport.ico")
    
    $font = New-Object System.Drawing.Font("Arial", 9, [System.Drawing.FontStyle]::Regular)
    $form.Font = $font

    $label = New-Object System.Windows.Forms.Label
    $label.Location = New-Object System.Drawing.Size(40,20)
    $label.Size = New-Object System.Drawing.Size(200,23)
    $label.Text = "Enter New Computer Name:"
    $form.Controls.Add($label)

    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Location = New-Object System.Drawing.Size(40, 45)
    $textBox.Size = New-object System.Drawing.Size(200, 20)
    $form.Controls.Add($textBox) 

    $OKButton = New-Object System.Windows.Forms.Button
    $OKButton.Location = New-Object System.Drawing.Size(105,80)
    $OKButton.Size = New-Object System.Drawing.Size(75,23)
    $OKButton.Text = "OK"
    $OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form.AcceptButton = $OKButton
    $form.Controls.Add($OKButton)

    $result = $form.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        return $textBox.Text
    }
}

function SoftwareForm {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $form = New-Object System.Windows.Forms.Form 
    $form.Text = "Ariento Software Installer"
    $form.StartPosition = "CenterScreen"
    $form.ClientSize = New-Object System.Drawing.Size(450,300)
    $form.MaximizeBox = $False
    $form.WindowState = "Normal"
    $form.SizeGripStyle = "Hide"
    $form.TopMost = $True
    $form.FormBorderStyle = "Fixed3D"
    $form.Icon = New-Object System.Drawing.Icon ("D:\Install\00 WIN10\PostInstall\arientosupport.ico")

    $font = New-Object System.Drawing.Font("Arial", 9, [System.Drawing.FontStyle]::Regular)
    $form.Font = $font

    $OKButton = New-Object System.Windows.Forms.Button
    $OKButton.Location = New-Object System.Drawing.Point(335,90)
    $OKButton.Size = New-Object System.Drawing.Size(75,23)
    $OKButton.Text = "OK"
    $OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form.AcceptButton = $OKButton
    $form.Controls.Add($OKButton)

    $CancelButton = New-Object System.Windows.Forms.Button
    $CancelButton.Location = New-Object System.Drawing.Point(335,125)
    $CancelButton.Size = New-Object System.Drawing.Size(75,23)
    $CancelButton.Text = "Cancel"
    $CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $form.CancelButton = $CancelButton
    $form.Controls.Add($CancelButton)

    $label = New-Object System.Windows.Forms.Label
    $label.Location = New-Object System.Drawing.Point(10,20) 
    $label.Size = New-Object System.Drawing.Size(280,20) 
    $label.Text = "Select Actions/Programs to Install:"
    $form.Controls.Add($label) 

    $listBox = New-Object System.Windows.Forms.ListBox 
    $listBox.Location = New-Object System.Drawing.Point(10,40) 
    $listBox.Size = New-Object System.Drawing.Size(290,240) 
    $listBox.SelectionMode = "MultiExtended"

    [void] $listBox.Items.Add("Change Computer Name")
    [void] $listBox.Items.Add("Defer Feature Updates")
    [void] $listBox.Items.Add("Install Windows Updates")
    [void] $listBox.Items.Add("Sophos")
    [void] $listBox.Items.Add("Office 365")
    [void] $listBox.Items.Add("Disable Bluetooth")
    [void] $listBox.Items.Add("NinitePro-Chrome, Firefox, Reader, Java, Silverlight")
    [void] $listBox.Items.Add("Firefox Stig cfg")
    [void] $listBox.Items.Add("Cloudberry")
    [void] $listBox.Items.Add("OpenDNS")
    [void] $listBox.Items.Add("Prey")
    [void] $listBox.Items.Add("Virtru")
    [void] $listBox.Items.Add("Safenet")
    [void] $listBox.Items.Add("PostInstall Folder Move")
    [void] $listBox.Items.Add("Change Wallpaper")
    $form.Controls.Add($listBox) 

    $result = $form.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        return $listBox.SelectedItems
    }    
}

main

#zohar check in