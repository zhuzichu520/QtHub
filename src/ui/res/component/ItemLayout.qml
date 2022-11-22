import QtQuick
import "../storage"

Rectangle {

    signal clicked

    signal rightClicked

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
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked:{
            if(mouse.button === Qt.LeftButton){
                root.clicked()
            }else{
                root.rightClicked()
            }
        }
    }

}
