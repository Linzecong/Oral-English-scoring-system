#include "SpeechSystem.h"
#include<QSound>
#include <QAudioInput>
#include <QFile>
#include <QBuffer>
#include <queue>
#include <stack>
#define MAX_BUFFER_SIZE 512

SpeechSystem::SpeechSystem(QObject *parent) : QObject(parent)
{
    manager = new QNetworkAccessManager(this);
    QObject::connect(manager,&QNetworkAccessManager::finished,this,&SpeechSystem::replyFinish);
    manager2 = new QNetworkAccessManager(this);
    QObject::connect(manager2,&QNetworkAccessManager::finished,this,&SpeechSystem::getResult);

    manager3 = new QNetworkAccessManager(this);
    QObject::connect(manager3,&QNetworkAccessManager::finished,this,&SpeechSystem::getTransSpeechResult);

}

void SpeechSystem::setStatue(QString s)
{
    m_Statue=s;
    emit statueChanged(m_Statue);
}


QString SpeechSystem::Statue(){
    return m_Statue;
}

void SpeechSystem::inclick(QString path)
{
    //   JavaMethod java;

    //  QString path=java.getSDCardPath();

    outputFile.close();
    path=path+".wav";
    outputFile.setFileName(path);
    outputFile.open(QIODevice::WriteOnly|QIODevice::Truncate);
    QAudioFormat format;
    // set up the format you want, eg.
    format.setSampleRate(8000);
    format.setChannelCount(1);
    format.setSampleSize(16);
    format.setCodec("audio/pcm");
    format.setByteOrder(QAudioFormat::LittleEndian);
    format.setSampleType(QAudioFormat::UnSignedInt);
    audio_in = new QAudioInput(format, this);
    audio_in->start(&outputFile);
}

void SpeechSystem::outclick(QString lan,QString path)
{
    TypeLabel=lan;
    path=path+".wav";
    audio_in->stop();
    outputFile.close();
    QFile www;

    www.setFileName(path);
    www.open(QIODevice::ReadOnly );

    QByteArray raw(www.readAll());
    www.close();

    QString path2="test.wav";

    QFile f;
    f.setFileName(path2);
    f.open(QIODevice::WriteOnly|QIODevice::Truncate );

    typedef struct{
        char riff_fileid[4];//"RIFF"
        unsigned long riff_fileLen;
        char waveid[4];//"WAVE"

        char fmt_chkid[4];//"fmt"
        unsigned long fmt_chkLen;

        unsigned short    wFormatTag;        /* format type */
        unsigned short    nChannels;         /* number of channels (i.e. mono, stereo, etc.) */
        unsigned long   nSamplesPerSec;    /* sample rate */
        unsigned long   nAvgBytesPerSec;   /* for buffer estimation */
        unsigned short    nBlockAlign;       /* block size of data */
        unsigned short    wBitsPerSample;


        char data_chkid[4];//"DATA"
        unsigned short data_chkLen;
    }WaveHeader;

    QAudioFormat format;
    // set up the format you want, eg.
    format.setSampleRate(8000);
    format.setChannelCount(1);
    format.setSampleSize(16);
    format.setCodec("audio/pcm");
    format.setByteOrder(QAudioFormat::LittleEndian);
    format.setSampleType(QAudioFormat::UnSignedInt);

    WaveHeader wh={0};
    strcpy(wh.riff_fileid, "RIFF");
    wh.riff_fileLen = raw.length() + 32;
    strcpy(wh.waveid, "WAVE");

    strcpy(wh.fmt_chkid, "fmt ");
    wh.fmt_chkLen = 16;

    wh.wFormatTag = 0x0001;
    wh.nChannels = format.channelCount();
    wh.nSamplesPerSec = format.sampleRate();
    wh.wBitsPerSample = format.sampleSize();
    wh.nBlockAlign =wh.nChannels*wh.wBitsPerSample/8;
    wh.nAvgBytesPerSec =   wh.nBlockAlign*wh.nSamplesPerSec;

    strcpy(wh.data_chkid, "data");



    wh.data_chkLen = raw.length();


    f.write((char *)&wh, sizeof(wh));
    f.write(raw);


    FileNameLabel=path2;

    f.close();

}

void SpeechSystem::playsound(QString path)
{

    path=path+".wav";

    outputFile.setFileName(path);
    outputFile.open(QIODevice::ReadOnly);
    QAudioFormat format;
    // set up the format you want, eg.
    format.setSampleRate(8000);
    format.setChannelCount(1);
    format.setSampleSize(16);
    format.setCodec("audio/pcm");
    format.setByteOrder(QAudioFormat::LittleEndian);
    format.setSampleType(QAudioFormat::UnSignedInt);
    audioOut = new QAudioOutput(format, this);
    audioOut->start(&outputFile);

}

//语义得分
float SpeechSystem::semanticScoring(std::vector<int> whichWord,std::vector<int> synonymWord,int keyWordNum,std::vector<float> vecSore)
{
    float semanticScore = 0;
    int near_synonymNum = 0;//近义词的个数
    float NS = 0;
    float SK = 0;
    for (int i = 0;i < synonymWord.size();i++)
    {
        if ( vecSore[synonymWord[i]] == 0.5)
        {
            near_synonymNum++;
        }
    }

    if (synonymWord.size() != 0 && whichWord.size() != 0)
    {
        NS = (float)near_synonymNum / synonymWord.size();
        SK = (float)synonymWord.size()/ whichWord.size();
    }

    semanticScore = 0.2 * (1 - NS) + 0.4 * SK;

    if (semanticScore >= 0.25 && whichWord.size() >= keyWordNum/2)
    {
        semanticScore = 0.5;
    }
    else
    {
        semanticScore = 0;
    }
    return semanticScore;
}

float SpeechSystem::accurateScoring(float simScore,int keywordNum,std::vector<int> keyNum)
{
    float accScore = 0;
    int missWord = 0;
    if (simScore >= keywordNum * 0.4)
    {
        accScore = 1.5;
        missWord = keywordNum - keyNum.size() ;
        if (missWord%2 != 0)
        {
            missWord--;
        }
        accScore = accScore - (float)missWord / 6;

        if (accScore > 0.5)
        {
            accScore = 1;
        }
        else if (accScore <= 0.5 && accScore > 0)
        {
            accScore = 0.5;
        }
        else
        {
            accScore = 0;
        }
    }
    else
    {
        switch(keyNum.size())
        {
        case 0:
        case 1:
            accScore = 0;
            break;
        case 2:
        case 3:
            accScore = 0.5;
            break;
        default:
            accScore = 1.0;
            break;
        }
    }
    return accScore;
}

float SpeechSystem::frequecyScoring(std::vector<int> left, std::vector<int> right, int voicelength)
{
    float freScore = 0;
    int half = -1;
    int leftsum = 0;
    int rightsum = 0;

    for (int i = 0; i < left.size(); i++)
    {
        if (right[i] > voicelength / 2)
        {
            half = i;
            break;
        }
    }
    if (half == -1)
    {
        freScore = 0;
    }
    else
    {
        for (int i = 0; i < half; i++)
        {
            leftsum += right[i] - left[i];//左端语音部分的长度
        }
        for (int i = half; i < left.size(); i++)
        {
            rightsum += right[i] - left[i];//右端语音部分的长度
        }
        if (leftsum > voicelength * 0.2 && rightsum > voicelength * 0.05)
        {
            freScore = 0.5;
        }
    }
    return freScore;
}

void SpeechSystem::upload()
{
    if(TypeLabel!="short")
        uploadClick();
}

void SpeechSystem::uploadClick()
{
    FILE *fp = NULL;
    fp = fopen(FileNameLabel.toStdString().c_str(), "r");

    if (NULL == fp)
    {
        return ;
    }

    fseek(fp, 0, SEEK_END);
    content_len = ftell(fp);
    fseek(fp, 0, SEEK_SET);
    audiodata = (char *)malloc(content_len);
    fread(audiodata, content_len, sizeof(char), fp);


    //put your own params here
    cuid = "8763554";
    char *apiKey = "DZTIB0fNi4hfI97WslZV3msU";
    char *secretKey = "e50de1ae064c9f445e0c40ebdfd1be9b";

    char host[MAX_BUFFER_SIZE];
    snprintf(host, sizeof(host),
             "http://openapi.baidu.com/oauth/2.0/token?grant_type=client_credentials&client_id=%s&client_secret=%s",
             apiKey, secretKey);

    manager->get(QNetworkRequest(QUrl(host)));
    memset(host, 0, sizeof(host));
}

static const std::string base64_chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        "abcdefghijklmnopqrstuvwxyz"
        "0123456789+/";

static inline bool is_base64(unsigned char c) {
    return (isalnum(c) || (c == '+') || (c == '/'));
}

std::string SpeechSystem::base64_encode(const unsigned char *bytes_to_encode, unsigned int in_len)
{
    std::string ret;
    int i = 0;
    int j = 0;
    unsigned char char_array_3[3];
    unsigned char char_array_4[4];

    while (in_len--) {
        char_array_3[i++] = *(bytes_to_encode++);
        if (i == 3) {
            char_array_4[0] = (char_array_3[0] & 0xfc) >> 2;
            char_array_4[1] = ((char_array_3[0] & 0x03) << 4) + ((char_array_3[1] & 0xf0) >> 4);
            char_array_4[2] = ((char_array_3[1] & 0x0f) << 2) + ((char_array_3[2] & 0xc0) >> 6);
            char_array_4[3] = char_array_3[2] & 0x3f;

            for(i = 0; (i <4) ; i++)
                ret += base64_chars[char_array_4[i]];
            i = 0;
        }
    }

    if (i)
    {
        for(j = i; j < 3; j++)
            char_array_3[j] = '\0';

        char_array_4[0] = (char_array_3[0] & 0xfc) >> 2;
        char_array_4[1] = ((char_array_3[0] & 0x03) << 4) + ((char_array_3[1] & 0xf0) >> 4);
        char_array_4[2] = ((char_array_3[1] & 0x0f) << 2) + ((char_array_3[2] & 0xc0) >> 6);
        char_array_4[3] = char_array_3[2] & 0x3f;

        for (j = 0; (j < i + 1); j++)
            ret += base64_chars[char_array_4[j]];

        while((i++ < 3))
            ret += '=';

    }

    return ret;
}

std::string SpeechSystem::base64_decode(const std::string &encoded_string)
{
    int in_len = encoded_string.size();
    int i = 0;
    int j = 0;
    int in_ = 0;
    unsigned char char_array_4[4], char_array_3[3];
    std::string ret;

    while (in_len-- && ( encoded_string[in_] != '=') && is_base64(encoded_string[in_])) {
        char_array_4[i++] = encoded_string[in_]; in_++;
        if (i ==4) {
            for (i = 0; i <4; i++)
                char_array_4[i] = base64_chars.find(char_array_4[i]);

            char_array_3[0] = (char_array_4[0] << 2) + ((char_array_4[1] & 0x30) >> 4);
            char_array_3[1] = ((char_array_4[1] & 0xf) << 4) + ((char_array_4[2] & 0x3c) >> 2);
            char_array_3[2] = ((char_array_4[2] & 0x3) << 6) + char_array_4[3];

            for (i = 0; (i < 3); i++)
                ret += char_array_3[i];
            i = 0;
        }
    }

    if (i) {
        for (j = i; j <4; j++)
            char_array_4[j] = 0;

        for (j = 0; j <4; j++)
            char_array_4[j] = base64_chars.find(char_array_4[j]);

        char_array_3[0] = (char_array_4[0] << 2) + ((char_array_4[1] & 0x30) >> 4);
        char_array_3[1] = ((char_array_4[1] & 0xf) << 4) + ((char_array_4[2] & 0x3c) >> 2);
        char_array_3[2] = ((char_array_4[2] & 0x3) << 6) + char_array_4[3];

        for (j = 0; (j < i - 1); j++) ret += char_array_3[j];
    }

    return ret;
}

void SpeechSystem::replyFinish(QNetworkReply *reply)
{
    qDebug()<<"Token：";
    QJsonDocument TokenJson=QJsonDocument::fromJson(reply->readAll());//这个返回的JSON包所携带的所有信息
    qDebug()<<TokenJson.toJson(QJsonDocument::Indented);
    QString strText = TokenJson.object()["access_token"].toString();
    qDebug()<<strText;


    QJsonObject json;
    json.insert("format", "pcm");
    json.insert("rate", 8000);
    json.insert("channel", 1);
    json.insert("token", strText.toStdString().c_str());
    json.insert("cuid", cuid);

    json.insert("len", content_len);
    json.insert("lan", TypeLabel);
    json.insert("speech",QString::fromStdString(base64_encode((const unsigned char *)audiodata, content_len)));

    QJsonDocument document;
    document.setObject(json);
    QByteArray byte_array = document.toJson(QJsonDocument::Compact);



    QUrl url("http://vop.baidu.com/server_api");


    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader,QVariant("application/json; charset=utf-8"));
    request.setHeader(QNetworkRequest::ContentLengthHeader,QVariant(byte_array.length()));

    manager2->post(request,byte_array);
}

void SpeechSystem::getResult(QNetworkReply *reply)
{
    QJsonDocument TokenJson=QJsonDocument::fromJson(reply->readAll());//这个返回的JSON包所携带的所有信息
    qDebug()<<TokenJson.toJson(QJsonDocument::Indented);

    QJsonArray list=TokenJson.object()["result"].toArray();


    m_Statue=list.at(0).toString().replace(",","").replace("，","");

    qDebug()<<m_Statue;
    emit statueChanged(m_Statue);


}

void SpeechSystem::transSpeech(QString str)
{
    //A4D660A48A6A97CCA791C34935E4C02BBB1BEC1C
    //DF9E54CA96F73F2E289AEC059F407DE8295A6515
    //C98FDCE95A2FD7BA417F260D43763C40232E****
    //5aba2cc390abffcbe2ccbc1ddb8290e16e404cad
    QNetworkRequest temp(QUrl("http://api.microsofttranslator.com/V2/Ajax.svc/Translate?appId=5aba2cc390abffcbe2ccbc1ddb8290e16e404cad&from=en&to=zh-cn&text="+str));
    manager3->get(temp);
}

QString SpeechSystem::getTransSpeech()
{
    QString temp=TransSpeechText;
    return temp;
}

void SpeechSystem::getTransSpeechResult(QNetworkReply *reply)
{

    TransSpeechText=reply->readAll();


    TransSpeechText=TransSpeechText.replace("\"","");
    qDebug()<<TransSpeechText;

    m_Statue="transdone";

    emit statueChanged(m_Statue);
}

QString SpeechSystem::getscore(QString user)
{
    //QString path=java.getSDCardPath();

    QString path=user+"dbs.dbnum";
    QString longstr;
    QFile LogFile;

    LogFile.setFileName(path);
    LogFile.open(QIODevice::ReadOnly);
    if(LogFile.isOpen()){
        QTextStream LogTextStream(&LogFile);
        LogTextStream>>longstr;
        return longstr;
    }
    else{
        return "NO";
    }
}

QString SpeechSystem::gettestscore(QString user)
{
    //QString path=java.getSDCardPath();

    QString path=user+"dbt.dbnum";
    QString longstr;
    QFile LogFile;

    LogFile.setFileName(path);
    LogFile.open(QIODevice::ReadOnly);
    if(LogFile.isOpen()){
        QTextStream LogTextStream(&LogFile);
        LogTextStream>>longstr;
        return longstr;
    }
    else{
        //生成文件夹
        //QString SdcardPath=java.getSDCardPath();
        //        QString nFileName=SdcardPath+"/DShare/";
        //        QDir *tempdir = new QDir;
        //        bool exist = tempdir->exists(nFileName);
        //        if(!exist)
        //            tempdir->mkdir(nFileName);

        return "NO";
    }
}

void SpeechSystem::savescore(QString str,QString user)
{
    // QString path=java.getSDCardPath();
    QString path=user+"dbs.dbnum";
    QFile LogFile;
    QTextStream LogTextStream(&LogFile);
    LogFile.setFileName(path);
    LogFile.open(QIODevice::WriteOnly);
    if(LogFile.isOpen())
        LogTextStream<<str;
    else{
        m_Statue="SDCardError";
        emit statueChanged(m_Statue);
    }
}

void SpeechSystem::savetestscore(QString str,QString user)
{
    QString path=user+"dbt.dbnum";
    QFile LogFile;
    QTextStream LogTextStream(&LogFile);
    LogFile.setFileName(path);
    LogFile.open(QIODevice::WriteOnly);
    if(LogFile.isOpen())
        LogTextStream<<str;
    else{
        m_Statue="SDCardError";
        emit statueChanged(m_Statue);
    }
}

int min(int a,int b){
    return a>b?b:a;
}

int min3(int a, int b, int c)
{
    return min(a, min(b, c));
}

//请用语义树实现这里
float SpeechSystem::getScoreEn(QString a, QString b)
{
    QStringList alist=a.split(" ");
    QStringList blist=b.split(" ");

    for(int i=0;i<alist.length();i++)
        for(int j=i+1;j<alist.length();j++)
            if(alist[i]==alist[j])
                alist.removeAt(j);
    for(int i=0;i<blist.length();i++)
        for(int j=i+1;j<blist.length();j++)
            if(blist[i]==blist[j])
                blist.removeAt(j);

    int dp[100][100];


    int len1=alist.length();
    int len2=blist.length();

    for(int i = 0; i <= len1; i++)
        dp[i][0] = i;
    for(int j = 0; j <= len2; j++)
        dp[0][j] = j;
    for(int i = 1; i <= len1; i++)
        for(int j = 1; j <= len2; j++)
            dp[i][j] = min3(dp[i-1][j] + 1, dp[i][j-1] + 1, dp[i-1][j-1] + (alist[i-1] == blist[j-1] ? 0 : 1));


    float max=len1>len2?len1:len2;


    return (float(max-dp[len1][len2])/max)*2;
}


//请用语义树实现这里
float SpeechSystem::getScoreZh(QString a, QString b)
{
    for(int i=0;i<a.length();i++)
        for(int j=i+1;j<a.length();j++)
            if(a[i]==a[j])
                a.remove(j,1);
    for(int i=0;i<b.length();i++)
        for(int j=i+1;j<b.length();j++)
            if(b[i]==b[j])
                b.remove(j,1);

    int dp[100][100];


    int len1=a.length();
    int len2=b.length();

    for(int i = 0; i <= len1; i++)
        dp[i][0] = i;
    for(int j = 0; j <= len2; j++)
        dp[0][j] = j;
    for(int i = 1; i <= len1; i++)
        for(int j = 1; j <= len2; j++)
            dp[i][j] = min3(dp[i-1][j] + 1, dp[i][j-1] + 1, dp[i-1][j-1] + (a[i-1] == b[j-1] ? 0 : 1));


    float max=len1>len2?len1:len2;
    return (float(max-dp[len1][len2])/max)*2;

}



