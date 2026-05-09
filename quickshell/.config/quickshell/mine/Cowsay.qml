import Quickshell
import QtQuick
import Quickshell.Io

PanelWindow {

    color: "transparent"

    implicitWidth: 950
    implicitHeight: 790

    Rectangle {
        
        color: "#304039"
        anchors.fill: parent

        radius: 20


        Text {
            id: cowsay
        
            anchors.centerIn: parent
            font.kerning: false
            font.family: "CaskaydiaCove Nerd Font"
            font.pixelSize: 17
            color: "yellow"

            Process {
                id: cowsayProc
                command: ["cowsay", "-r", "its a mee"]

                running: true

                stdout: StdioCollector {
                    onStreamFinished: cowsay.text = this.text
                }
            }
        }

        Timer {

            interval: 1700
            running: true
            repeat: true

            onTriggered: cowsayProc.running = true
        }
    }
}    
