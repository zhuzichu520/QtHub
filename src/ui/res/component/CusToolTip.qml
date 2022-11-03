import QtQuick
import QtQuick.Controls
import "../storage"

ToolTip {
    id:tool_tip

    contentItem: Text {
        text: tool_tip.text
        font: tool_tip.font
        wrapMode: Text.WrapAnywhere
        color: Theme.colorFontPrimary
    }

    background: Item {

        Shadow{
            anchors.fill: parent
            shadowColor: Theme.colorPrimary
        }

    }
}
