import QtQuick 2.15
import QtQuick.Controls 2.15
import "../component"
import "../storage"
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15

Flickable{

    property int numberWidth : 30
    property alias text: editArea.text
    id:scroll
    anchors.fill: parent
    focus: true
    clip: true
    Rectangle{
        anchors.fill: listNumber
        color:Theme.colorBackground2
    }

    ScrollBar.vertical: ScrollBar {}

    ListView{
        id:listNumber
        height: editArea.height
        width: scroll.numberWidth
        model:editArea.lineCount
        delegate: Item{
            height: (editArea.contentHeight+2)/editArea.lineCount
            width: scroll.numberWidth
            Text{
                text:modelData + 1
                anchors{
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: 2
                }
                color: parseInt((editArea.cursorRectangle.y/editArea.contentHeight)*editArea.lineCount) === index ? Theme.colorPrimary : "#AAAAAA"
            }
        }
    }

    Rectangle{
        color:"#ffef0b"
        height: editArea.font.pixelSize+2
        width: scroll.width - listNumber.width
        x: listNumber.width
        y: editArea.cursorRectangle.y - 2
        visible: false
    }

    TextArea.flickable:TextArea{
        id:editArea
        wrapMode: Text.WrapAnywhere
        x:scroll.numberWidth
        focus: true
        selectByMouse: true
        topPadding: 2
        bottomPadding: 2
        selectionColor: Qt.alpha(Theme.colorPrimary,0.3)
        leftPadding: 2
        color:Theme.colorFontPrimary
        rightPadding: scroll.numberWidth + 2
    }
}
