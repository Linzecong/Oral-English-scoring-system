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

    Loader{
        id:teachertscore
        height: parent.height
        width:parent.width
        Behavior on x{
            NumberAnimation{
                easing.type: Easing.InOutQuint
                duration: 600

            }
        }
        x: width
        source: "qrc:/TeacherScorePage.qml"
        z:102
    }


    Rectangle{

        id:head
        z:5
        width:parent.width
        height: parent.height/16*2
        color: GlobalColor.Main
        anchors.top: parent.top
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            radius: 10
            color: GlobalColor.Main
        }

        Label{
            id:headname
            text:"教师端"
            anchors.centerIn: parent
            font{
bold:false
                pointSize: 20
            }
            color: "white";
            MouseArea{
                anchors.fill: parent
                onClicked: {

                }
            }
        }




    }



    ComboBox {
        id:banjibox
        model: ["高三（1）班", "高三（2）班", "高三（3）班"]
        width: parent.width/3
        height:head.height/2.5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: head.bottom
        anchors.topMargin: head.height/4
        onCurrentIndexChanged:{
            if(currentIndex==0){
                view.model=studentmodel1
            }
            if(currentIndex==1){
                view.model=studentmodel2
            }
            if(currentIndex==2){
                view.model=studentmodel3
            }

        }
    }







    ListModel{
        id:studentmodel1
        ListElement{
            StudentName:"20151002362"
        }
        ListElement{
            StudentName:"20151002363"
        }
        ListElement{
            StudentName:"20151002364"
        }
        ListElement{
            StudentName:"20151002365"
        }
        ListElement{
            StudentName:"20151002366"
        }
        ListElement{
            StudentName:"20151002367"
        }
        ListElement{
            StudentName:"20151002368"
        }
        ListElement{
            StudentName:"20151002369"
        }
        ListElement{
            StudentName:"20151002370"
        }
        ListElement{
            StudentName:"20151002371"
        }
        ListElement{
            StudentName:"20151002372"
        }
        ListElement{
            StudentName:"20151002373"
        }
        ListElement{
            StudentName:"20151002374"
        }
        ListElement{
            StudentName:"20151002375"
        }
    }
    ListModel{
        id:studentmodel2
        ListElement{
            StudentName:"20151002462"
        }
        ListElement{
            StudentName:"20151002463"
        }
        ListElement{
            StudentName:"20151002464"
        }
        ListElement{
            StudentName:"20151002465"
        }
        ListElement{
            StudentName:"20151002466"
        }
        ListElement{
            StudentName:"20151002467"
        }
        ListElement{
            StudentName:"20151002468"
        }
        ListElement{
            StudentName:"20151002469"
        }
        ListElement{
            StudentName:"20151002470"
        }
        ListElement{
            StudentName:"20151002471"
        }
        ListElement{
            StudentName:"20151002472"
        }
        ListElement{
            StudentName:"20151002473"
        }
        ListElement{
            StudentName:"20151002474"
        }
        ListElement{
            StudentName:"20151002475"
        }
    }
    ListModel{
        id:studentmodel3
        ListElement{
            StudentName:"20151002562"
        }
        ListElement{
            StudentName:"20151002563"
        }
        ListElement{
            StudentName:"20151002564"
        }
        ListElement{
            StudentName:"20151002565"
        }
        ListElement{
            StudentName:"20151002566"
        }
        ListElement{
            StudentName:"20151002567"
        }
        ListElement{
            StudentName:"20151002568"
        }
        ListElement{
            StudentName:"20151002569"
        }
        ListElement{
            StudentName:"20151002570"
        }
        ListElement{
            StudentName:"20151002571"
        }
        ListElement{
            StudentName:"20151002572"
        }
        ListElement{
            StudentName:"20151002573"
        }
        ListElement{
            StudentName:"20151002574"
        }
        ListElement{
            StudentName:"20151002575"
        }
    }


    ListView{
        id:view
        spacing: -1
        anchors.top: banjibox.bottom
        anchors.topMargin:  head.height/4
        clip: true
        width: parent.width

        anchors.bottom: parent.bottom

        model: studentmodel1


        add: Transition{
            NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 300 }
            NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 300 }
        }

        Rectangle {
            id: scrollbar
            anchors.right: view.right
            anchors.rightMargin: 3
            y: view.visibleArea.yPosition * view.height
            width: 5
            height: view.visibleArea.heightRatio * view.height
            color: "grey"
            radius: 5
            z:50
            visible: view.dragging||view.flicking
        }

        delegate: Item{
            id:delegate
            width:mainrect.width
            height: head.height/2

            Rectangle{
                anchors.fill: parent
                color:"white"

                border.color: "lightgrey"
                border.width: 1

                Text{
                    id:textlabel;
                    anchors.fill: parent
                    anchors.leftMargin:height/2
                    verticalAlignment: Text.AlignVCenter
                    font{
                        pointSize: 16
                        bold: true
                    }
                    text:StudentName
                    color:GlobalColor.Main

                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        teachertscore.x=0
                        teachertscore.item.setusername(StudentName)
                    }
                }

            }
        }

    }








}
