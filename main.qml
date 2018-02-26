import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import "qrc:/GlobalVariable.js" as GlobalColor
import QtGraphicalEffects 1.0

Rectangle{
    //主登录页面
    id:mainrect
    height: 960
    width:540

    Image{
        id:bg
        source: "qrc:/image/bg.jpg"
        anchors.fill: parent
        MouseArea{
            anchors.fill: parent
            onClicked: {

            }
        }

        Loader{
            id:studentmain
            visible: false
            anchors.fill: parent
            source: "qrc:/StudentMain.qml"
            z:102
        }


        Loader{
            id:teachertmain
            visible: false
            anchors.fill: parent
            source: "qrc:/TeacherPage.qml"
            z:102
        }


        Rectangle{
            id:toprect;
            width:parent.width;
            height: parent.height/16*5.5;
            //color:GlobalColor.Main
            anchors.top: parent.top;
            opacity: 0.1

        }
        Label{
            anchors.centerIn: toprect
            height: toprect.height/3
            width: height
            text:"口语教学系统"
            opacity: 1.0
            font{
                pixelSize: height/2
            }
            color: "white"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter

        }

        Rectangle{
            id:mask
            color:GlobalColor.Main
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            Behavior on opacity {
                NumberAnimation{
                    duration: 800
                    easing.type: Easing.InCirc

                }
            }
            z:1000
            Rectangle{
                id:mask2
                Behavior on opacity {
                    NumberAnimation{
                        duration: 400
                        easing.type: Easing.InCirc

                    }
                }
                width:parent.width;
                height: parent.height/16*5.5;
                color:GlobalColor.Main
                y:parent.height/2-height/2

                x:0
                Label{
                    id:masktext
                    anchors.centerIn: parent
                    height: parent.height/3
                    width: height
                    text:"口语教学系统"
                    font{
                        pixelSize: height/2
                    }
                    color: "white"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter

                }
                Behavior on y {
                    NumberAnimation{
                        duration: 400
                        easing.type: Easing.OutCirc

                    }
                }
            }
        }

        Rectangle{
            color: "white"
            opacity: 0.1
            anchors.top:toprect.bottom;
            anchors.topMargin: parent.height/16;
            anchors.horizontalCenter: parent.horizontalCenter
            height: toprect.height
            width: toprect.width/1.3
            z:5
        }


        Timer{
            id:tt;
            interval: 2000
            repeat: false
            onTriggered: {
                mask2.y=0
                mask.opacity=0.0
                mask2.opacity=0.0
            }
        }

        Component.onCompleted: {
            tt.running=true
        }


        //ID行
        Row{
            id:userrow
            anchors.top:toprect.bottom;
            anchors.topMargin: parent.height/16*1.5;
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height/23;
            //width:parent.width/9*6;
            spacing: 40
            //用户图标
            Image{
//                Rectangle{
//                    anchors.fill: parent
//                    color:GlobalColor.Main
//                    z:-100
//                    anchors.margins: 3
//                }
                id:usericon;
                height: parent.height
                width: height
                fillMode: Image.PreserveAspectFit
                source:"qrc:/image/user.png"
            }
            //文本域
            TextField{
                height:parent.height
                width: mainrect.width/2
                id:usertext
                placeholderText:"账号"
                validator:RegExpValidator{regExp:/^[0-9a-zA-Z]{1,18}$/}
                background: Rectangle {
                          implicitWidth: mainrect.width/2
                          implicitHeight: parent.height*2
                          opacity: 0.5
                          border.width: 2
                          border.color: GlobalColor.Main
                }
            }
        }

        //密码行
        Row{
            id:passrow
            anchors.top:userrow.bottom
            anchors.topMargin: usericon.width
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height/23;
            //width:parent.width/9*6;
            spacing: 40
            Image{
//                Rectangle{
//                    anchors.fill: parent
//                    color:GlobalColor.Main
//                    z:-100
//                    anchors.margins: 3
//                }
                id:passwordicon
                height: parent.height
                width: height
                fillMode: Image.PreserveAspectFit
                source:"qrc:/image/password.png"
            }
            TextField{
                height:parent.height
                width: mainrect.width/2
                id:passwordtext
                placeholderText:"密码"
                echoMode:TextInput.Password
                validator:RegExpValidator{regExp:/^[0-9a-zA-Z]{1,20}$/}
                background: Rectangle {
                          implicitWidth: mainrect.width/2
                          implicitHeight: parent.height*2
                          opacity: 0.5
                          border.width: 2
                          border.color: GlobalColor.Main
                }
            }
        }


        Rectangle{
            visible: false
            id:teacherloginbutton
            width:userrow.height*1.6*1.5
            height:width
            anchors.right: userrow.right
            anchors.rightMargin: 40
            anchors.top: passrow.bottom
            anchors.topMargin: passrow.height
            color:loginma.pressed?GlobalColor.ShareMSG:"#6b8bdc"
            radius: height/2
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                radius: 5
                color: GlobalColor.ShareMSG
            }
            Label{
                id:logintext
                text: "教师登录"
                color: "white"
                font{
                    pointSize: 14

                }
                anchors.centerIn: parent
            }
            Behavior on color{
                ColorAnimation {
                    easing.type: Easing.Linear
                    duration: 200
                }
            }
            MouseArea{
                id:loginma
                anchors.fill: parent
                onClicked: {
                    if(usertext.text.length<6||usertext.text.length>18){

                        return;
                    }
                    if(passwordtext.text.length<8||passwordtext.text.length>20){

                        return;
                    }
                    if(passwordtext.text.indexOf("|")>=0||usertext.text.indexOf("|")>=0||passwordtext.text.indexOf("@")>=0||usertext.text.indexOf("@")>=0){

                        return;
                    }
                    mask.opacity=1.0
                    mask2.opacity=1.0
                    mask2.y=mask2.parent.height/2-mask2.height/2
                    tt3.start()
                }
            }
        }


        Rectangle{
            id:studentloginbutton
            width:userrow.height*1.6
            //height:userrow.height*1.6
            height: width
            //anchors.left: userrow.left
            //anchors.leftMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: passrow.bottom
            anchors.topMargin: passrow.height
            color:registma.pressed?GlobalColor.ShareMSG:"#6b8bdc"
            //radius: height/2.5
            radius: height/2
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                radius: 5
                color: GlobalColor.ShareMSG
            }
            Label{
                id:registtext
                text: "登录"
                color: "white"
                font{
                    pointSize: 14
                }
                anchors.centerIn: parent
            }
            Behavior on color{
                ColorAnimation {
                    easing.type: Easing.Linear
                    duration: 200
                }
            }
            MouseArea{
                id:registma
                anchors.fill: parent
                onClicked: {
                    if(usertext.text.length<6||usertext.text.length>18){

                        return;
                    }
                    if(passwordtext.text.length<8||passwordtext.text.length>20){

                        return;
                    }
                    if(passwordtext.text.indexOf("|")>=0||usertext.text.indexOf("|")>=0||passwordtext.text.indexOf("@")>=0||usertext.text.indexOf("@")>=0){

                        return;
                    }

                    if(usertext.text!=passwordtext.text){
                        return;
                    }




                    mask.opacity=1.0
                    mask2.opacity=1.0
                    mask2.y=mask2.parent.height/2-mask2.height/2
                    tt2.start()


                }
            }
        }


        Timer{
            id:tt2;
            interval: 4000
            repeat: false
            onTriggered: {
                studentmain.visible=true
                studentmain.item.login(usertext.text)
                masktext.text="登录成功"
                mask2.opacity=0.0
                mask.opacity=0.0


            }
        }

        Timer{
            id:tt3;
            interval: 4000
            repeat: false
            onTriggered: {
                teachertmain.visible=true

                masktext.text="登录成功"
                mask2.opacity=0.0
                mask.opacity=0.0


            }
        }


    }





}



