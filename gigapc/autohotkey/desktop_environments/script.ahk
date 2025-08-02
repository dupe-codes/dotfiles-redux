#SingleInstance Force
SetWorkingDir(A_ScriptDir) ; Ensure DLL path is correct

; Load VirtualDesktopAccessor DLL
VDA_PATH := A_ScriptDir . "\VirtualDesktopAccessor.dll"
hVDA := DllCall("LoadLibrary", "Str", VDA_PATH, "Ptr")

; Load function pointers
GetDesktopCountProc := DllCall("GetProcAddress", "Ptr", hVDA, "AStr", "GetDesktopCount", "Ptr")
GoToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVDA, "AStr", "GoToDesktopNumber", "Ptr")
CreateDesktopProc := DllCall("GetProcAddress", "Ptr", hVDA, "AStr", "CreateDesktop", "Ptr")

; Define desktops and associated programs
desktopEnvs := Map(
    1, ["Visual Studio Code", "vivaldi.exe"],
    2, ["Notepad++", "cmd.exe", "powershell.exe"],
    3, ["Steam", "Discord.exe"],
    4, ["Blender", "krita.exe"]
)

currentDesktops := Map() ; Tracks created desktops

GetDesktopCount() {
    global GetDesktopCountProc
    count := DllCall(GetDesktopCountProc, "Int")
    return count
}

CreateDesktop() {
    global CreateDesktopProc
    ran := DllCall(CreateDesktopProc, "Int")
    return ran
}

MsgBox(GetDesktopCount())

; Function to switch to or create a desktop
SwitchToDesktop(index) {
    global GoToDesktopNumberProc, CreateDesktopProc, currentDesktops

    if (currentDesktops.Has(index)) {
        ; If desktop exists, switch to it
        DllCall(GoToDesktopNumberProc, "Int", index-1, "Int")
    } else {
        ; Otherwise, create the desktop and switch
        CreateDesktop() 
        Sleep(500)  ; Delay for stability
        DllCall(GoToDesktopNumberProc, "Int", index-1, "Int")

        ; Ask the user to select a program to launch
        programs := desktopEnvs[index]
        choice := ChooseFromList(programs, "Select a program to open on Desktop " index)
        if (choice) {
            Run(choice)
            currentDesktops[index] := true  ; Mark the desktop as created
        }
    }
}

; Function to prompt user to select a program
ChooseFromList(options, title := "Select an Option") {
    gui := Gui(, title)
    gui.SetFont("s12")
    listbox := gui.Add("ListBox", "w300 h150", options*)
    gui.Add("Button", "Default", "OK").OnEvent("Click", (*) => gui.Destroy()) ; Close on button click
    gui.Show()

    ; Wait for user input
    while gui.Visible
        Sleep(50)

    return listbox.Text
}

; Assign hotkeys for Win+1 to Win+4
For i in desktopEnvs {
    indexCopy := i  ; Capture stable index
    Hotkey("#" i, (*) => SwitchToDesktop(indexCopy))
}
