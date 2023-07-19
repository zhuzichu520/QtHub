import QtQuick
import QtQuick.Layouts
import FluentUI
import QtHub

FluScrollablePage {

    id:root
    title: "Profile"
    launchMode: FluPageType.SingleInstance
    onErrorClicked: {
        loadProfileInfo()
    }

    function loadProfileInfo(){
        statusMode = FluStatusViewType.Loading
        controller.loadProfileInfo()
    }

    Component.onCompleted: {
        loadProfileInfo()
    }

    ProfileController{
        id:controller
        onLoadProfileSuccessEvent:{
            statusMode = FluStatusViewType.Success
        }
        onLoadProfileErrorEvent:(message)=>{
            errorText = message
            statusMode = FluStatusViewType.Error
        }
    }

    Item{
        Layout.fillWidth: true
        Layout.preferredHeight: 100
        FluRectangle{
            id:layout_avatar
            width: 80
            height: 80
            color:FluTheme.dark ? Qt.rgba(0,0,0,1) : Qt.rgba(1,1,1,1)
            anchors{
                verticalCenter: parent.verticalCenter
            }
            radius: [40,40,40,40]
            Image {
                anchors.fill: parent
                source: UserHelper.avatar
            }
        }

        FluText{
            id:text_name
            text: UserHelper.name
            font: FluTextStyle.Subtitle
            anchors{
                left: layout_avatar.right
                leftMargin: 14
                top: layout_avatar.top
            }
        }

        FluText{
            id:text_account
            text: UserHelper.account
            color: FluColors.Grey120
            anchors{
                left: text_name.left
                top: text_name.bottom
            }
        }

        FluText{
            id:text_bio
            text: UserHelper.bio
            anchors{
                left: text_name.left
                top: text_account.bottom
                topMargin: 10
            }
        }
    }

    FluArea{
        Layout.preferredWidth: text_status.width
        Layout.preferredHeight: text_status.height


        FluText{
            id:text_status
            wrapMode: Text.WrapAnywhere
            padding: 10
            width: Math.min(implicitWidth,root.width-root.leftPadding-root.rightPadding)
            text: UserHelper.statusEmoji + " " + UserHelper.statusMessage
        }

    }

}
