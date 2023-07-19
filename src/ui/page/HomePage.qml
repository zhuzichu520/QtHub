import QtQuick
import QtQuick.Layouts
import FluentUI

FluScrollablePage {
    title: "Home"
    animDisabled: true
    launchMode: FluPageType.SingleTask

    FluText{
        text:"My Work"
        Layout.topMargin: 20
        font: FluTextStyle.BodyStrong
    }

    ListModel{
        id:model_work
        ListElement{
            title:"Issues"
            icon:"qrc:/QtHub/ui/res/image/Issues.png"
        }
        ListElement{
            title:"Pull Requests"
            icon:"qrc:/QtHub/ui/res/image/PullRequests.png"
        }
        ListElement{
            title:"Discussions"
            icon:"qrc:/QtHub/ui/res/image/Discussions.png"
        }
        ListElement{
            title:"Repositories"
            icon:"qrc:/QtHub/ui/res/image/Repositories.png"
        }
        ListElement{
            title:"Organizations"
            icon:"qrc:/QtHub/ui/res/image/Organizations.png"
        }
        ListElement{
            title:"Starred"
            icon:"qrc:/QtHub/ui/res/image/Starred.png"
        }
    }

    Flow {
        Layout.topMargin: 10
        id:flow_work_list
        Layout.fillWidth: parent
        spacing: 10
        Repeater{
            model: model_work
            delegate: FluControl{
                width: 130
                height: 80
                onClicked: {
                }
                ColumnLayout{
                    anchors.centerIn: parent
                    spacing: 10
                    Image {
                        Layout.preferredWidth: 40
                        Layout.preferredHeight: 40
                        Layout.alignment: Qt.AlignHCenter
                        source: model.icon
                    }
                    FluText{
                        Layout.alignment: Qt.AlignHCenter
                        text: model.title
                        color: {
                            if(FluTheme.dark){
                                if(pressed){
                                    return Qt.rgba(162/255,162/255,162/255,1)
                                }
                                return Qt.rgba(1,1,1,1)
                            }else{
                                if(pressed){
                                    return Qt.rgba(96/255,96/255,96/255,1)
                                }
                                return Qt.rgba(0,0,0,1)
                            }
                        }
                    }
                }

                background: Rectangle{
                    radius: 4
                    color:{
                        if(FluTheme.dark){
                            if(hovered){
                                return Qt.rgba(1,1,1,0.09)
                            }
                            return Qt.rgba(1,1,1,0.06)
                        }else{
                            if(hovered){
                                return Qt.rgba(0,0,0,0.09)
                            }
                            return Qt.rgba(0,0,0,0.06)
                        }
                    }
                }
            }
        }
    }




}
