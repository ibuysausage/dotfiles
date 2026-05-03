import QuickShell
import QtQuick
import Quickshell.Io

PanelWindow {

    color: "transparent"

    implicitWidth: 600
    implicitHeight: 800

    Rectangle {
        
        color: "#304039"
        anchors.fill: parent

        radius: 20


        Text {
            id: cowsay

            anchors.centerIn: parent
            font.pixelSize: 20
            font.color: "yellow"

            Process {
                command: ["cowsay", "-r", "its a mee"]

                running: true

                stdout: StdioCollector {
                    onStreamFinished: cowsay.text = this.text
                }
            }
        }
    }
}    
