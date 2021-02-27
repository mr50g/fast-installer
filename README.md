# fast-installer
Script allows to fast download and install supported applications.

## How to run
1. Download the repository and unpack it in any folder. 
2. Hold Shift and click the right mouse button in the folder. Choose option "Open a PowerShell window here". 
3. In a new window type an undermentioned command and click Enter to install Firefox. You can choose another application mentioned in a table below.
    ```batch
    powershell -ExecutionPolicy Bypass -File .\fast-installer.ps1 firefox
    ```
    You can also input more arguments into the script:
    ```batch
    powershell -ExecutionPolicy Bypass -File .\fast-installer.ps1 chrome firefox opera_gx
    ```

## Create shortcut
1. In the folder, where you unpack the repository, click the right mouse button, choose New and choose Shortcut. 
2. In new window paste command
    ```batch
    powershell -ExecutionPolicy Bypass -File .\fast-installer.ps1 firefox
    ```
    This command will install Firefox but you can change `firefox` to another argument or input more arguments. 
3. Click Next. 
4. In textbox input filename for shortcut for example "Fast Install Firefox" and click Close. 
5. Click the right mouse button on the created shortcut and choose option Properties. 
6. Delete the text in the Start in textbox.

## Supported installers
| Application  | Version | Command argument | 
| ------------ | ------- | ---------------- |
| Chrome       | latest  | `chrome`         |
| Firefox      | latest  | `firefox`        |
| Opera GX     | latest  | `opera_gx`       |