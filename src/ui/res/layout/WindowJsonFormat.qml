import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import "../component"
import "../storage"

CusWindow {
    id:window
    width: 660
    height: 500
    minimumWidth: 660
    minimumHeight: 500
    title: "JsonFormat"

    page: CusPage{

        Rectangle{
            id:layout_menu
            width: 80
            anchors{
                top: toolBar.bottom
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
            border.width: 1
            border.color: Theme.colorPrimary
            color:Theme.colorBackground2
        }

        ScrollView{
            anchors{
                left: parent.left
                right: layout_menu.left
                top: toolBar.bottom
                bottom: parent.bottom
            }
            CusTextArea{
                text:'{"success":true,"errCode":"200","errDesc":"","result":{"serviceAccid":["im_1f7569311cc94947"],"userInfo":{"name":"朱子楚","companyName":"IM即时通讯","orgName":"前端开发部","mobile":"18229858146","email":"zhuzc@hiwitech.com","position":"","jobNo":"18229858146","sex":1,"accid":"im_aa1444fcc8614c5e","token":"2c430eea584e2af500b8b1fba4a7b62f","signature":"","companyId":737804323357728,"companyUniqueNo":"010089ccfe3017445978da6a937866f9705","orgId":746870381741088,"orgUniqueNo":"01053983bd384e84004a511dad21acaeda1","telephone":"","avatar":"http://nim-nos.avicnet.cn/yunxin/MTAwMDAwMA%3D%3D%2FbmltYV8yMzYzOV8xNjQxNDQwODMyNjU0XzM3NjgwZjg1LTRmNTAtNDEyNC05YzZiLTQ4MDA0YTEwYjgyN19uaW1fZGVmYXVsdF9wcm9maWxlX2ljb24%3D?createTime=1641447612","avatarStatus":1,"accountType":10,"account":"18229858146","clearOrg":0,"mobileSearchAuth":0,"nameSearchAuth":0,"noSearchAuth":0,"addIntoTeamAuth":0,"contactPrivacy":0,"userLevel":0,"qrCodeUrl":"","remark":"","workStatus":0,"thirdStatus":0,"userSecret":2,"userSecretName":"一般","pwdStatus":2,"pwdValidTime":null,"pwdVersion":null,"authScope":[0,0],"identitys":[],"ct":null},"loginClientIP":"10.129.137.103","secretKey":"","oaUrl":"https://portal-in.avicnet.cn","authToken":"","token":"34e0cdc47181471d","isApprove":true}}'
            }
        }

        ListModel{
            id:list_model_child
            ListElement{
                key:"name"
                value:"zhuzichu"
                type:1
            }
            ListElement{
                key:"age"
                value:"10"
                type:1
            }
            ListElement{
                key:"sex"
                value:"男"
                type:1
            }
        }


        CusToolBar {
            id:toolBar
            darkEnable: false
            topEnable: true
            title:window.title
        }

        Item{
            anchors{
                left: layout_menu.right
                right: parent.right
                top: toolBar.bottom
                bottom: parent.bottom
            }

            ListView{

                property string json: '[{"key":"name","value":"孙悟空","type":1}]'

                id:list_view
                anchors.fill: parent
                model: JSON.parse(list_view.json)
                delegate: Rectangle{
                    width: list_view.width
                    color:"red"
                    height: 40

                    Text{
                        text:modelData.key + ":"
                    }

                    Text{
                        text:modelData.value
                    }

                }
            }

        }


    }

}
