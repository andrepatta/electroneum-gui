import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1

import electroneumComponents.Wallet 1.0
import "../components" as ElectroneumComponents

// BasicPanel header
Rectangle {
    id: header
    anchors.leftMargin: 1
    anchors.rightMargin: 1
    Layout.fillWidth: true
    Layout.preferredHeight: 64
    color: "#FFFFFF"

    Image {
        id: logo
        visible: appWindow.width > 460
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -5
        anchors.left: parent.left
        anchors.leftMargin: 50
        source: "qrc:///images/electroneumLogo2.png"
    }

    Image {
        id: icon
        visible: !logo.visible
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 40
        source: "qrc:///images/electroneumIcon.png"
    }

    Grid {
        anchors.verticalCenter: parent.verticalCenter
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 10
        width: 256
        columns: 3

        ElectroneumComponents.TextPlain {
            id: balanceLabel
            width: 116
            height: 20
            font.family: "Arial"
            font.pixelSize: 12
            font.letterSpacing: -1
            elide: Text.ElideRight
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignBottom
            color: "#535353"
            text: leftPanel.balanceLabelText + ":"
        }

        ElectroneumComponents.TextPlain {
            id: balanceText
            width: 110
            height: 20
            font.family: "Arial"
            font.pixelSize: 18
            font.letterSpacing: -1
            elide: Text.ElideRight
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignBottom
            color: "#000000"
            text: leftPanel.balanceText
        }

        Item {
            height: 20
            width: 20

            Image {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                source: "qrc:///images/lockIcon.png"
            }
        }

        ElectroneumComponents.TextPlain {
            width: 116
            height: 20
            font.family: "Arial"
            font.pixelSize: 12
            font.letterSpacing: -1
            elide: Text.ElideRight
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignBottom
            color: "#535353"
            text: qsTr("Available Balance:")
        }

        ElectroneumComponents.TextPlain {
            id: availableBalanceText
            width: 110
            height: 20
            font.family: "Arial"
            font.pixelSize: 14
            font.letterSpacing: -1
            elide: Text.ElideRight
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignBottom
            color: "#000000"
            text: leftPanel.unlockedBalanceText
        }
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 1
        color: "#DBDBDB"
    }
}
