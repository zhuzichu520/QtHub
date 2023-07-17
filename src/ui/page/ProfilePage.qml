import QtQuick
import QtQuick.Layouts
import FluentUI
import QtHub

FluScrollablePage {
    title: "Profile"
    launchMode: FluPage.SingleInstance

    ProfileController{
        id:controller
    }

    Component.onCompleted: {
        controller.loadProfileInfo()
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

}
