import QtQuick
import QtQuick.Controls


Rectangle {
    id: control

    property string currentItem //当前选中item

    property int spacing: 10    //项之间距离
    property int indent: 5      //子项缩进距离,注意实际还有icon的距离
    property string onSrc: "qrc:/img/on.png"
    property string offSrc: "qrc:/img/off.png"
    property string checkedSrc: "qrc:/img/check.png"
    property string uncheckSrc: "qrc:/img/uncheck.png"

    property var checkedArray: [] //当前已勾选的items
    property bool autoExpand: true

    //背景
    property alias model: list_view.model
    ListView {
        id: list_view
        anchors.fill: parent
        anchors.margins: 10
        //model: //model由外部设置，通过解析json
        property string viewFlag: ""
        delegate: list_delegate
        clip: true
        onModelChanged: {
            console.log('model change')
            checkedArray=[]; //model切换的时候把之前的选中列表清空
        }
    }
    Component {
        id: list_delegate
        Row{
            id: list_itemgroup
            spacing: 5
            property string parentFlag: ListView.view.viewFlag
            //以字符串来标记item
            //字符串内容为parent.itemFlag+model.index
            property string itemFlag: parentFlag+"-"+(model.index+1)

            //canvas 画项之间的连接线
            Canvas {
                id: list_canvas
                width: item_titleicon.width+10
                height: list_itemcol.height
                //开了反走样，线会模糊看起来加粗了
                antialiasing: false

                //项图标框--可以是ractangle或者image
                Image {
                    id: item_titleicon
                    visible: false
                    //如果是centerIn的话展开之后就跑到中间去了
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: list_canvas.width/2-width/2
                    anchors.topMargin: list_itemrow.height/2-width/2
                    //根据是否有子项/是否展开加载不同的图片/颜色
                    //color: item_repeater.count
                    //      ?item_sub.visible?"white":"gray"
                    //:"black"
                    //这里没子项或者子项未展开未off，展开了为on
                    source: item_repeater.count?item_sub.visible?offSrc:onSrc:offSrc

                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            if(item_repeater.count)
                                item_sub.visible=!item_sub.visible;
                        }
                    }
                }

                //项勾选框--可以是ractangle或者image
                Image {
                    id: item_optionicon
                    visible: false
                    width: 10
                    height: 10
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: list_canvas.width/2-width/2
                    anchors.topMargin: list_itemrow.height/2-width/2
                    property bool checked: isChecked(itemFlag)
                    //勾选框
                    //color: checked
                    //       ?"lightgreen"
                    //       :"red"
                    source: checked?checkedSrc:uncheckSrc
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            item_optionicon.checked=!item_optionicon.checked;
                            if(item_optionicon.checked){
                                check(itemFlag);
                            }else{
                                uncheck(itemFlag);
                            }
                            var str="checked ";
                            for(var i in checkedArray)
                                str+=String(checkedArray[i])+" ";
                            console.log(str)
                        }
                    }
                }

            }

            //项内容：包含一行item和子项的listview
            Column {
                id: list_itemcol

                //这一项的内容，这里只加了一个text
                Row {
                    id: list_itemrow
                    width: control.width
                    height: item_text.contentHeight+control.spacing
                    spacing: 5

                    Rectangle {
                        height: item_text.contentHeight+control.spacing
                        width: parent.width
                        anchors.verticalCenter: parent.verticalCenter
                        color: (control.currentItem===itemFlag)
                               ?Qt.rgba(101/255,255/255,255/255,38/255)
                               :"transparent"

                        Text {
                            id: item_text
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            text: modelData.text
                            font.pixelSize: 14
                            font.family: "Microsoft YaHei UI"
                            color: Qt.rgba(101/255,1,1,1)
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                control.currentItem=itemFlag;
                                console.log("selected",itemFlag)
                            }
                        }
                    }

                    Component.onCompleted: {
                        if(modelData.istitle){
                            item_titleicon.visible=true;
                        }else if(modelData.isoption){
                            item_optionicon.visible=true;
                        }
                    }
                }

                //放子项
                Column {
                    id: item_sub
                    //也可以像check一样用一个expand数组保存展开状态
                    visible: control.autoExpand
                    //上级左侧距离=小图标宽+x偏移
                    x: control.indent
                    Item {
                        width: 10
                        height: item_repeater.contentHeight
                        //需要加个item来撑开，如果用Repeator获取不到count
                        ListView {
                            id: item_repeater
                            anchors.fill: parent
                            delegate: list_delegate
                            model: modelData.subnodes
                            property string viewFlag: itemFlag
                        }
                    }
                }

            }
        }//end list_itemgroup
    }//end list_delegate

    //勾选时放入arr中
    function check(itemFlag){
        checkedArray.push(itemFlag);
    }

    //取消勾选时从arr移除
    function uncheck(itemFlag){
        var i = checkedArray.length;

        while (i--) {
            if (checkedArray[i] === itemFlag) {
                checkedArray.splice(i,1);
                break;
            }
        }
    }

    //判断是否check
    function isChecked(itemFlag){
        var i = checkedArray.length;

        while (i--) {
            if (checkedArray[i] === itemFlag) {
                return true;
            }
        }
        return false;
    }
}
