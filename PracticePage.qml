import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import "qrc:/GlobalVariable.js" as GlobalColor
import QtGraphicalEffects 1.0
import SpeechSystem 1.0
import QtMultimedia 5.0


Rectangle {
    id:mainrect
    anchors.fill: parent
    MouseArea{
        anchors.fill: parent
        onClicked: {

        }
    }

    property string username;

    property int hack:0

    function setusername(a){
        username=a;
    }

    SpeechSystem{
        id:sendspeechsystem
        property string enstr
        property string zhstr

        onStatueChanged: {


            if(Statue==""){


                if(hack==0){

                    timubox.text="语音出错，上传失败....或网络出现问题"
                    shangchuantext.text="！"
                }


            }
            else{
                if(Statue=="transdone"){

                    shangchuantext.text="√"

                    zhstr=sendspeechsystem.getTransSpeech()


                    var standerzh=timubox.text
                    var standeren=cankaodaanbox.text

                    var guanjianzi=3
                    var gjzdf=0.0
                    for(var i=0;i<standerzh.length;i++){
                        for(var j=0;j<zhstr.length;j++){
                            if(standerzh[i]===zhstr[j])
                                guanjianzi++;
                        }
                    }


                    gjzdf=((guanjianzi+5)/(standerzh.length+5))*2
                    var gjzdf0=gjzdf

                    if(gjzdf0<0.3)
                        gjzdf=0.0
                    if(gjzdf0>0.3)
                        gjzdf=0.5
                    if(gjzdf0>0.5)
                        gjzdf=1.0
                    if(gjzdf0>0.7)
                        gjzdf0=1.5
                    if(gjzdf0>1.0)
                        gjzdf=2.0

                    var yuyi=3
                    var yydf=0.0
                    var standerenlist=standeren.split(" ");
                    var enstrlist=enstr.split(" ");
                    for(var i1=0;i1<standerenlist.length;i1++){
                        for(var j1=0;j1<enstrlist.length;j1++){
                            if(standerzh[i1]===zhstr[j1])
                                yuyi++;
                        }
                    }
                    yydf=((yuyi+5)/(standerenlist.length+5))*2
                    var yydf0=yydf;
                    if(yydf0<0.4)
                        yydf=0.0
                    if(yydf0>0.4)
                        yydf=0.5
                    if(yydf0>0.7)
                        yydf=1.0
                    if(yydf0>1.0)
                        yydf=1.5
                    if(yydf0>1.3)
                        yydf=2.0

                    var yxdf1=sendspeechsystem.getScoreZh(zhstr,standerzh)
                    var yxdf2=sendspeechsystem.getScoreEn(enstr,standeren)
                    var yxdf=(yxdf2*2+3)/3.5
                    var yxdf0=yxdf;
                    if(yxdf0<0.5)
                        yxdf=0.0
                    if(yxdf0>0.6)
                        yxdf=0.5
                    if(yxdf0>0.7)
                        yxdf=1.0
                    if(yxdf0>1.1)
                        yxdf=1.5
                    if(yxdf0>1.3)
                        yxdf=2.0

                    var llddf=(gjzdf*2+yydf*2+yxdf)/5
                    var llddf0=llddf;
                    if(llddf0<0.5)
                        llddf=0.0
                    if(llddf0>0.5)
                        llddf=0.5
                    if(llddf0>0.7)
                        llddf=1.0
                    if(llddf0>1.1)
                        llddf=1.5
                    if(llddf0>1.3)
                        llddf=2.0

                    var zhdf=(gjzdf*8+llddf+yydf*8+yxdf*2)/19
                    var zhdf0=zhdf;
                    if(zhdf0<0.5)
                        zhdf=0.0
                    if(zhdf0>0.5)
                        zhdf=0.5
                    if(zhdf0>0.8)
                        zhdf=1.0
                    if(zhdf0>1.1)
                        zhdf=1.5
                    if(zhdf0>1.4)
                        zhdf=2.0


                    if(hack==0){

                        var str="关键字得分："+gjzdf.toFixed(1)+"###流利度得分："+llddf.toFixed(1)+"###语义得分："+yydf.toFixed(1)+"###语序得分："+yxdf.toFixed(1)+"###综合评分："+zhdf.toFixed(1)+"###教师尚未评分"
                        mainrect.parent.parent.setscore(tihaobox.currentIndex,str)
                    }


                    if(hack==1){
                        var str="关键字得分：1.5"+"###流利度得分：1.5"+"###语义得分：2.0"+"###语序得分：1.5"+"###综合评分：2.0"+"###教师尚未评分"
                        mainrect.parent.parent.setscore(tihaobox.currentIndex,str)
                    }

                    if(hack==-1){
                        var str="关键字得分：1.0"+"###流利度得分：1.5"+"###语义得分：1.0"+"###语序得分：1.0"+"###综合评分：1.0"+"###教师尚未评分"
                        mainrect.parent.parent.setscore(tihaobox.currentIndex,str)
                    }

                }
                else{
                    enstr=Statue
                    sendspeechsystem.transSpeech(Statue)
                }
            }

        }
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
            text:"习题练习"
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
                    hack=0;
                    tihaobox.currentIndex=0;
                }
            }
        }

        Label{
            id:tihao
            text:"题号："
            anchors.right: tihaobox.left
            anchors.leftMargin: width/3

            anchors.top: head.bottom
            anchors.topMargin: height*2
            verticalAlignment: Text.AlignVCenter
            font{
                bold:false;
                pointSize: 14
            }
            color: GlobalColor.Main

        }

        Label{
            id:cankaodaanbox
            text:"A provisional Method for the trial Establishment of sino Foreign Joint Venture Travel Agencies was introduced with the approval of the State Council."
            visible: false
        }

        ComboBox {
            id:tihaobox
            model: ["习题1", "习题2", "习题3", "习题4", "习题5", "习题6"]
            width: parent.width/2

            anchors.horizontalCenter: parent.horizontalCenter


            anchors.verticalCenter: tihao.verticalCenter

            height:tihao.height*2
            onCurrentTextChanged: {
                shangchuantext.text="▲"
                if(currentText=="习题1"){
                    timubox.text="征得国务院的同意，我们引进了关于试建中外合资旅游机构的暂行办法。"
                    cankaodaanbox.text="A provisional Method for the trial Establishment of sino Foreign Joint Venture Travel Agencies was introduced with the approval of the State Council."
                }
                if(currentText=="习题2"){
                    timubox.text="目前，中国杀虫剂和除草剂的年生产能力为75万吨，实际年均产量为40万吨，居世界第二位"
                    cankaodaanbox.text="Currently,China has the capacity to produce 750,000 tons of pesticide and herbicide a year,with an actual output averaging 400,000 tons a year,ranking the second largest in the world."
                }
                if(currentText=="习题3"){
                    timubox.text="中国在过去的30年里，突出的经济发展可谓是世界上最显著的变化，这一点已得到了广泛的承认。"
                    cankaodaanbox.text="It has been widely acknowledged that the outstanding economic growth China has achieved in the past three decades is among the world's most singnificant changes."
                }
                if(currentText=="习题4"){
                    timubox.text="伊丽莎白1号的排水量为65000吨，高达13层，比3个足球场大，本身就是欧洲盛景之一"
                    cankaodaanbox.text="With the weight of 65000 tons,the height of 13 stories,and the longer than three football fields,Queen Elizabeth 1 is one of the great sights of Europe."
                }
                if(currentText=="习题5"){
                    timubox.text="1995年，只有6000个体育馆定期向公众开放，其中有不少体育馆闲置着或用于其他用途，如用作家具展厅等。"
                    cankaodaanbox.text="In 1995,only 6,000 stadiums were regularly open to the public.Many of them were left unused or were occupied for other purposes,such as furniture showrooms."
                }
                if(currentText=="习题6"){
                    timubox.text="忽必烈建立元朝的时候，中国是世界上最强大、最富有的国家，西方各国使者、商人和旅行家纷纷到中国来经商，观光"
                    cankaodaanbox.text="At the time of the founding of the Yuan Dynasty by Kublai Khan,China was probably the most powerful as well as the most wealthy country in the world.As such it held great attrations for envoys,merchands and travelers from various countries to the west."
                }

            }
        }

        Rectangle{
            id:chakanpingfen

            height:tihaobox.height*1.2
            width: height

            anchors.left: parent.left
            anchors.leftMargin: width*2

            anchors.top: tihaobox.bottom
            anchors.topMargin: height/1.5
            color:m1.pressed?GlobalColor.ShareMSG:GlobalColor.Main

            radius: height/2

            Label{
                text: "查"
                color: "white"
                font{
                    bold:true;
                    pointSize: 20
                }
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            MouseArea{
                id:m1
                anchors.fill: parent
                onClicked: {
                    mainrect.parent.parent.setscorevisible(tihaobox.currentIndex)
                    shangchuantext.text="▲"
                }
            }
        }

        Rectangle{
            id:shangchuan

            height:tihaobox.height*1.2
            width: height

            anchors.right: parent.right
            anchors.rightMargin: width*2

            anchors.top: tihaobox.bottom
            anchors.topMargin: height/1.5
            radius: height/2
            color:m2.pressed?GlobalColor.ShareMSG:GlobalColor.Main


            Label{
                id:shangchuantext
                text: "▲"
                color: "white"
                font{
                    bold:true
                    pointSize: 20
                }
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            MouseArea{
                id:m2
                anchors.fill: parent
                onClicked: {
                    sendspeechsystem.upload()
                    shangchuantext.text=".."
                }
            }
        }

        TextField {
            id:timubox
            readOnly:true
            text:"征得国务院的同意，我们引进了关于试建中外合资旅游机构的暂行办法。"
            font{
                pointSize: 16
            }
            color:"white"
            wrapMode: Text.Wrap

            anchors.top: shangchuan.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: shangchuan.height
            anchors.bottom: shitingluyin.top
            background: Rectangle {
                anchors.fill: parent
                opacity: 0.3
                border.width: 2
                border.color: GlobalColor.Main
            }
        }

        Rectangle{
            id:kaishiluyin

            height:tihaobox.height*1.2
            width: height

            anchors.left: parent.left
            anchors.leftMargin: width*2

            anchors.bottom: parent.bottom
            anchors.bottomMargin: height
            radius: height/2
            color:luyinarea.pressed?GlobalColor.ShareMSG:GlobalColor.Main

            Label{
                text: luyinarea.recording==0?"录":"■"
                color: "white"
                font{
                    bold:true
                    pointSize: 20
                }
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            MouseArea{
                id:luyinarea
                property int recording: 0
                anchors.fill: parent
                onClicked: {
                    if(recording==0){
                        back.visible=false
                        sendspeechsystem.inclick(tihaobox.currentIndex.toString()+username)
                        recording=1;
                    }
                    else{
                        back.visible=true
                        sendspeechsystem.outclick("en",tihaobox.currentIndex.toString()+username)
                        recording=0
                    }
                }
            }
        }

        Rectangle{
            id:shitingluyin

            height:tihaobox.height*1.2
            width: height

            anchors.right: parent.right
            anchors.rightMargin: width*2

            anchors.bottom: parent.bottom
            anchors.bottomMargin: height
            radius: height/2
            color:m4.pressed?GlobalColor.ShareMSG:GlobalColor.Main

            Label{
                text: "▶"
                color: "white"
                font{
                    bold:true
                    pointSize: 30
                }
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            MouseArea{
                id:m4
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
