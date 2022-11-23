import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../storage"


Rectangle {
    id: control

    property alias model: list_root.model

    anchors.fill: parent

    color:"#33FF0000"

    ListView {
        id: list_root
        anchors.fill: parent
        contentWidth: contentItem.childrenRect.width
        flickableDirection: Flickable.HorizontalAndVerticalFlick
        delegate: list_delegate
        clip: true
    }

    Component {
        id: list_delegate

        ColumnLayout{
            id:layout_item
            property int level: mapToItem(list_root,0,0).x/0.005

            RowLayout{
                id:item_text
                height: 30

                Item{
                    width: 15*level
                }

                //                Layout.leftMargin: 15*level
                Text {
                    text:  modelData.text
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            console.debug("list_root.width:"+list_root.width)
                            console.debug("list_root.contentWidth:"+list_root.contentWidth)
                            console.debug("item_text.width:"+item_text.width)
                            console.debug("layout_item.width:"+layout_item.width)
                            console.debug("level:"+layout_item.level)
                            showToast(list_root.contentWidth)
                        }
                    }
                }
            }


            ListView{
                id:list_child
                contentWidth: childrenRect.width
                height: childrenRect.height
                delegate: list_delegate
                interactive: false
                x:0.005
                model: modelData.subnodes
            }

        }

    }
}
