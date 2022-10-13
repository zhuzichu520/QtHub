import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../storage"

Item {

    property alias wrapMode: input_field.wrapMode
    property alias text: input_field.text
    property alias icon: image_icon.source
    property alias placeholderText: input_field.placeholderText
    property alias readOnly: input_field.readOnly
    property alias editFocus: input_field.focus

    width: childrenRect.width
    height: childrenRect.height

    TextField{
        id:input_field
        width: parent.width
        height: parent.height
        selectionColor: "#9BCAEF"
        selectByMouse: true
        selectedTextColor: color
        font.pixelSize: 14
        color: "#191E24"
        leftPadding: 42
        placeholderText: "请输入PIN码"
        placeholderTextColor: "#40191E24"
        background: Rectangle{
            radius: 4
            color: input_field.focus ?  "#FFFFFFFF" : "#0D4F7DA4"
            border{
                width: input_field.focus ? 1 : 0
                color: input_field.focus ? Theme.colorPrimary : "#BBBBBB"
            }
        }
    }

    Image{
        id:image_icon
        width: 36
        height: 36
        anchors{
            verticalCenter: parent.verticalCenter
            left:parent.left
            leftMargin: 4
        }
    }

}
