# Windows 11 Personalisation for Bill

#Set Paths
$Blob = 'https://github.com/Trael-Kun/Win11_Personalise/blob/main'
$BackgroundsDir = "$env:LOCALAPPDATA\Backgrounds"
$jsonFile = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

$NewPaths = @(
    @{Path='HKCU:\Software\Classes\CLSID\';                                                         Name='{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}'}                                  #Full Context Menus
    @{Path='HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}';                   Name='InprocServer32'}                                                          #Full Context Menus
    @{Path='HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\';                                   Name='MTCUVC'}                                                                  #Classic Volume Control
    @{Path='HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\';                                      Name='PersonalizationCSP'}                                                      #Lock Screen
)
$NewValues = @(
    @{Path='HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32';    PropertyType=DWORD;     Name='(default)';               Value=$null}            # Full Context Menus
    @{Path='HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\';                    PropertyType=DWORD;     Name=TaskbarAl;                 Value=0}                # Align Taskbar Left
    @{Path='HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\';                    PropertyType=DWORD;     Name=TaskbarSi;                 Value=0}                # Taskbar Size Small
    @{Path='HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\';                    PropertyType=DWORD;     Name=ShowSecondsInSystemClock;  Value=1}                # Show seconds in Taskbar clock
    @{Path='HKCU:\Software\Microsoft\Windows\Themes\Personalize';                                   PropertyType=DWORD;     Name=AppsUseLightTheme;         Value=0}                # Dark mode
    @{Path='HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP';                    PropertyType=DWORD;     Name=LockScreenImageStatus;     Value=00000001}         #Lock Screen
    @{Path='HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP';                    PropertyType=;          Name=LockScreenImagePath;       Value="$BackgroundsDir\beakr.jpeg"}
    @{Path='HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System';                       PropertyType=STRING;    Name=Wallpaper                  Value=''}               # Set Wallpaper image
    @{Path='HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System';                       PropertyType=STRING;    Name=WallpaperStyle             Value=3}                # Set Wallpaper style (0=Center,1=Tile,2=Stretch,3=Fit,4=Fill,5=Span)
    @{Path='HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer';                              PropertyType=DWORD;     Name=Start_ShowClassicMode;     Value=1}                # Revert to Windows 10-style start menu (I don't think this works)
    @{Path='HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion';                                    PropertyType=STRING;    Name=RegisteredOwner;           Value='William Wilson'} # Set Registered Owner
    @{Path='HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion';                                    PropertyType=STRING;    Name=RegisteredOrganization;    Value='Awesome Inc.'}   # Set Registered Org
    @{Path='HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC';                             PropertyType=DWORD;     Name=EnableMtcUvc;              Value=0}                # Classic Volume Control
)
$WebRequests = @(
    @{URL="$Blob\beakr.jpeg";                                                                       $OutFile=$BackgroundsDir}
    @{URL="$Blob\Bunsen2.png";                                                                      $OutFile=$BackgroundsDir}
    @{URL="$Blob\ihavethepower(shell).jpg";                                                         $OutFile=$BackgroundsDir}
    @{URL="$Blob\settings.json";                                                                    $OutFile=$jsonFile}
)



# Create New Keys
foreach ($NewPath in $NewPaths) {
    if (!(Test-Path -Path $NewPath.Path))
    New-Item -Path $NewPath.Path -Name $NewPath.Path    
}

# Create new values
foreach ($NewValue in $NewValues) {
    New-ItemProperty -Path $NewValue.Path -PropertyType $NewValue.PropertyType -Name $NewValue.Name -Value $NewValue.Value
}

#Fetch Files
foreach ($WebRequest in $WebRequests) {
    Invoke-WebRequest $WebRequest.Path -OutFile $WebRequest.OutFile
}

#Set Terminal Personalisation
$jsonValue = '{
    "$help": "https://aka.ms/terminal-documentation",
    "$schema": "https://aka.ms/terminal-profiles-schema",
    "actions": 
    [
        {
            "command": 
            {
                "action": "copy",
                "singleLine": false
            },
            "keys": "ctrl+c"
        },
        {
            "command": "paste",
            "keys": "ctrl+v"
        },
        {
            "command": "find",
            "keys": "ctrl+shift+f"
        },
        {
            "command": 
            {
                "action": "splitPane",
                "split": "auto",
                "splitMode": "duplicate"
            },
            "keys": "alt+shift+d"
        }
    ],
    "copyFormatting": "none",
    "copyOnSelect": false,
    "defaultProfile": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}",
    "newTabMenu": 
    [
        {
            "type": "remainingProfiles"
        }
    ],
    "profiles": 
    {
        "defaults": {},
        "list": 
        [
            {
                "adjustIndistinguishableColors": "always",
                "backgroundImage": "C:\\Users\\willw142\\OneDrive - National Archives of Australia\\images\\Corp Teams\\21.09.01 GT_NAPF_2 copy.png",
                "backgroundImageOpacity": 0.5,
                "commandline": "%SystemRoot%\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
                "cursorShape": "vintage",
                "experimental.retroTerminalEffect": true,
                "guid": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}",
                "hidden": false,
                "name": "Pwsh it real good"
            },
            {
                "adjustIndistinguishableColors": "always",
                "backgroundImage": "C:\\Users\\willw142\\OneDrive - National Archives of Australia\\images\\Corp Teams\\21.09__ GT_NAA.png",
                "backgroundImageAlignment": "topLeft",
                "backgroundImageOpacity": 0.5,
                "commandline": "%SystemRoot%\\System32\\cmd.exe",
                "cursorShape": "filledBox",
                "experimental.retroTerminalEffect": true,
                "font": 
                {
                    "face": "Cascadia Code",
                    "size": 10.0,
                    "weight": "normal"
                },
                "guid": "{0caa0dad-35be-5f56-a8ff-afceeeaa6101}",
                "hidden": false,
                "intenseTextStyle": "all",
                "name": "CLI me a river"
            },
            {
                "guid": "{b453ae62-4e3d-5e58-b989-0a998ec441b8}",
                "hidden": true,
                "name": "Azure Cloud Shell",
                "source": "Windows.Terminal.Azure"
            },
            {
                "altGrAliasing": true,
                "antialiasingMode": "grayscale",
                "backgroundImage": "%LocalAppData%\\Backgrounds\\ihavethepower(shell).jpg",
                "backgroundImageOpacity": 0.49,
                "closeOnExit": "graceful",
                "colorScheme": "Campbell Powershell",
                "commandline": "%SystemRoot%\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
                "cursorShape": "bar",
                "elevate": true,
                "font": 
                {
                    "face": "Consolas",
                    "size": 12.0
                },
                "guid": "{73ce4b8f-4c11-4601-8ce5-58d0a06f775e}",
                "hidden": false,
                "historySize": 9001,
                "icon": "ms-appx:///ProfileIcons/{61c54bbd-c2c6-5271-96e7-009a87ff44bf}.png",
                "name": "[Admin] I Have The Power(Shell)",
                "padding": "8, 8, 8, 8",
                "snapOnInput": true,
                "startingDirectory": null,
                "useAcrylic": true
            },
            {
                "altGrAliasing": true,
                "antialiasingMode": "grayscale",
                "backgroundImage": "%LocalAppData%\\Backgrounds\\Bunsen2.png",
                "backgroundImageAlignment": "bottomRight",
                "backgroundImageOpacity": 0.5,
                "closeOnExit": "graceful",
                "colorScheme": "Tango Dark",
                "commandline": "%SystemRoot%\\System32\\cmd.exe",
                "cursorShape": "bar",
                "elevate": true,
                "font": 
                {
                    "face": "Cascadia Code",
                    "size": 12.0
                },
                "guid": "{31c57968-391f-43f5-91ad-22d92e074182}",
                "hidden": false,
                "historySize": 9001,
                "icon": "ms-appx:///ProfileIcons/{0caa0dad-35be-5f56-a8ff-afceeeaa6101}.png",
                "name": "[Admin] Cmd, where the future is being made today",
                "padding": "8, 8, 8, 8",
                "snapOnInput": true,
                "startingDirectory": null,
                "useAcrylic": false
            }
        ]
    },
    "schemes": 
    [
        {
            "background": "#0C0C0C",
            "black": "#0C0C0C",
            "blue": "#0037DA",
            "brightBlack": "#767676",
            "brightBlue": "#3B78FF",
            "brightCyan": "#61D6D6",
            "brightGreen": "#16C60C",
            "brightPurple": "#B4009E",
            "brightRed": "#E74856",
            "brightWhite": "#F2F2F2",
            "brightYellow": "#F9F1A5",
            "cursorColor": "#FFFFFF",
            "cyan": "#3A96DD",
            "foreground": "#CCCCCC",
            "green": "#13A10E",
            "name": "Campbell",
            "purple": "#881798",
            "red": "#C50F1F",
            "selectionBackground": "#FFFFFF",
            "white": "#CCCCCC",
            "yellow": "#C19C00"
        },
        {
            "background": "#012456",
            "black": "#0C0C0C",
            "blue": "#0037DA",
            "brightBlack": "#767676",
            "brightBlue": "#3B78FF",
            "brightCyan": "#61D6D6",
            "brightGreen": "#16C60C",
            "brightPurple": "#B4009E",
            "brightRed": "#E74856",
            "brightWhite": "#F2F2F2",
            "brightYellow": "#F9F1A5",
            "cursorColor": "#FFFFFF",
            "cyan": "#3A96DD",
            "foreground": "#CCCCCC",
            "green": "#13A10E",
            "name": "Campbell Powershell",
            "purple": "#881798",
            "red": "#C50F1F",
            "selectionBackground": "#FFFFFF",
            "white": "#CCCCCC",
            "yellow": "#C19C00"
        },
        {
            "background": "#282C34",
            "black": "#282C34",
            "blue": "#61AFEF",
            "brightBlack": "#5A6374",
            "brightBlue": "#61AFEF",
            "brightCyan": "#56B6C2",
            "brightGreen": "#98C379",
            "brightPurple": "#C678DD",
            "brightRed": "#E06C75",
            "brightWhite": "#DCDFE4",
            "brightYellow": "#E5C07B",
            "cursorColor": "#FFFFFF",
            "cyan": "#56B6C2",
            "foreground": "#DCDFE4",
            "green": "#98C379",
            "name": "One Half Dark",
            "purple": "#C678DD",
            "red": "#E06C75",
            "selectionBackground": "#FFFFFF",
            "white": "#DCDFE4",
            "yellow": "#E5C07B"
        },
        {
            "background": "#FAFAFA",
            "black": "#383A42",
            "blue": "#0184BC",
            "brightBlack": "#4F525D",
            "brightBlue": "#61AFEF",
            "brightCyan": "#56B5C1",
            "brightGreen": "#98C379",
            "brightPurple": "#C577DD",
            "brightRed": "#DF6C75",
            "brightWhite": "#FFFFFF",
            "brightYellow": "#E4C07A",
            "cursorColor": "#4F525D",
            "cyan": "#0997B3",
            "foreground": "#383A42",
            "green": "#50A14F",
            "name": "One Half Light",
            "purple": "#A626A4",
            "red": "#E45649",
            "selectionBackground": "#FFFFFF",
            "white": "#FAFAFA",
            "yellow": "#C18301"
        },
        {
            "background": "#002B36",
            "black": "#002B36",
            "blue": "#268BD2",
            "brightBlack": "#073642",
            "brightBlue": "#839496",
            "brightCyan": "#93A1A1",
            "brightGreen": "#586E75",
            "brightPurple": "#6C71C4",
            "brightRed": "#CB4B16",
            "brightWhite": "#FDF6E3",
            "brightYellow": "#657B83",
            "cursorColor": "#FFFFFF",
            "cyan": "#2AA198",
            "foreground": "#839496",
            "green": "#859900",
            "name": "Solarized Dark",
            "purple": "#D33682",
            "red": "#DC322F",
            "selectionBackground": "#FFFFFF",
            "white": "#EEE8D5",
            "yellow": "#B58900"
        },
        {
            "background": "#FDF6E3",
            "black": "#002B36",
            "blue": "#268BD2",
            "brightBlack": "#073642",
            "brightBlue": "#839496",
            "brightCyan": "#93A1A1",
            "brightGreen": "#586E75",
            "brightPurple": "#6C71C4",
            "brightRed": "#CB4B16",
            "brightWhite": "#FDF6E3",
            "brightYellow": "#657B83",
            "cursorColor": "#002B36",
            "cyan": "#2AA198",
            "foreground": "#657B83",
            "green": "#859900",
            "name": "Solarized Light",
            "purple": "#D33682",
            "red": "#DC322F",
            "selectionBackground": "#FFFFFF",
            "white": "#EEE8D5",
            "yellow": "#B58900"
        },
        {
            "background": "#000000",
            "black": "#000000",
            "blue": "#3465A4",
            "brightBlack": "#555753",
            "brightBlue": "#729FCF",
            "brightCyan": "#34E2E2",
            "brightGreen": "#8AE234",
            "brightPurple": "#AD7FA8",
            "brightRed": "#EF2929",
            "brightWhite": "#EEEEEC",
            "brightYellow": "#FCE94F",
            "cursorColor": "#FFFFFF",
            "cyan": "#06989A",
            "foreground": "#D3D7CF",
            "green": "#4E9A06",
            "name": "Tango Dark",
            "purple": "#75507B",
            "red": "#CC0000",
            "selectionBackground": "#FFFFFF",
            "white": "#D3D7CF",
            "yellow": "#C4A000"
        },
        {
            "background": "#FFFFFF",
            "black": "#000000",
            "blue": "#3465A4",
            "brightBlack": "#555753",
            "brightBlue": "#729FCF",
            "brightCyan": "#34E2E2",
            "brightGreen": "#8AE234",
            "brightPurple": "#AD7FA8",
            "brightRed": "#EF2929",
            "brightWhite": "#EEEEEC",
            "brightYellow": "#FCE94F",
            "cursorColor": "#000000",
            "cyan": "#06989A",
            "foreground": "#555753",
            "green": "#4E9A06",
            "name": "Tango Light",
            "purple": "#75507B",
            "red": "#CC0000",
            "selectionBackground": "#FFFFFF",
            "white": "#D3D7CF",
            "yellow": "#C4A000"
        },
        {
            "background": "#000000",
            "black": "#000000",
            "blue": "#000080",
            "brightBlack": "#808080",
            "brightBlue": "#0000FF",
            "brightCyan": "#00FFFF",
            "brightGreen": "#00FF00",
            "brightPurple": "#FF00FF",
            "brightRed": "#FF0000",
            "brightWhite": "#FFFFFF",
            "brightYellow": "#FFFF00",
            "cursorColor": "#FFFFFF",
            "cyan": "#008080",
            "foreground": "#C0C0C0",
            "green": "#008000",
            "name": "Vintage",
            "purple": "#800080",
            "red": "#800000",
            "selectionBackground": "#FFFFFF",
            "white": "#C0C0C0",
            "yellow": "#808000"
        }
    ],
    "themes": []
}'
