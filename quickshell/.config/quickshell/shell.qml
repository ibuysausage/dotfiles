import Quickshell
import QtQuick
import Quickshell.Io
// import "wallpaper"

// WallpaperManager {}

PanelWindow {
     
    color: "transparent"//#304039"
    anchors {
        //top: true
        //left: true
        //right: false
    }

    implicitHeight: 600
    implicitWidth: 800
    
    Rectangle {

        anchors.fill: parent
        
        radius: 30
        color: "#304039"

        Text {

            id: output
            anchors.centerIn: parent
        
            font.family: "CaskaydiaCove Nerd Font"
            font.pointSize: 12
            color: "yellow"
        
            Process {
                id: dateProc

                command: ["cowsay", "-r", "its a mee"]
                running: true
            
                stdout: StdioCollector {
                    onStreamFinished: output.text = this.text
                }
            }
        }
    }

    Timer {
            
        interval: 1700

        running: true

        repeat: true

        onTriggered: dateProc.running = true
    }
}
