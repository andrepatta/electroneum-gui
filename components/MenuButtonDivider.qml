import QtQuick 2.9

import "." as ElectroneumComponents
import "effects/" as ElectroneumEffects

Rectangle {
    color: ElectroneumComponents.Style.appWindowBorderColor
    height: 1

    ElectroneumEffects.ColorTransition {
        targetObj: parent
        blackColor: ElectroneumComponents.Style._b_appWindowBorderColor
        whiteColor: ElectroneumComponents.Style._w_appWindowBorderColor
    }
}
