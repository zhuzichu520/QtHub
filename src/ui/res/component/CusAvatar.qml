import QtQuick
import Qt5Compat.GraphicalEffects
import "../view"
import "../storage"

Item {

    //一个圆形图片
    id:root
    property var source
    property int avatarRadius: width / 2
    width: 54
    height: 54
    property bool isMask : true

    Image {
        id: avatar_image
        anchors.fill: parent
        anchors.centerIn: parent
        smooth: true
        source: {
            if(root.source === undefined || root.source===""){
                return "qrc:/image/ic_login_logo.png"
            }
            return root.source
        }
        fillMode: Image.PreserveAspectFit
        visible: false
        asynchronous: true
        cache: true
        onStatusChanged: {
            if (status===Image.Error) {
                source="qrc:/image/ic_login_logo.png"
            }
        }
    }

    Rectangle {
        id: mask
        width: parent.width
        height: parent.height
        radius: avatarRadius
        visible: isMask
        color: "#FFF7F8F9"
    }


    OpacityMask {
        anchors.fill: parent
        source: avatar_image
        maskSource: mask
        visible: true
    }

}
