import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../storage"


Rectangle {
    id: control

    property alias model: list_root.model

    anchors.fill: parent

    color:"#33FF0000"

    property var arr: []

    onModelChanged: {
       arr = treeToArr(model)
    }

    function treeToArr(tree) {
      var arr = []
      let node, curTree = [...tree]
      while ((node = curTree.shift())) {
        arr.push(node)
        node.children && curTree.unshift(...node.children)
      }
      return arr
    }

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
            spacing: 0
            property real level: mapToItem(list_root,0,0).x/0.001
            property bool isChildData : (modelData.children !== undefined) && (modelData.children.length !== 0)

            Rectangle{
                height: childrenRect.height
                width: childrenRect.width
                RowLayout{
                    id:item_text
                    height: 30
                    spacing: 0

                    Item{
                        width: 15*level
                        Layout.alignment: Qt.AlignVCenter
                    }

                    TextIcon {
                        id:item_expanded
                        font.pixelSize: 14
                        opacity: isChildData
                        text: modelData.expanded ? "\ue892" : "\ue87d"
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
//                                modelData.expanded = !modelData.expanded
                                for (var i = 0; i < arr.length; ++i) {
                                    var obj = arr[i]
                                    if(obj.id === modelData.id){
                                        console.debug("---------------------->执行了")
                                        obj.expanded = !obj.expanded
                                        break
                                    }
                                }
//                                list_root.model = list_root.model
                            }
                        }
                    }

                    Image {
                        id:item_icon
                        Layout.preferredHeight: 14
                        Layout.preferredWidth: 14
                        Layout.alignment: Qt.AlignVCenter
                        source: modelData.icon??""
                    }

                    Text {
                        text:  modelData.name
                        Layout.alignment: Qt.AlignVCenter
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                console.debug("list_root.width:"+list_root.width)
                                console.debug("list_root.contentWidth:"+list_root.contentWidth)
                                console.debug("item_text.width:"+item_text.width)
                                console.debug("layout_item.width:"+layout_item.width)
                                console.debug("level:"+layout_item.level)
                                console.debug("modelData.expanded:"+modelData.expanded)
                                showToast(list_root.contentWidth)
                            }
                        }
                    }
                }

            }

            ListView{
                id:list_child
                contentWidth: childrenRect.width
                height: childrenRect.height
                delegate: list_delegate
                visible: {
                    if(!isChildData){
                        return false
                    }
                    return modelData.expanded??false
                }
                interactive: false
                x:0.001
                model: modelData.children
            }

        }

    }
}
