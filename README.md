# myLittleDooMHelper
Simple scripts to aid in the instalation of DooM source ports and multiplayer clients. **Instalation instructions are inside each of the files.**

**IMPORTANT:** This guide assumes that you have the needed **.wad** files (**doom.wad**, **doom2.wad**, **plutonia.wad**, **tnt.wad**) to run the game. I will be giving and example with my configuration and as such simply **replace “emil” with your user name**.

### Doomseeker Configuration
1. Go to **Options** → **Configure** (or press **F5**)
![title](/imageInstructions/doomseeker.jpg)
2. Check the executable paths for the engine you wish to use for on-line play. In our case they should both be in **/usr/bin** since that is where the install script places the executable paths for Zandronum. ![title](/imageInstructions/doomseeker2.jpg)
3. Under **File Paths** add the location of where your **.wad** files are located and where you would like **Wadseeker** to download new **.wad** files. In my case the I have added the last two paths, respectively.![title](/imageInstructions/doomseeker3.jpg)
4. Under **Wadseeker** → **General** simply select the desired downloads folder. In my case it is the last one from the list. ![title](/imageInstructions/doomseeker3.jpg)

#### Zandronum and GZDoom (ZDoom, QZDoom) configuration

The image bellow shows my Zandronum configuration however this works for almost all source ports. The last two lines in both **[IWADSearch.Directories]** and **[FileSearch.Directories]** categories are the important ones.

![title](/imageInstructions/wadpath.jpg)
1. Find the appropriate **.ini** file. For all three it will be located in either your home folder as a hidden folder (like **~/.zandronum/** or **~/.gzdoom/**) or in the **~/.config/gzdoom/** folder.

2. There add the paths to your **.wad** files as shown bellow. In both **[IWADSearch.Directories]** and **[FileSearch.Directories]** I have added the last two paths. The **wadsToLoad/** to load directory is there so that when the **-file** flag is used to load one or more **.wad** or **.pk3** files the source port knows where to look for them
