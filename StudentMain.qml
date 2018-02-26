import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import "qrc:/GlobalVariable.js" as GlobalColor
import QtGraphicalEffects 1.0

Rectangle {
    id:mainrect;
    anchors.fill: parent


    MouseArea{
        anchors.fill: parent
        onClicked: {

        }
    }

    property string username;


    function login(a){

        if(a==="20151002362")
            headname.text="欢迎，林泽聪"

        username=a;
        practicepage.item.setusername(a);
        scorepage.item.setusername(a);
        testpage.item.setusername(a);
        testscorepage.item.setusername(a);
    }



    Loader{
        id:practicepage
        height: parent.height
        width:parent.width
        Behavior on x{
            NumberAnimation{
                easing.type: Easing.InOutQuint
                duration: 600

            }
        }
        x: width
        source: "qrc:/PracticePage.qml"
        z:102

    }

    function setscore(a,b){
        scorepage.item.setscore(a,b)
    }

    function setscorevisible(a){
        scorepage.item.settihao(-1)
        scorepage.item.settihao(a)
        scorepage.x=0
    }

    function settestscore(a,b){
        testscorepage.item.settestscore(a,b)
    }

    function settestscorevisible(a){
        testscorepage.item.settihao(-1)
        testscorepage.item.settihao(a)
        testscorepage.x=0
    }

    Loader{
        id:scorepage
        height: parent.height
        width:parent.width
        Behavior on x{
            NumberAnimation{
                easing.type: Easing.InOutQuint
                duration: 600

            }
        }
        x: width
        source: "qrc:/ScorePage.qml"
        z:103
    }

    Loader{
        id:testpage
        height: parent.height
        width:parent.width
        Behavior on x{
            NumberAnimation{
                easing.type: Easing.InOutQuint
                duration: 600

            }
        }
        x: width
        source: "qrc:/TestPage.qml"
        z:102
    }


    Loader{
        id:testscorepage
        height: parent.height
        width:parent.width
        Behavior on x{
            NumberAnimation{
                easing.type: Easing.InOutQuint
                duration: 600

            }
        }
        x: width
        source: "qrc:/TestScorePage.qml"
        z:102
    }


    Image {
        id:bg
        source: "qrc:/image/bg.jpg"
        anchors.fill: parent

        Rectangle{
            id:head
            z:5
            width:parent.width
            height: parent.height/16*2
            color: "white"
            anchors.top: parent.top
            opacity: 0.3
        }
        Label{
            id:headname
            text:"学生端"
            anchors.centerIn: head
            font{
                bold: true;
                pointSize: 20
            }
            color: "white";
            MouseArea{
                anchors.fill: parent
                onClicked: {
                }
            }
        }

        Rectangle{
            id:xitilianxi

            height:width
            width: head.height*1.2

            anchors.left: parent.left
            anchors.leftMargin: width/4

            anchors.top: head.bottom
            anchors.topMargin: head.height

            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                radius: 5
                color: GlobalColor.ShareMSG
            }
            radius: height/2
            Label{
                text: "习题练习"
                color: "white"
                font{
                    bold: true;
                    pointSize: 15
                }
                anchors.centerIn: parent
            }
            color:xitiarea.pressed?GlobalColor.ShareMSG:"#6b8bdc"
            Behavior on color{
                ColorAnimation {
                    easing.type: Easing.Linear
                    duration: 200
                }
            }

            MouseArea{
                id:xitiarea
                anchors.fill: parent
                onClicked: {

                    practicepage.x=0
                }
            }
        }


        Rectangle{
            id:chakanpingfen

            height:width
            width: head.height*1.2

            anchors.right: parent.right
            anchors.rightMargin: width/4

            anchors.top: head.bottom
            anchors.topMargin: head.height
            radius: height/2
            color:xitiarea2.pressed?GlobalColor.ShareMSG:"#6b8bdc"
            Behavior on color{
                ColorAnimation {
                    easing.type: Easing.Linear
                    duration: 200
                }
            }

            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                radius: 5
                color: GlobalColor.ShareMSG
            }
            Label{
                text: "查看习题评分"
                color: "white"
                font{
                    bold: true;
                    pointSize: 15
                }
                anchors.centerIn: parent
            }

            MouseArea{
                id:xitiarea2
                anchors.fill: parent
                onClicked: {
                scorepage.x=0
                }
            }
        }


        Rectangle{
            id:kaoshi

            height:width
            width: head.height*1.2

            anchors.left: parent.left
            anchors.leftMargin: width/4

            anchors.top: xitilianxi.bottom
            anchors.topMargin: head.height*1.5
    radius: height/2
            color:xitiarea4.pressed?GlobalColor.ShareMSG:"#6b8bdc"
            Behavior on color{
                ColorAnimation {
                    easing.type: Easing.Linear
                    duration: 200
                }
            }


            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                radius: 5
                color: GlobalColor.ShareMSG
            }
            Label{
                text: "考试"
                color: "white"
                font{
                    bold: true;
                    pointSize: 15
                }
                anchors.centerIn: parent
            }

            MouseArea{
                id:xitiarea4
                anchors.fill: parent
                onClicked: {
                    testpage.x=0
                    testpage.item.reset()
                    testpage.item.reset2()
                }
            }
        }


        Rectangle{
            id:chakankaoshifen

            height:width
            width: head.height*1.2

            anchors.right: parent.right
            anchors.rightMargin: width/4

            anchors.top: xitilianxi.bottom
            anchors.topMargin: head.height*1.5
            radius: height/2
            color:xitiarea3.pressed?GlobalColor.ShareMSG:"#6b8bdc"
            Behavior on color{
                ColorAnimation {
                    easing.type: Easing.Linear
                    duration: 200
                }
            }


            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                radius: 5
                color: GlobalColor.ShareMSG
            }
            Label{
                text: "查看考试评分"
                color: "white"
                font{
                    bold: true;
                    pointSize: 15
                }
                anchors.centerIn: parent
            }

            MouseArea{
                id:xitiarea3
                anchors.fill: parent
                onClicked: {
    testscorepage.x=0
                }
            }
        }



    }





}
