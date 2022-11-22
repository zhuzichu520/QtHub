import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../storage"

Item {

    property alias wrapMode: inputField.wrapMode
    property alias lableText: inputLable.text
    property alias text: inputField.text

    width: childrenRect.width
    height: childrenRect.height

    Text{
        id:inputLable
        anchors{
            top:parent.top
            left: parent.left
        }
        color:"#999999"
    }

    TextField{
        id:inputField
        anchors{
            top: inputLable.bottom
            left: inputLable.left
            topMargin: 5
        }
        width: parent.width
        selectionColor: Qt.alpha(Theme.colorPrimary,0.3)
        selectByMouse: true
        verticalAlignment: TextInput.AlignVCenter
        height: 32
        background: Rectangle{
            radius: 3
            border{
                width: 1
                color: inputField.focus ? Theme.colorPrimary : "#BBBBBB"
            }
        }
    }

    function inputFocus(isFocus){
        focus = isFocus
        inputField.focus = isFocus
    }

}
