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
        color: Theme.colorBackground
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
            "text":"1 one",
            "istitle":true,
            "subnodes":[
                {"text":"1-1 two","istitle":true},
                {
                    "text":"1-2 two",
                    "istitle":true,
                    "subnodes":[
                        {"text":"1-2-1 three","isoption":true},
                        {"text":"1-2-2 three","isoption":true}
                    ]
                }
            ]
        },
        {
            "text":"2 one",
            "istitle":true,
            "subnodes":[
                {"text":"2-1 two","istitle":true},
                {
                    "text":"2-2 two",
                    "istitle":true,
                    "subnodes":[
                        {"text":"2-2-1 three","isoption":true},
                        {"text":"2-2-2 three","isoption":true}
                    ]
                }
            ]
        },
        {
            "text":"3 one",
            "istitle":true,
            "subnodes":[
                {"text":"3-1 two","istitle":true},
                {"text":"3-2 two","istitle":true}
            ]
        },
        {
            "text":"4 one",
            "istitle":true,
            "subnodes":[
                {"text":"4-1 two","istitle":true},
                {
                    "text":"4-2 two",
                    "istitle":true,
                    "subnodes":[
                        {"text":"4-2-1 three","isoption":true},
                        {"text":"4-2-2 three","isoption":true}
                    ]
                }
            ]
        },
        {
            "text":"5 one",
            "istitle":true,
            "subnodes":[
                {"text":"5-1 two","istitle":true},
                {
                    "text":"5-2 two",
                    "istitle":true,
                    "subnodes":[
                        {"text":"5-2-1 three","isoption":true},
                        {"text":"5-2-2 three","isoption":true}
                    ]
                }
            ]
        },
        {
            "text":"6 one",
            "istitle":true,
            "subnodes":[
                {"text":"6-1 two","istitle":true},
                {"text":"6-2 two","istitle":true}
            ]
        }
    ]')
    }

    function setTestDataB(){
        item_tree.model=JSON.parse('[
        {
            "text":"1 one",
            "istitle":true,
            "subnodes":[
                {
                    "text":"1-1 two",
                    "istitle":true,
                    "subnodes":[
                        {"text":"1-1-1 three","isoption":true},
                        {"text":"1-1-2 three","isoption":true}
                    ]
                },
                {
                    "text":"1-2 two",
                    "istitle":true,
                    "subnodes":[
                        {"text":"1-2-1 three","isoption":true},
                        {"text":"1-2-2 three","isoption":true}
                    ]
                }
            ]
        },
        {
            "text":"2 one",
            "istitle":true,
            "subnodes":[
                {"text":"2-1 two","istitle":true},
                {
                    "text":"2-2 two",
                    "istitle":true,
                    "subnodes":[
                        {"text":"2-2-1 three","isoption":true},
                        {"text":"2-2-2 three","isoption":true}
                    ]
                }
            ]
        },
        {"text":"3 one","istitle":true},
        {
            "text":"4 one",
            "istitle":true,
            "subnodes":[
                {"text":"4-1 two","istitle":true},
                {"text":"4-2 two","istitle":true}
            ]
        }
    ]')
    }

}
