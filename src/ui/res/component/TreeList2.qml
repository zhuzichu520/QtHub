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
        var node, curTree = [...tree]
        while ((node = curTree.shift())) {
            arr.push(node)
            node.children && curTree.unshift(...node.children)
        }
        return arr
    }

    ListView {
        id: list_root
        anchors.fill: parent
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
                                for (var i = 0; i < arr.length; ++i) {
                                    var obj = arr[i]
                                    if(obj.id === modelData.id){
                                        obj.expanded = !obj.expanded
                                        console.debug(JSON.stringify(control.model))
                                        break
                                    }
                                }
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
                                showToast(list_root.contentWidth)
                            }
                        }
                    }
                }
            }


            Item{
                id: itemSubNodes
                visible: {
                    if(!isChildData){
                        return false
                    }
                    return modelData.expanded??false
                }
                width: colSubNodes.implicitWidth
                height: colSubNodes.implicitHeight
                x:0.001
                Column{
                    id: colSubNodes
                    Repeater{
                        model: modelData.children
                        delegate: list_delegate
                    }
                }
            }
        }
    }
}
