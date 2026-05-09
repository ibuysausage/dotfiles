import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland
import Quickshell.Hyprland

Scope {
    Variants {
        model: Quickshell.screens

        delegate: Component {

            PanelWindow {
                required property var modelData
                screen: modelData
                color: "#1a1b26"

                anchors {
                    top: true
                    left: true
                    bottom: true
                }
    
                implicitWidth: 25

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 12

                    Repeater {
                        model: 9

                        Text {
                            property var ws: Hyprland.workspaces.values.find (w => w.id === index + 1)
                            property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                            text: index + 1
                            color: isActive ? "#05EB86" : (ws ? "#70CCCC" : "#283030")
                            font {
                                family: "CaskaydiaCove Nerd Font"
                                pixelSize: 16
                                bold: true
                            }
                        }
                    }

                    Item { Layout.fillHeight: true }
                }
            }
        }
    }
}
