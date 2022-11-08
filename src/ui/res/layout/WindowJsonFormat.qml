import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import "../component"
import "../storage"
import UI

CusWindow {
    id:window
    width: 700
    height: 500
    minimumWidth: 700
    minimumHeight: 500
    title: "JsonFormat"

    JsonFormartHelper{
        id:helper
    }

    page: CusPage{

        Rectangle{
            id:layout_menu
            width: 80
            x:300
            anchors{
                top: toolBar.bottom
                bottom: parent.bottom
            }
            border.width: 1
            border.color: Theme.colorPrimary
            color:Theme.colorBackground

            ColumnLayout{
                width: parent.width
                CusButton{
                    text: "格式化"
                    Layout.topMargin: 10
                    Layout.alignment: Qt.AlignHCenter
                    onClicked: {
                        var formatJson = helper.format(edit_left.text)
                        formatJson =formatJson.replace(/( )/g,"&nbsp;")
                        formatJson = formatJson.replace(/(\n)/g,"<br>");
                        formatJson = formatJson.replace(/(")[^"]*":/gi,
                                                        function (match, capture) {
                                                            return "<font color=\"#FF92278F\">"+match+"</font>"
                                                        })
                        edit_right.text = formatJson
                    }
                }
                CusButton{
                    text:"导出"
                    Layout.alignment: Qt.AlignHCenter
                    onClicked: {
                        console.debug("导出")
                    }
                }
            }

        }

        ScrollView{
            anchors{
                left: parent.left
                right: layout_menu.left
                top: toolBar.bottom
                bottom: parent.bottom
            }
            CusTextArea{
                id:edit_left
                text:'{"success":true,"errCode":"200","errDesc":"","result":{"serviceAccid":["im_1f7569311cc94947"],"userInfo":{"name":"朱子楚","companyName":"IM即时通讯","orgName":"前端开发部","mobile":"18229858146","email":"zhuzc@hiwitech.com","position":"","jobNo":"18229858146","sex":1,"accid":"im_aa1444fcc8614c5e","token":"2c430eea584e2af500b8b1fba4a7b62f","signature":"","companyId":737804323357728,"companyUniqueNo":"010089ccfe3017445978da6a937866f9705","orgId":746870381741088,"orgUniqueNo":"01053983bd384e84004a511dad21acaeda1","telephone":"","avatar":"http://nim-nos.avicnet.cn/yunxin/MTAwMDAwMA%3D%3D%2FbmltYV8yMzYzOV8xNjQxNDQwODMyNjU0XzM3NjgwZjg1LTRmNTAtNDEyNC05YzZiLTQ4MDA0YTEwYjgyN19uaW1fZGVmYXVsdF9wcm9maWxlX2ljb24%3D?createTime=1641447612","avatarStatus":1,"accountType":10,"account":"18229858146","clearOrg":0,"mobileSearchAuth":0,"nameSearchAuth":0,"noSearchAuth":0,"addIntoTeamAuth":0,"contactPrivacy":0,"userLevel":0,"qrCodeUrl":"","remark":"","workStatus":0,"thirdStatus":0,"userSecret":2,"userSecretName":"一般","pwdStatus":2,"pwdValidTime":null,"pwdVersion":null,"authScope":[0,0],"identitys":[],"ct":null},"loginClientIP":"10.129.137.103","secretKey":"","oaUrl":"https://portal-in.avicnet.cn","authToken":"","token":"34e0cdc47181471d","isApprove":true}}'
            }
        }


        CusToolBar {
            id:toolBar
            darkEnable: false
            topEnable: true
            title:window.title
        }

        ScrollView{
            id:scroll_view
            anchors{
                left: layout_menu.right
                right: parent.right
                top: toolBar.bottom
                bottom: parent.bottom
            }


            CusTextEdit{
                id:edit_right
                wrapMode: Text.WrapAnywhere
                textFormat: Text.RichText
                x:8
                width: scroll_view.width - 16
                font.pixelSize: 14
                onWidthChanged: {
                    text = text
                }
            }
        }
    }
}
