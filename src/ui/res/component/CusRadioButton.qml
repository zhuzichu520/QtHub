import QtQuick
import QtQuick.Controls
import "../storage"

RadioButton {
    id: control
    text: qsTr("RadioButton")
    checkable:false
    indicator: Rectangle {
        implicitWidth: 20
        implicitHeight: 20
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        radius: 10
        border.color: control.checked ? Theme.colorPrimary :  Theme.colorFontPrimary

        Rectangle {
            width: 10
            height: 10
            x: 5
            y: 5
            radius: 5
            color: control.checked ? Theme.colorPrimary :  Theme.colorFontPrimary
            visible: control.checked
        }
    }
    contentItem: Text {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: control.checked ? Theme.colorPrimary :  Theme.colorFontPrimary
        verticalAlignment: Text.AlignVCenter
        leftPadding: control.indicator.width + control.spacing
    }
}
