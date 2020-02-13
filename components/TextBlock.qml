import QtQuick 2.9

import "../components" as ElectroneumComponents

TextEdit {
    color: ElectroneumComponents.Style.defaultFontColor
    font.family: ElectroneumComponents.Style.fontRegular.name
    selectionColor: ElectroneumComponents.Style.textSelectionColor
    wrapMode: Text.Wrap
    readOnly: true
    selectByMouse: true
    // Workaround for https://bugreports.qt.io/browse/QTBUG-50587
    onFocusChanged: {
        if(focus === false)
            deselect()
    }
}
