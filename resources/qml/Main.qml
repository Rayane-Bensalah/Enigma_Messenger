import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: root

    height: 600
    title: "Enigma Messenger"
    visible: true
    width: 800

    // Main layout
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10

        // Header
        Text {
            Layout.alignment: Qt.AlignHCenter
            font.bold: true
            font.pixelSize: 24
            text: "Enigma Messenger"
        }

        // Main content area
        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            border.color: "#cccccc"
            color: "#f0f0f0"

            Text {
                anchors.centerIn: parent
                font.pixelSize: 18
                text: "Welcome to Enigma Messenger"
            }
        }
    }
}