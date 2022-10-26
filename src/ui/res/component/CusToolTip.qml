import QtQuick
import QtQuick.Controls

import Qt5Compat.GraphicalEffects
import "../storage"

ToolTip {
    id:tool_tip

    contentItem: Text {
        text: tool_tip.text
        font: tool_tip.font
        wrapMode: Text.WrapAnywhere
        color: "#000000"
    }

    background: Item {
        Rectangle{
            id:itemLayout
            anchors.fill: parent
            radius: 3
            color: "#F7F7F7"
        }

        DropShadow{
            anchors.fill: itemLayout
            radius: 3
            samples: 5
            color: AppStorage.isDark ? "#80FFFFFF" : "#80000000"
            source: itemLayout
        }
    }
}
