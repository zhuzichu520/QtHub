import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects
import "../global/global.js" as Global

Window {

    id:dialog
    flags: Qt.Tool | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    property int dialogWidth: 300
    property int dialogHeight: 300
    property var target
    width: dialogWidth+10
    height: dialogHeight+10
    color:"#00000000"
    property int radius: 5

    default property alias  children : content.children

    onActiveFocusItemChanged: {
        if(dialog.activeFocusItem == null){
            hide()
        }
    }

    onActiveChanged: {
        if(!dialog.active){
            hide()
        }
    }

    Rectangle{
        id:shadow
        width: dialogWidth
        height: dialogHeight
        anchors.centerIn: parent
        radius: dialog.radius
    }

    Rectangle{
        id:content
        width: dialogWidth
        height: dialogHeight
        anchors.centerIn: parent
        layer.enabled: true
        layer.effect:OpacityMask {
            maskSource: Rectangle {
                width: dialogWidth
                height: dialogHeight
                radius: dialog.radius
            }
        }
    }


    function showDialog(){
        if(!Global.noValue(target)){
            var pos = target.mapToGlobal(Qt.point(0,0))
            var w = target.width
            var h = target.height
            dialog.x = Math.min(Math.max(pos.x - (dialog.width - w)/2,0),Screen.desktopAvailableWidth-width)
            dialog.y = Math.max(pos.y - dialog.height,0)
        }
        show()
        requestActivate()
    }

    function hideDialog(){
        hide()
    }

}
