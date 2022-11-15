import QtQuick
import "../storage"

Rectangle {

    signal clicked

    id:root
    color:  {
        if(item_mouse.containsPress){
            return Theme.colorBackground2
        }
        if(item_mouse.containsMouse){
            return Theme.colorBackground1
        }
        return Theme.colorBackground
    }

    MouseArea{
        id:item_mouse
        hoverEnabled: true
        anchors.fill: parent
        onClicked:root.clicked()
    }

}
