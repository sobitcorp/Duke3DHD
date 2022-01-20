# Duke3DHD - HD and Widescreen in DOS Duke3D

**Requirements:**
* Duke3D (any v1.3 - v1.5)
* A DOS/Win9x machine, DOSBox, or similar DOS emulator

**Installation:**
1. Download the latest release [[here](https://github.com/sobitcorp/Duke3DHD/releases/download/v1.5.1/Duke3DHD-v1.5.1.zip)]
2. Extract into your Duke3D directory. Overwrite ART files at your discretion. Your regular DUKE3D.EXE will not be overwritten.
3. Run DUKE3DHD.EXE

**Removal:**
To run Duke3D without HD textures, simply delete/move/rename the ART files and run your regular DUKE3D.EXE

**Controls:**
Press F11 in-game to toggle widescreen.

**Resolutions:**
The following are supported:
* 320x200
* 640x480
* 800x600
* 1024x768 *
* 1280x1024 *

*You need to manually edit `ScreenWidth` and `ScreenHeight` in your `DUKE3D.CFG` to set these.

The widescreen effect is achieved by playing on a widescreen monitor and letting it stretch the signal to fill the screen.

For advanced users: you can customize the widescreen ratio by manually modifying `Widescreen` and `WidescreenMenus` in your `DUKE3D.CFG`, where the value is calculated using (height / width) * (320 / 0.75). Set both values to 1 to revert to the default width:height ratio of 16:9.

# HD textures

All but one of the upscaled tiles come from [Phredreeke's Enhanced Resource Pack](https://www.moddb.com/mods/enhanced-resource-pack-for-duke-nukem-3d).

See the README in [tiles/](https://github.com/sobitcorp/Duke3DHD/tree/main/tiles#readme) for more information and technical details.

# What's in this repo
```
DUKE3DHD.EXE - The modified Duke3D binary which properly handles HD textures and supports widescreen.
bastART.exe  - ART file manipulation tool
COMDLG32.OCX - For bastART
src/         - Source code for DUKE3DHD.EXE
bastart/     - Source code for bastART
tiles/       - HD tiles and supporting documentation
screenshots/ - Scroll down
```


# Screenshots

**Before**
![Comparison](/screenshots/DUKE0000a.PNG)


**After**
![Comparison](/screenshots/DUKE0000.PNG)
![Comparison](/screenshots/DUKE0001.PNG)
![Comparison](/screenshots/DUKE0002.PNG)
![Comparison](/screenshots/DUKE0003.PNG)

