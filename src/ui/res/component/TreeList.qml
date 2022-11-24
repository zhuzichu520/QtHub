import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../storage"

Rectangle {
    id: control

    property var treeData

    color:Theme.colorBackground

    property var arr: []


    onTreeDataChanged: {
        list_model.clear()
        var root = {name:"根目录",size:"0",type:"tree",url:"",expanded:true,icon:"qrc:/image/ic_folder.png"};
        sortTree(treeData)
        root.subNodes = treeData
        list_model.append(root)
    }


    function sortTree(tree){
        tree.sort(function(s,t){
            if(s.type==="tree" && t.type !== "tree"){
                return -1
            }
            if(s.type!=="tree" && t.type === "tree"){
                return 1
            }
            return s.name??"".localeCompare(t.name??"")
        })
        for(var i = 0; i < tree.length; ++i){
            if(tree[i].subNodes && tree[i].length!==0){
                sortTree(tree[i].subNodes)
            }
        }
    }


    ListModel{
        id:list_model
    }

    Component{
        id: delegate_root
        Column{
            width: calculateWidth()
            Repeater{
                id: repeater_first_level
                model: subNodes
                delegate: delegate_items
            }

            function calculateWidth(){
                var w = 0;
                for(var i = 0; i < repeater_first_level.count; i++) {
                    var child = repeater_first_level.itemAt(i)
                    if(w < child.widthHint){
                        w = child.widthHint;
                    }
                }
                return w;
            }
        }
    }


    Component {
        id: delegate_items

        Column{
            id:item_layout


            property int widthHint: calculateWidth()

            function calculateWidth(){
                var w = Math.max(list_root.width, item_layout_row.implicitWidth + 10);
                if(expanded){
                    for(var i = 0; i < repeater_subNodes.count; i++) {
                        var child = repeater_subNodes.itemAt(i)
                        if(w < child.widthHint){
                            w = child.widthHint;
                        }
                    }
                }
                return w;
            }


            property real level: mapToItem(list_root,0,0).x/0.001
            property bool isChildData : (model.subNodes !== undefined) && (model.subNodes.count !== 0)
            property var subNodes: model.subNodes??[]
            property var icon: model.icon??""
            property var name: model.name??""
            property var expanded: model.expanded??false
            property var size: model.size??""

            Item{
                id:item_layout_rect
                width: list_root.contentWidth
                height: item_layout_row.implicitHeight

                RowLayout{
                    id:item_layout_row
                    anchors.verticalCenter: item_layout_rect.verticalCenter

                    Item{
                        width: 15*level
                        Layout.alignment: Qt.AlignVCenter
                    }

                    TextIcon {
                        id:item_expanded
                        font.pixelSize: 16
                        opacity: isChildData
                        text: item_layout.expanded ? "\ue892" : "\ue87d"
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                item_layout.expanded = !item_layout.expanded
                            }
                        }
                        color:Theme.colorFontPrimary
                    }

                    Image {
                        id:item_icon
                        Layout.preferredHeight: 14
                        Layout.preferredWidth: 14
                        Layout.alignment: Qt.AlignVCenter
                        source: item_layout.icon
                    }

                    Text {
                        text:  item_layout.name
                        font.pixelSize: 14
                        color:Theme.colorFontPrimary
                        Layout.alignment: Qt.AlignVCenter
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {

                            }
                        }
                    }
                }
            }


            Item{
                id: item_sub
                visible: {
                    if(!isChildData){
                        return false
                    }
                    return item_layout.expanded??false
                }
                width: item_sub_layout.implicitWidth
                height: item_sub_layout.implicitHeight
                x:0.001
                Column{
                    id: item_sub_layout
                    Repeater{
                        id:repeater_subNodes
                        model: item_layout.subNodes
                        delegate: delegate_items
                    }
                }
            }
        }
    }

    ListView {
        id: list_root
        anchors.fill: parent
        delegate: delegate_root
        model:list_model

        contentWidth: contentItem.childrenRect.width;
        flickableDirection: Flickable.HorizontalAndVerticalFlick
        clip: true

    }

}
