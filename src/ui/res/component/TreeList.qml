import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../js/TreeItem.js" as TreeItem

Rectangle{

    id: panel

    property var rootItem: new TreeItem.TreeItem("", "", null)
    property var currentItem: null
    readonly property int selectionNone: TreeItem.SF_None
    readonly property int selectionCurrent: TreeItem.SF_Current
    readonly property int selectionSelected: TreeItem.SF_Selected
    property size iconSize: Qt.size(14, 14)
    property font font: Qt.font({family:"Monaco", pixelSize:14})
    property color backgroundFill: Qt.rgba(33/255, 37/255, 43/255)
    property color backgroundNormal: Qt.rgba(0.0, 0.0, 0.0, 0.0)
    property color foregroundNormal: Qt.rgba(151/255, 165/255, 180/255)
    property color backgroundHovered: Qt.rgba(44/255, 49/255, 58/255)
    property color foregroundHovered: Qt.rgba(1.0, 1.0, 1.0)
    property color backgroundCurrent: Qt.rgba(24/255, 26/255, 31/255)
    property color foregroundCurrent: Qt.rgba(1.0, 1.0, 1.0)
    property color selectionFlagColor: Qt.rgba(86/255, 138/255, 242/255)
    property color displayIconColor: Qt.rgba(1.0, 1.0, 1.0)

    readonly property string uriExpandIcon: "\ue892"
    readonly property string uriCollapseIcon: "\ue87d"

    implicitWidth: 200
    implicitHeight: parent.height
    color: backgroundFill

    //Model
    ListModel{
        id: listModel
    }

    //Delegate
    Component{
        id: delegateRoot
        Column{
            width: calculateWidth()
            Repeater{
                id: repeaterFirstLevelNodes
                model: subNodes
                delegate: delegateItems
            }

            function calculateWidth(){
                var w = 0;
                for(var i = 0; i < repeaterFirstLevelNodes.count; i++) {
                    var child = repeaterFirstLevelNodes.itemAt(i)
                    if(w < child.widthHint){
                        w = child.widthHint;
                    }
                }
                return w;
            }
        }
    }

    Component{
        id: delegateItems

        Column{

            property int widthHint: calculateWidth()

            function calculateWidth(){
                var w = Math.max(listView.width, itemRow.implicitWidth + 10);
                if(expanded){
                    for(var i = 0; i < repeaterSubNodes.count; i++) {
                        var child = repeaterSubNodes.itemAt(i)
                        if(w < child.widthHint){
                            w = child.widthHint;
                        }
                    }
                }
                return w;
            }

            Rectangle{
                id: itemRect
                width: listView.contentWidth
                height: itemRow.implicitHeight + 6

                color: (selectionFlag == TreeItem.SF_Current) ? backgroundCurrent : backgroundNormal

                function getItemByID(id){
                    var item = parentNode, vPath = [itemID];
                    while(item){
                        vPath.splice(0, 0, item.itemID);
                        item = item.parentNode;
                    }

                    var children = [rootItem];
                    for(var i = 0; i < vPath.length; i++){
                        var bFound = false;
                        for(var j = 0; j < children.length; j++){
                            var child = children[j];
                            if(vPath[i] === child.itemID){
                                if(i == vPath.length - 1){
                                    return child;
                                }else{
                                    children = child.subNodes;
                                    bFound = true;
                                    break;
                                }
                            }
                        }
                        if(!bFound){
                            return null;
                        }
                    }
                }

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        itemRect.color = backgroundHovered;
                        textTitle.color = foregroundHovered;
                    }
                    onExited: {
                        itemRect.color = Qt.binding(function(){return ((selectionFlag == TreeItem.SF_Current) ? backgroundCurrent : backgroundNormal);});
                        textTitle.color = Qt.binding(function(){return ((selectionFlag == TreeItem.SF_Current) ? foregroundCurrent : foregroundNormal);});
                    }
                    onClicked: {
                        var item = itemRect.getItemByID();
                        if(currentItem) currentItem.setSelectionFlag(TreeItem.SF_None);
                        if(item){
                            item.setSelectionFlag(TreeItem.SF_Current);
                        }
                    }
                }

                RowLayout{
                    id: itemRow
                    anchors.verticalCenter: itemRect.verticalCenter

                    Item{
                        width: getIndent();
                        height: parent.height

                        function getIndent(){
                            var item = itemRect.getItemByID();
                            return (item ? item.level() - 1 : 0) * 20 + 10;
                        }
                    }

                    MouseArea{
                        id: itemIndicator
                        width: imageIndicator.width + 4
                        height: imageIndicator.height + 4
                        Layout.alignment: Qt.AlignVCenter
                        propagateComposedEvents: (subNodes.count === 0)
                        onClicked: {
                            if(subNodes.count > 0){
                                var item = itemRect.getItemByID();
                                item.setExpanded(!item.isExpanded());
                            }else{
                                mouse.accepted = false;
                            }
                        }

                        TextIcon {
                            id: imageIndicator
                            visible: subNodes.count > 0
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            color: foregroundNormal
                            text: expanded ? uriCollapseIcon : uriExpandIcon
                        }
                    }

                    Item{
                        visible: (displayIcon !== "")
                        width: imageIcon.width + 4
                        height: imageIcon.height + 4
                        Layout.alignment: Qt.AlignVCenter

                        Image{
                            id: imageIcon
                            width: iconSize.width
                            height: iconSize.height
                            anchors.centerIn: parent
                            source: displayIcon
                        }
                    }

                    Text{
                        id: textTitle
                        Layout.alignment: Qt.AlignVCenter
                        color: foregroundNormal
                        font: panel.font
                        text: displayText
                    }
                }
            }

            Item{
                id: itemSubNodes
                visible: expanded
                width: colSubNodes.implicitWidth
                height: colSubNodes.implicitHeight
                Column{
                    id: colSubNodes
                    Repeater {
                        id: repeaterSubNodes
                        model: subNodes
                        delegate: delegateItems
                    }
                }
            }
        }
    }

    function createItem(text, icon, parent){
        return new TreeItem.TreeItem(text, icon, parent);
    }

    function topLevelItem(index){
        return rootItem.childItem(index);
    }

    function indexOfTopLevelItem(item){
        return rootItem.indexOfChildItem(item);
    }

    function addTopLevelItem(item){
        rootItem.appendChild(item);
    }

    function takeTopLevelItem(item){
        rootItem.removeChild(indexOfItem(item));
    }

    function getCurrentItem(){
        return currentItem;
    }

    ListView{
        id: listView
        anchors.fill: parent
        model: listModel
        delegate: delegateRoot

        contentWidth: contentItem.childrenRect.width;
        flickableDirection: Flickable.HorizontalAndVerticalFlick

        Component.onCompleted: {
            rootItem.setExpanded(true);
            listModel.append(rootItem);
        }
    }
}
