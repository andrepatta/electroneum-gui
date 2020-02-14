// Copyright (c) 2020, The Monero Project, 2020 The Electroneum Project
// Copyright (c) 2014-2019, The Monero Project
// 
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without modification, are
// permitted provided that the following conditions are met:
// 
// 1. Redistributions of source code must retain the above copyright notice, this list of
//    conditions and the following disclaimer.
// 
// 2. Redistributions in binary form must reproduce the above copyright notice, this list
//    of conditions and the following disclaimer in the documentation and/or other
//    materials provided with the distribution.
// 
// 3. Neither the name of the copyright holder nor the names of its contributors may be
//    used to endorse or promote products derived from this software without specific
//    prior written permission.
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
// THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
// THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import QtQuick 2.9
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0
import electroneumComponents.Wallet 1.0
import electroneumComponents.NetworkType 1.0
import electroneumComponents.Clipboard 1.0
import FontAwesome 1.0

import "components" as ElectroneumComponents
import "components/effects/" as ElectroneumEffects

Rectangle {
    id: panel

    property alias unlockedBalanceText: unlockedBalanceText.text
    property alias unlockedBalanceVisible: unlockedBalanceText.visible
    property alias unlockedBalanceLabelVisible: unlockedBalanceLabel.visible
    property alias balanceLabelText: balanceLabel.text
    property alias balanceText: balanceText.text
    property alias balanceTextFiat: balanceTextFiat.text
    property alias unlockedBalanceTextFiat: unlockedBalanceTextFiat.text
    property alias networkStatus : networkStatus
    property alias progressBar : progressBar
    property alias daemonProgressBar : daemonProgressBar
    property alias minutesToUnlockTxt: unlockedBalanceLabel.text
    property int titleBarHeight: 50
    property string copyValue: ""
    Clipboard { id: clipboard }

    signal historyClicked()
    signal transferClicked()
    signal receiveClicked()
    signal txkeyClicked()
    signal sharedringdbClicked()
    signal settingsClicked()
    signal addressBookClicked()
    signal miningClicked()
    signal signClicked()
    signal merchantClicked()
    signal accountClicked()

    function selectItem(pos) {
        menuColumn.previousButton.checked = false
        if(pos === "History") menuColumn.previousButton = historyButton
        else if(pos === "Transfer") menuColumn.previousButton = transferButton
        else if(pos === "Receive")  menuColumn.previousButton = receiveButton
        else if(pos === "Merchant")  menuColumn.previousButton = merchantButton
        else if(pos === "AddressBook") menuColumn.previousButton = addressBookButton
        else if(pos === "Mining") menuColumn.previousButton = miningButton
        else if(pos === "TxKey")  menuColumn.previousButton = txkeyButton
        else if(pos === "SharedRingDB")  menuColumn.previousButton = sharedringdbButton
        else if(pos === "Sign") menuColumn.previousButton = signButton
        else if(pos === "Settings") menuColumn.previousButton = settingsButton
        else if(pos === "Advanced") menuColumn.previousButton = advancedButton
        else if(pos === "Account") menuColumn.previousButton = accountButton
        menuColumn.previousButton.checked = true
    }

    width: (isMobile)? appWindow.width : 300
    color: "transparent"
    anchors.bottom: parent.bottom
    anchors.top: parent.top

    ElectroneumEffects.GradientBackground {
        anchors.fill: parent
        fallBackColor: ElectroneumComponents.Style.middlePanelBackgroundColor
        initialStartColor: ElectroneumComponents.Style.leftPanelBackgroundGradientStart
        initialStopColor: ElectroneumComponents.Style.leftPanelBackgroundGradientStop
        blackColorStart: ElectroneumComponents.Style._b_leftPanelBackgroundGradientStart
        blackColorStop: ElectroneumComponents.Style._b_leftPanelBackgroundGradientStop
        whiteColorStart: ElectroneumComponents.Style._w_leftPanelBackgroundGradientStart
        whiteColorStop: ElectroneumComponents.Style._w_leftPanelBackgroundGradientStop
        posStart: 0.6
        start: Qt.point(0, 0)
        end: Qt.point(height, width)
    }

    // card with electroneum logo
    Column {
        visible: true
        z: 2
        id: column1
        height: 210
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: (persistentSettings.customDecorations)? 50 : 0

        Item {
            Item {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.leftMargin: 20
                height: 490
                width: 260

                Image {
                    id: card
                    visible: !isOpenGL || ElectroneumComponents.Style.blackTheme
                    width: 260
                    height: 170
                    fillMode: Image.PreserveAspectFit
                    source: "qrc:///images/card-background.png"
                }

                DropShadow {
                    visible: isOpenGL && !ElectroneumComponents.Style.blackTheme
                    anchors.fill: card
                    horizontalOffset: 3
                    verticalOffset: 3
                    radius: 10.0
                    samples: 15
                    color: "#3B000000"
                    source: card
                    cached: true
                }

                ElectroneumComponents.TextPlain {
                    id: testnetLabel
                    visible: persistentSettings.nettype != NetworkType.MAINNET
                    text: (persistentSettings.nettype == NetworkType.TESTNET ? qsTr("Testnet") : qsTr("Stagenet")) + translationManager.emptyString
                    anchors.top: parent.top
                    anchors.topMargin: 8
                    anchors.left: parent.left
                    anchors.leftMargin: 192
                    font.bold: true
                    font.pixelSize: 12
                    color: "#f33434"
                    themeTransition: false
                }

                ElectroneumComponents.TextPlain {
                    id: viewOnlyLabel
                    visible: viewOnly
                    text: qsTr("View Only") + translationManager.emptyString
                    anchors.top: parent.top
                    anchors.topMargin: 8
                    anchors.right: testnetLabel.visible ? testnetLabel.left : parent.right
                    anchors.rightMargin: 8
                    font.pixelSize: 12
                    font.bold: true
                    color: "#ff9323"
                    themeTransition: false
                }

                Rectangle {
                    height: (logoutImage.height + 8)
                    width: (logoutImage.width + 8)
                    color: "transparent"
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    anchors.top: parent.top
                    anchors.topMargin: 25

                    Image {
                        id: logoutImage
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: 16
                        width: 13
                        source: "qrc:///images/logout.png"
                    }

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            middlePanel.addressBookView.clearFields();
                            middlePanel.transferView.clearFields();
                            middlePanel.receiveView.clearFields();
                            appWindow.showWizard();
                        }
                    }
                }
                ElectroneumComponents.Label {
                    fontSize: 20
                    text: "¥"
                    color: "white"
                    visible: persistentSettings.fiatPriceEnabled
                    anchors.right: parent.right
                    anchors.rightMargin: 45
                    anchors.top: parent.top
                    anchors.topMargin: 28
                    themeTransition: false

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            persistentSettings.fiatPriceToggle = !persistentSettings.fiatPriceToggle
                        }
                    }
                }
            }

            Item {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.leftMargin: 20
                height: 490
                width: 50

                ElectroneumComponents.TextPlain {
                    visible: !(persistentSettings.fiatPriceToggle && persistentSettings.fiatPriceEnabled)
                    id: balanceText
                    themeTransition: false
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.top: parent.top
                    anchors.topMargin: 76
                    font.family: "Arial"
                    color: "#FFFFFF"
                    text: "N/A"
                    // dynamically adjust text size
                    font.pixelSize: {
                        if (persistentSettings.hideBalance) {
                            return 20;
                        }
                        var digits = text.split('.')[0].length
                        var defaultSize = 22;
                        if(digits > 2) {
                            return defaultSize - 1.1*digits
                        }
                        return defaultSize;
                    }

                    MouseArea {
                        hoverEnabled: true
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onEntered: {
                            parent.color = ElectroneumComponents.Style.orange
                        }
                        onExited: {
                            parent.color = ElectroneumComponents.Style.white
                        }
                        onClicked: {
                                console.log("Copied to clipboard");
                                clipboard.setText(parent.text);
                                appWindow.showStatusMessage(qsTr("Copied to clipboard"),3)
                        }
                    }
                }

                ElectroneumComponents.TextPlain {
                    visible: !balanceText.visible
                    id: balanceTextFiat
                    themeTransition: false
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.top: parent.top
                    anchors.topMargin: 76
                    font.family: "Arial"
                    color: "#FFFFFF"
                    text: "N/A"
                    font.pixelSize: balanceText.font.pixelSize
                    MouseArea {
                        hoverEnabled: true
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onEntered: {
                            parent.color = ElectroneumComponents.Style.orange
                        }
                        onExited: {
                            parent.color = ElectroneumComponents.Style.white
                        }
                        onClicked: {
                                console.log("Copied to clipboard");
                                clipboard.setText(parent.text);
                                appWindow.showStatusMessage(qsTr("Copied to clipboard"),3)
                        }
                    }
                }

                ElectroneumComponents.TextPlain {
                    id: unlockedBalanceText
                    visible: !(persistentSettings.fiatPriceToggle && persistentSettings.fiatPriceEnabled)
                    themeTransition: false
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.top: parent.top
                    anchors.topMargin: 126
                    font.family: "Arial"
                    color: "#FFFFFF"
                    text: "N/A"
                    // dynamically adjust text size
                    font.pixelSize: {
                        if (persistentSettings.hideBalance) {
                            return 20;
                        }
                        var digits = text.split('.')[0].length
                        var defaultSize = 20;
                        if(digits > 3) {
                            return defaultSize - 0.6*digits
                        }
                        return defaultSize;
                    }

                    MouseArea {
                        hoverEnabled: true
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onEntered: {
                            parent.color = ElectroneumComponents.Style.orange
                        }
                        onExited: {
                            parent.color = ElectroneumComponents.Style.white
                        }
                        onClicked: {
                                console.log("Copied to clipboard");
                                clipboard.setText(parent.text);
                                appWindow.showStatusMessage(qsTr("Copied to clipboard"),3)
                        }
                    }
                }

                ElectroneumComponents.TextPlain {
                    id: unlockedBalanceTextFiat
                    themeTransition: false
                    visible: !unlockedBalanceText.visible
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.top: parent.top
                    anchors.topMargin: 126
                    font.family: "Arial"
                    color: "#FFFFFF"
                    text: "N/A"
                    font.pixelSize: unlockedBalanceText.font.pixelSize
                    MouseArea {
                        hoverEnabled: true
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onEntered: {
                            parent.color = ElectroneumComponents.Style.orange
                        }
                        onExited: {
                            parent.color = ElectroneumComponents.Style.white
                        }
                        onClicked: {
                                console.log("Copied to clipboard");
                                clipboard.setText(parent.text);
                                appWindow.showStatusMessage(qsTr("Copied to clipboard"),3)
                        }
                    }
                }

                ElectroneumComponents.Label {
                    id: unlockedBalanceLabel
                    visible: true
                    text: qsTr("Unlocked balance") + translationManager.emptyString
                    color: "white"
                    fontSize: 14
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.top: parent.top
                    anchors.topMargin: 110
                    themeTransition: false
                }

                ElectroneumComponents.Label {
                    visible: !isMobile
                    id: balanceLabel
                    text: qsTr("Balance") + translationManager.emptyString
                    color: "white"
                    fontSize: 14
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.top: parent.top
                    anchors.topMargin: 60
                    elide: Text.ElideRight
                    textWidth: 238
                    themeTransition: false
                }
                Item { //separator
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 1
                }
            }
        }
    }

    Rectangle {
        id: menuRect
        z: 2
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: (isMobile)? parent.top : column1.bottom
        color: "transparent"

        Flickable {
            id:flicker
            contentHeight: menuColumn.height
            anchors.top: parent.top
            anchors.bottom: networkStatus.top
            width: parent.width
            clip: true

        Column {
            id: menuColumn
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            clip: true
            property var previousButton: transferButton

            // top border
            ElectroneumComponents.MenuButtonDivider {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 16
            }

            // ------------- Account tab ---------------
            ElectroneumComponents.MenuButton {
                id: accountButton
                anchors.left: parent.left
                anchors.right: parent.right
                text: qsTr("Account") + translationManager.emptyString
                symbol: qsTr("T") + translationManager.emptyString
                dotColor: "#44AAFF"
                onClicked: {
                    parent.previousButton.checked = false
                    parent.previousButton = accountButton
                    panel.accountClicked()
                }
            }

            ElectroneumComponents.MenuButtonDivider {
                visible: accountButton.present
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 16
            }

            // ------------- Transfer tab ---------------
            ElectroneumComponents.MenuButton {
                id: transferButton
                anchors.left: parent.left
                anchors.right: parent.right
                text: qsTr("Send") + translationManager.emptyString
                symbol: qsTr("S") + translationManager.emptyString
                dotColor: "#FF6C3C"
                onClicked: {
                    parent.previousButton.checked = false
                    parent.previousButton = transferButton
                    panel.transferClicked()
                }
            }

            ElectroneumComponents.MenuButtonDivider {
                visible: transferButton.present
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 16
            }

            // ------------- AddressBook tab ---------------

            ElectroneumComponents.MenuButton {
                id: addressBookButton
                anchors.left: parent.left
                anchors.right: parent.right
                text: qsTr("Address book") + translationManager.emptyString
                symbol: qsTr("B") + translationManager.emptyString
                dotColor: "#FF4F41"
                under: transferButton
                onClicked: {
                    parent.previousButton.checked = false
                    parent.previousButton = addressBookButton
                    panel.addressBookClicked()
                }
            }

            ElectroneumComponents.MenuButtonDivider {
                visible: addressBookButton.present
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 16
            }

            // ------------- Receive tab ---------------
            ElectroneumComponents.MenuButton {
                id: receiveButton
                anchors.left: parent.left
                anchors.right: parent.right
                text: qsTr("Receive") + translationManager.emptyString
                symbol: qsTr("R") + translationManager.emptyString
                dotColor: "#AAFFBB"
                onClicked: {
                    parent.previousButton.checked = false
                    parent.previousButton = receiveButton
                    panel.receiveClicked()
                }
            }

            ElectroneumComponents.MenuButtonDivider {
                visible: receiveButton.present
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 16
            }

            // ------------- Merchant tab ---------------
            /*
            ElectroneumComponents.MenuButton {
                id: merchantButton
                visible: appWindow.walletMode >= 2
                anchors.left: parent.left
                anchors.right: parent.right
                text: qsTr("Merchant") + translationManager.emptyString
                symbol: qsTr("U") + translationManager.emptyString
                dotColor: "#FF4F41"
                under: receiveButton
                onClicked: {
                    parent.previousButton.checked = false
                    parent.previousButton = merchantButton
                    panel.merchantClicked()
                }
            }

            ElectroneumComponents.MenuButtonDivider {
                visible: merchantButton.present && appWindow.walletMode >= 2
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 16
            }
            */
            // ------------- History tab ---------------

            ElectroneumComponents.MenuButton {
                id: historyButton
                anchors.left: parent.left
                anchors.right: parent.right
                text: qsTr("Transactions") + translationManager.emptyString
                symbol: qsTr("H") + translationManager.emptyString
                dotColor: "#6B0072"
                onClicked: {
                    parent.previousButton.checked = false
                    parent.previousButton = historyButton
                    panel.historyClicked()
                }
            }

            ElectroneumComponents.MenuButtonDivider {
                visible: historyButton.present
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 16
            }

            // ------------- Advanced tab ---------------
            /*
            ElectroneumComponents.MenuButton {
                id: advancedButton
                visible: appWindow.walletMode >= 2
                anchors.left: parent.left
                anchors.right: parent.right
                text: qsTr("Advanced") + translationManager.emptyString
                symbol: qsTr("D") + translationManager.emptyString
                dotColor: "#FFD781"
                onClicked: {
                    parent.previousButton.checked = false
                    parent.previousButton = advancedButton
                }
            }

            ElectroneumComponents.MenuButtonDivider {
                visible: advancedButton.present && appWindow.walletMode >= 2
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 16
            }
            */

            // ------------- Mining tab ---------------
            /*
            ElectroneumComponents.MenuButton {
                id: miningButton
                visible: !isAndroid && !isIOS && appWindow.walletMode >= 2
                anchors.left: parent.left
                anchors.right: parent.right
                text: qsTr("Mining") + translationManager.emptyString
                symbol: qsTr("M") + translationManager.emptyString
                dotColor: "#FFD781"
                under: advancedButton
                onClicked: {
                    parent.previousButton.checked = false
                    parent.previousButton = miningButton
                    panel.miningClicked()
                }
            }

            ElectroneumComponents.MenuButtonDivider {
                visible: miningButton.present && appWindow.walletMode >= 2
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 16
            }

            */

            // ------------- TxKey tab ---------------
            /*
            ElectroneumComponents.MenuButton {
                id: txkeyButton
                visible: appWindow.walletMode >= 2
                anchors.left: parent.left
                anchors.right: parent.right
                text: qsTr("Prove/check") + translationManager.emptyString
                symbol: qsTr("K") + translationManager.emptyString
                dotColor: "#FFD781"
                under: advancedButton
                onClicked: {
                    parent.previousButton.checked = false
                    parent.previousButton = txkeyButton
                    panel.txkeyClicked()
                }
            }

            ElectroneumComponents.MenuButtonDivider {
                visible: txkeyButton.present && appWindow.walletMode >= 2
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 16
            }
            */

            // ------------- Shared RingDB tab ---------------
            /*
            ElectroneumComponents.MenuButton {
                id: sharedringdbButton
                visible: appWindow.walletMode >= 2
                anchors.left: parent.left
                anchors.right: parent.right
                text: qsTr("Shared RingDB") + translationManager.emptyString
                symbol: qsTr("G") + translationManager.emptyString
                dotColor: "#FFD781"
                under: advancedButton
                onClicked: {
                    parent.previousButton.checked = false
                    parent.previousButton = sharedringdbButton
                    panel.sharedringdbClicked()
                }
            }

            ElectroneumComponents.MenuButtonDivider {
                visible: sharedringdbButton.present && appWindow.walletMode >= 2
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 16
            }
            */

            // ------------- Sign/verify tab ---------------
            /*
            ElectroneumComponents.MenuButton {
                id: signButton
                visible: appWindow.walletMode >= 2
                anchors.left: parent.left
                anchors.right: parent.right
                text: qsTr("Sign/verify") + translationManager.emptyString
                symbol: qsTr("I") + translationManager.emptyString
                dotColor: "#FFD781"
                under: advancedButton
                onClicked: {
                    parent.previousButton.checked = false
                    parent.previousButton = signButton
                    panel.signClicked()
                }
            }

            ElectroneumComponents.MenuButtonDivider {
                visible: signButton.present && appWindow.walletMode >= 2
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 16
            }
            */

            // ------------- Settings tab ---------------
            ElectroneumComponents.MenuButton {
                id: settingsButton
                anchors.left: parent.left
                anchors.right: parent.right
                text: qsTr("Settings") + translationManager.emptyString
                symbol: qsTr("E") + translationManager.emptyString
                dotColor: "#36B25C"
                onClicked: {
                    parent.previousButton.checked = false
                    parent.previousButton = settingsButton
                    panel.settingsClicked()
                }
            }

            ElectroneumComponents.MenuButtonDivider {
                visible: settingsButton.present
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 16
            }

        } // Column

        } // Flickable

        Rectangle {
            id: separator
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottom: networkStatus.top;
            height: 10
            color: "transparent"
        }

        ElectroneumComponents.NetworkStatusItem {
            id: networkStatus
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 5
            anchors.rightMargin: 0
            anchors.bottom: (progressBar.visible)? progressBar.top : parent.bottom;
            connected: Wallet.ConnectionStatus_Disconnected
            height: 48
        }

        ElectroneumComponents.ProgressBar {
            id: progressBar
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: daemonProgressBar.top
            height: 48
            syncType: qsTr("Wallet") + translationManager.emptyString
            visible: networkStatus.connected
        }

        ElectroneumComponents.ProgressBar {
            id: daemonProgressBar
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            syncType: qsTr("Daemon") + translationManager.emptyString
            visible: networkStatus.connected
            height: 62
        }
    }
}
