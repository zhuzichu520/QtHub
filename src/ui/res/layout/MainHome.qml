import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls.Material as M
import Controller
import "../js/Router.js" as R
import "../storage"
import "../component"
import "../view"


Item {

    Text {
        anchors.centerIn: parent
        color:Theme.colorFontPrimary
        font.pixelSize: 20
        visible: false
        text: qsTr("正在建设中...")
    }

    TreeList2{
        id: item_tree
        anchors.fill: parent
//        color: Theme.colorBackground
        //model: []

        //set model data
        Component.onCompleted: {
            console.log(1)
            setTestDataA();
            console.log(2)
        }
    }

    function setTestDataA(){
        item_tree.model=JSON.parse('[
    {
        "name":"文件夹",
        "expanded":true,
        "children":[
            {
                "name":"文件1",
                "children":[

                ]
            },
            {
                "name":"文件2",
                "children":[

                ]
            },
            {
                "name":"文件3",

                "children":[

                ]
            }
        ]
    }
]')
    }


}
