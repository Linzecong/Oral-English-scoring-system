import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import "qrc:/GlobalVariable.js" as GlobalColor
import QtGraphicalEffects 1.0
import QtMultimedia 5.0
import SpeechSystem 1.0

Rectangle {
    id:mainrect;
    anchors.fill: parent
    MouseArea{
        anchors.fill: parent
        onClicked: {

        }
    }

    property string username;

    function setusername(a){
        username=a;

        var list=sendspeechsystem.getscore(username).split("@")

        if(sendspeechsystem.getscore(username)==="NO"){
            score.push("关键字得分：空###流利度得分：空###语义得分：空###语序得分：空###综合评分：空###教师尚未评分");
            score.push("关键字得分：空###流利度得分：空###语义得分：空###语序得分：空###综合评分：空###教师尚未评分");
            score.push("关键字得分：空###流利度得分：空###语义得分：空###语序得分：空###综合评分：空###教师尚未评分");
            score.push("关键字得分：空###流利度得分：空###语义得分：空###语序得分：空###综合评分：空###教师尚未评分");
            score.push("关键字得分：空###流利度得分：空###语义得分：空###语序得分：空###综合评分：空###教师尚未评分");
            score.push("关键字得分：空###流利度得分：空###语义得分：空###语序得分：空###综合评分：空###教师尚未评分");
            score.push("关键字得分：空###流利度得分：空###语义得分：空###语序得分：空###综合评分：空###教师尚未评分");
            score.push("关键字得分：空###流利度得分：空###语义得分：空###语序得分：空###综合评分：空###教师尚未评分");
            score.push("关键字得分：空###流利度得分：空###语义得分：空###语序得分：空###综合评分：空###教师尚未评分");
        }else{
            score.push(list[0]);
            score.push(list[1]);
            score.push(list[2]);
            score.push(list[3]);
            score.push(list[4]);
            score.push(list[5]);
            score.push(list[6]);
            score.push(list[7]);
            score.push(list[8]);
        }


        tihaobox.currentIndex=2
        tihaobox.currentIndex=0
    }

    property var score:[]

    function setscore(a,b){
        score[a]=b
        sendspeechsystem.savescore(score.join("@"),username)
    }

    function settihao(a){
        tihaobox.currentIndex=-1
        tihaobox.currentIndex=a
    }
    SpeechSystem{
        id:sendspeechsystem
    }

    Component.onCompleted: {

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
        text:"习题评分"
        anchors.centerIn: head
        font{
bold:false
            pointSize: 20
        }
        color: "white";
        MouseArea{
            anchors.fill: head
            onClicked: {

            }
        }
    }

    Label{
        id:back
        height: head.height
        width:height
        text:"＜"
        color: "white"
        font{
            pixelSize: (head.height)/2
        }
        anchors.left: head.left
        anchors.leftMargin: head.height/70*4
        anchors.verticalCenter: head.verticalCenter
        verticalAlignment: Text.AlignVCenter
        MouseArea{
            anchors.fill: parent
            onClicked: {
                mainrect.parent.x=mainrect.parent.height

            }
        }
    }

    Label{
        id:tihao
        text:"题号："
        anchors.right: tihaobox.left
        anchors.rightMargin: width/3
        anchors.top: head.bottom
        anchors.topMargin: height*2
        verticalAlignment: Text.AlignVCenter
        font{
            bold:false
            pointSize: 12
        }
        color: GlobalColor.Main

    }

    ComboBox {
        id:tihaobox
        model: ["习题1", "习题2", "习题3", "习题4", "习题5", "习题6"]
        width: parent.width/2


        anchors.horizontalCenter: parent.horizontalCenter

        anchors.verticalCenter: tihao.verticalCenter

        height:tihao.height*2

        onCurrentTextChanged: {
            if(currentText=="习题1"){
                timubox.text="征得国务院的同意，我们引进了关于试建中外合资旅游机构的暂行办法。"
                guanjianzidefen.text=score[0].split("###")[0]
                liulidudefen.text=score[0].split("###")[1]
                yuyidefen.text=score[0].split("###")[2]
                yuxudefen.text=score[0].split("###")[3]
                zonghedefen.text=score[0].split("###")[4]
                jiaoshidefen.text=score[0].split("###")[5]
                cankaodaanboxtext.text="A provisional Method for the trial Establishment of sino-Foreign Joint-Venture Travel Agencies was introduced with the approval of the State Council."
            }

            if(currentText=="习题2"){
                timubox.text="目前，中国杀虫剂和除草剂的年生产能力为75万吨，实际年均产量为40万吨，居世界第二位"
                guanjianzidefen.text=score[1].split("###")[0]
                liulidudefen.text=score[1].split("###")[1]
                yuyidefen.text=score[1].split("###")[2]
                yuxudefen.text=score[1].split("###")[3]
                zonghedefen.text=score[1].split("###")[4]
                jiaoshidefen.text=score[1].split("###")[5]
                cankaodaanboxtext.text="Currently,China has the capacity to produce 750,000 tons of pesticide and herbicide a year,with an actual output averaging 400,000 tons a year,ranking the second largest in the world."
            }
            if(currentText=="习题3"){
                timubox.text="中国在过去的30年里，突出的经济发展可谓是世界上最显著的变化，这一点已得到了广泛的承认。"
                guanjianzidefen.text=score[2].split("###")[0]
                liulidudefen.text=score[2].split("###")[1]
                yuyidefen.text=score[2].split("###")[2]
                yuxudefen.text=score[2].split("###")[3]
                zonghedefen.text=score[2].split("###")[4]
                jiaoshidefen.text=score[2].split("###")[5]
                cankaodaanboxtext.text="It has been widely acknowledged that the outstanding economic growth China has achieved in the past three decades is among the world's most singnificant changes."
            }
            if(currentText=="习题4"){
                timubox.text="伊丽莎白1号的排水量为65000吨，高达13层，比3个足球场大，本身就是欧洲盛景之一"
                guanjianzidefen.text=score[3].split("###")[0]
                liulidudefen.text=score[3].split("###")[1]
                yuyidefen.text=score[3].split("###")[2]
                yuxudefen.text=score[3].split("###")[3]
                zonghedefen.text=score[3].split("###")[4]
                jiaoshidefen.text=score[3].split("###")[5]
                cankaodaanboxtext.text="With the weight of 65000 tons,the height of 13 stories,and the longer than three football fields,Queen Elizabeth 1 is one of the great sights of Europe."

            }
            if(currentText=="习题5"){
                timubox.text="1995年，只有6000个体育馆定期向公众开放，其中有不少体育馆闲置着或用于其他用途，如用作家具展厅等。"
                guanjianzidefen.text=score[4].split("###")[0]
                liulidudefen.text=score[4].split("###")[1]
                yuyidefen.text=score[4].split("###")[2]
                yuxudefen.text=score[4].split("###")[3]
                zonghedefen.text=score[4].split("###")[4]
                jiaoshidefen.text=score[4].split("###")[5]
                cankaodaanboxtext.text="In 1995,only 6,000 stadiums were regularly open to the public.Many of them were left unused or were occupied for other purposes,such as furniture showrooms."
            }
            if(currentText=="习题6"){
                timubox.text="忽必烈建立元朝的时候，中国是世界上最强大、最富有的国家，西方各国使者、商人和旅行家纷纷到中国来经商，观光"
                guanjianzidefen.text=score[5].split("###")[0]
                liulidudefen.text=score[5].split("###")[1]
                yuyidefen.text=score[5].split("###")[2]
                yuxudefen.text=score[5].split("###")[3]
                zonghedefen.text=score[5].split("###")[4]
                jiaoshidefen.text=score[5].split("###")[5]
                cankaodaanboxtext.text="At the time of the founding of the Yuan Dynasty by Kublai Khan,China was probably the most powerful as well as the most wealthy country in the world.As such it held great attrations for envoys,merchands and travelers from various countries to the west."

            }



                if(guanjianzidefen.text.indexOf("空")>=0){
                    cankaodaanboxtext.text="请先作答！";
                }

        }

    }

    Rectangle{
        id:timu

        height:tihaobox.height*1.6

        anchors.right: cankaodaanbox.right
        anchors.left: cankaodaanbox.left

        anchors.top: tihao.bottom
        anchors.topMargin:timu.height/2

        color:"white"
        opacity: 0.3

        MouseArea{
            anchors.fill: parent
            onClicked: {

            }
        }
    }

    Label{
        id:timubox
        text: "征得国务院的同意，我们引进了关于试建中外合资旅游机构的暂行办法。"
        wrapMode: Text.Wrap
        horizontalAlignment: Text.AlignHCenter
        width: timu.width
        color: "white"
        font{
            pointSize: 12
        }
        anchors.centerIn: timu
    }

    Label{
        id:cankaodaan
        text:"参考答案："
        verticalAlignment: Text.AlignVCenter
        anchors.left: cankaodaanbox.left

        anchors.top: timu.bottom
        anchors.topMargin: height

        font{
            bold:false
            pointSize: 12
        }
        color: GlobalColor.Main

    }

    Rectangle{
        border.width: 1
        border.color: "blue"

        anchors.top: cankaodaan.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: cankaodaan.height
         anchors.bottom: column.top

         id:cankaodaanbox
         color: "white"
         opacity: 0.3
    }
    Text {
        id:cankaodaanboxtext
        text:"Currently,China has the capacity to produce 750,000 tons of pesticide and herbicide a year,with an actual output averaging 400,000 tons a year,ranking the second largest in the world."

        wrapMode: Text.Wrap
        font{
            pointSize: 16
        }
        color:"white"
        anchors.fill: cankaodaanbox
        anchors.margins: 10
    }


    Rectangle{
        color:"white"
        opacity: 0.2
        anchors.fill: column;
        anchors.margins: -10
    }
    Column{
        id:column

        width: parent.width/3
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: cankaodaan.height/4
        anchors.bottom: kaishiluyin.top
        anchors.bottomMargin: kaishiluyin.height/2



        Label{
            id:guanjianzidefen
            text:"关键字得分：2.0"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font{
                pointSize: 13
            }
            color: "white"

        }
        Label{
            id:liulidudefen
            text:"流利度得分：1.5"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter

            font{
                pointSize: 13
            }
            color: "white"
        }
        Label{
            id:yuyidefen
            text:"语义得分：2.0"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter

            font{
                pointSize: 13
            }
            color: "white"
        }
        Label{
            id:yuxudefen
            text:"语序得分：1.5"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter

            font{
                pointSize: 13
            }
            color: "white"

        }
        Label{
            id:zonghedefen
            text:"综合评分：1.8"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter

            font{
                bold:true
                pointSize: 15
            }
            color: "white"
        }
        Label{
            id:jiaoshidefen
            text:"教师评分：2.0"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter

            font{
                bold:true
                pointSize: 15
            }
            color: "white"
            visible: false
        }

    }

    Rectangle{
        id:kaishiluyin

        height:tihaobox.height*1.5

        width: height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: height/2
        color:GlobalColor.Main
        radius: width/2

        Label{
            text: "▶"
            color: "white"
            font{
                bold:false
                pointSize: 30
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                sendspeechsystem.playsound(tihaobox.currentIndex.toString()+username)

            }
        }
        Audio {
            id : audio
        }
    }

    }
}
