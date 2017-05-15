<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0"/>
    <title>${title}</title>

    <!-- jQuery文件 -->
    <script src="http://libs.baidu.com/jquery/1.10.2/jquery.min.js"></script>

    <link rel="stylesheet" href="css/common.css">

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="http://cdn.bootcss.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>

</head>
<body>
<div class="img-box" id="imgBox">
    <!-- 显示的内容 包含：用户信息和图片 -->
    <div class="user-info">
        <input type="hidden" value="${protionId}" id="protionId"/>
        <div class="user_head" id="middle_space_user_head">
            <img id="img_user_head" src="${headimgurl}">
        </div>
        <div class="user_name" id="middle_space_user_name">
            <span id="font_user_name">${username}</span>
        </div>
    </div>
    <!-- 滚动的图片div -->
    <div class="scroll-img" id="scroll-img">
        <div class="scroll-img-box" id="scrollImgBox">
            <div class="scroll-img-td" id="marquePic1">
                <img name="pic"
                     id="main_img_work"
                     src="${imgpath}"
                     alt="share_img">
            </div>
            <div class="scroll-img-td" id="marquePic2"></div>
        </div>
    </div>
    <!-- 播放按钮div  -->
    <div class="button_div" id="switch_div" action="scroll">
        <img id="switch" src="img/play.png">
        <audio controls="controls" loop="true" id="music" src="../music/${songName}" style="visibility: hidden;">
            您的浏览器不支持audio标签
        </audio>
    </div>
    <!-- 作品说说内容div start -->
    <div class="work_content" id="work_content_div" style="display: none">

        <span class="content_all" id="work_content_span">${title}</span>

        <div class="content_img_div" style="float: right;">
            <img id="work_content_img" src="img/open.png">
        </div>
    </div>
    <!-- 作品其他信息 start-->
    <div id="work_other_info_div">
        <div id="work_other_date_play_num_info_div" class="date_play_num" >
            <span class="howLong" id="howLong"></span>
            <span class="playFont">播放</span>
            <span class="playNum" id="playNum"></span>
            <span class="playFont">次</span>
            <span class="playOther"></span>
        </div>

        <div id="work_other_prise_comment_info_div">
            <div class="priseNum" id="priseNum_div">
                <img class="priseNum_like" src="img/like.png">
                <span id="priseNum">0</span>
            </div>
            <div class="commentNum" id="commentNum_div">
                <img class="priseNum_like" src="img/comment.png">
                <span id="commentNum">0</span>
            </div>
        </div>
    </div>
    <!--底部 Bottom -->
    <div class="bottom_div" id="bottom_div">
        <span class="bottom_div_span">横向显示效果更佳！！！</span>
        <div id="bottom_logo">
            <img id="bottom_logo_img" src="img/logo.png">
            <div style="display: inline-block;">
                <span class="bottom_logo_apan1">PaiPai360</span>
                <span class="bottom_logo_apan2">全景拍照神器</span>
            </div>
        </div>
        <div id="bottom_app_and_device">
            <div id="bottom_app">
                <a class="bottom_app_a" href="http://aipp3d.com/downLoadApp?lang=zh_CN">
                    <span class="downloadWrap">
                        <span id="bottom_app_text1" class="downloadText">拍拍360APP</span><br/>
                        <span id="bottom_app_text2" class="downloadText"><b>去下载&gt;</b></span>
                    </span>
                </a>
            </div>

            <div id="bottom_device">

                <img id="bottom_device_img" src="img/device.png">

                <a class="bottom_device_a" href="http://aipp3d.com/goodsDetail?pid=592&amp;name=360">
                    <span id="bottom_device_text1" class="downloadText">拍照云台</span><br>
                    <span id="bottom_device_text2" class="downloadText"><b>去购买&gt;&nbsp;</b></span>
                </a>

            </div>
        </div>
    </div>

</div>
</body>
<script type="application/javascript" charset="utf-8">

    var desW=360;//设置设计稿宽
    var winW=document.documentElement.clientWidth;  //设备的实际宽度
    var scale=desW/100;
    document.documentElement.style.fontSize=winW/scale+"px";

    var bigPic = $(".scroll-img-td img");  // 图片img
    var marquePic1=document.getElementById("marquePic1");
    var marquePic2=document.getElementById("marquePic2");
    var protionId = $("#protionId").val();
    var bodyOfferHei=document.body.offsetHeight;

    var isPlay = true;//是否滚动状态设置，默认滚动
    var isShowAll = false;    // 是否展示所有说说内容
    var contentLineStr = "single";
    var contentAllStr = "poth";
    var prop;
    var screenH=screen.height;
    $("#switch_div").on("click",function(){
        //播放按钮点击事件
        pic_scroll();
    });
    //停止滚动
    function stopRolling() {
        isPlay = true;
        stopMusic();
        clearInterval(timer);
    }
    //继续滚动
    function startRolling() {
        isPlay = false;
        startMusic();
        timer = setInterval("Marquee(5)", speed);
    }
    //开关按钮点击处理函数
    function pic_scroll() {
        if (isPlay) {
            // 继续滚动
            startRolling();
        } else {
            stopRolling();
        }
    }
    // 实现图片循环滚动的方法
    function Marquee(n) {
        if (marquePic1.offsetWidth - scrollImgBox.scrollLeft <= 0) {

            scrollImgBox.scrollLeft = 0;
        } else {

            scrollImgBox.scrollLeft = scrollImgBox.scrollLeft + n;
        }
    }
    var imgBox=document.getElementById("imgBox");
    var scrollImg=document.getElementById("scroll-img");
    var scrollImgBox=document.getElementById("scrollImgBox");


    var audio = document.getElementById("music"); // 音乐

    var userNameSpan = $("div.user_name span"); // 用户姓名
    var userHeadImg = $("div.user_head img"); // 用户头像

    var workContent = $("div.work_content span"); // 说说内容
    var contentImg = $("div.content_img_div img");

    var howLongSpan = $("div.date_play_num span.howLong");  // 日期
    var playNumSpan = $("div.date_play_num span.playNum");  // 播放次数
    var commentNumSpan = $("div.commentNum span");          // 评论数
    var priseNumSpan = $("div.priseNum span");  // 点赞数目

    var startX = 0;
    var startY = 0;

    var speed = 30;   // 自动播放的时,使用的间隔时间,间隔越小速度越大
    var timer;        // 用于定时器

    judgeTheOrientation();


    function startMusic() { // 播放音乐

        if (audio.currentSrc !== null) {
            audio.load();
            audio.play();
        }
        $("#switch_div").find('img').attr("src", "img/pause.png");
    }

    function stopMusic() { // 暂停音乐

        if (!audio.paused) {
            audio.pause();
        }
        $("#switch_div").find('img').attr("src", "img/play.png");
    }

    // 查看全部说说内容
    $("#work_content_div").on("click",function(){
        if (isShowAll) {
            contentImg.attr("src", "img/open.png");
            workContent.text(contentLineStr);
        } else {
            contentImg.attr("src", "img/close.png");
            workContent.text(contentAllStr);
        }
        isShowAll = !isShowAll;
    });



    // 滑动开始事件处理
    var startHandler = function (event) {
        // 停止自动播放
        stopRolling();
        startX = event.touches[0].pageX;
        startY = event.touches[0].pageY;

    };

    // 滑动过程中事件处理
    var moveHandler = function (event) {
        event.preventDefault();

        var touch = event.touches[0];
        var moveX = touch.pageX;
        var moveY = touch.pageY;
        var dY = moveY - startY;
        var len = moveX - startX;

        len = len * -1;   // 为了矫正方向
        len = len / 10;   // 为了减速

        if (marquePic1.offsetWidth - scrollImgBox.scrollLeft <= 0) {

            scrollImgBox.scrollLeft = 0;

        } else {

            scrollImgBox.scrollLeft = scrollImgBox.scrollLeft + len;

            // 如果最近一次的向右滑动，图片滑动到了左边的边缘，重置一下
            if (scrollImgBox.scrollLeft <= 0) {
                scrollImgBox.scrollLeft = marquePic1.offsetWidth - 2; // 目的是为了能继续向右滑动
            }

            // 如果最近一次的向左滑动，图片滑动到了右边的边缘，重置一下
            if (scrollImgBox.scrollLeft >= marquePic1.offsetWidth) {
                scrollImgBox.scrollLeft = 0; // 目的是为了能继续向左滑动
            }
        }
    };

    // 滑动结束事件处理
    var endHandler = function (event) {};

    scrollImg.addEventListener("touchstart", startHandler, false);
    scrollImg.addEventListener("touchmove", moveHandler, false);
    scrollImg.addEventListener("touchend", endHandler, false);

    // 判断手机屏幕方向
    function judgeTheOrientation() {
        switch (window.orientation) {
            case 0://ipad、iphone横屏；Andriod竖屏
                $("body").attr("class", "portrait");
                orientation = 'portrait';
                break;
            case 180://ipad、iphone横屏；Andriod竖屏
                $("body").attr("class", "portrait");
                orientation = 'portrait';
                break;
            case -90://ipad、iphone竖屏；Andriod横屏
                $("body").attr("class", "landscape");
                orientation = 'landscape';
                break;
            case 90://ipad、iphone竖屏；Andriod横屏
                $("body").attr("class", "landscape");
                orientation = 'landscape';
                break;
            default:
                break;
        }
        return false;
    }

    $(window).bind("orientationchange", function (event) {

        var otherTimer = setInterval(function(){
            if(bodyOfferHei!=document.body.offsetHeight){

                if(window.orientation == 90 || window.orientation == -90){
                    $("#bottom_div").css("display", "none");
                    if(parseInt(document.body.offsetHeight)<parseInt(bodyOfferHei)){

                        bodyOfferHei=document.body.offsetHeight;//375
                        clearInterval(otherTimer);

                        if(screen.height==screenH){
                            var navHeight=0;//浏览器地址栏高度
                            var setImgHeight=bodyOfferHei;//图片高度

                        }else{
                            var navHeight=screen.height-bodyOfferHei;//浏览器地址栏高度
                            var setImgHeight=Math.round(parseFloat(screen.height)-navHeight);//图片高度
                        }


                        $(".scroll-img-td").css("width",Math.round(setImgHeight*prop));

                        $("#main_img_work").css("height",Math.round(setImgHeight));
                        $("#main_img_work").css("width",Math.round(setImgHeight*prop));
                        $("#marquePic2").css("left",Math.round(setImgHeight*prop));


                        marquePic2.innerHTML = marquePic1.innerHTML;

                        judgeTheOrientation();
                    }
                }else{
                    if(parseInt(document.body.offsetHeight)>parseInt(bodyOfferHei)){

                        $("#bottom_div").css("display", "block");
                        bodyOfferHei=document.body.offsetHeight;
                        clearInterval(otherTimer);

                        var navHeight=screen.height-bodyOfferHei;//浏览器地址栏高度
                        var setImgHeight=Math.round(parseFloat(screen.height)-navHeight);//图片高度

                        $(".scroll-img-td").css("width",Math.round(setImgHeight*prop));
                        $("#main_img_work").css("height",Math.round(setImgHeight));
                        $("#main_img_work").css("width",Math.round(setImgHeight*prop));
                        $("#marquePic2").css("left",Math.round(setImgHeight*prop));

                        marquePic2.innerHTML = marquePic1.innerHTML;

                        judgeTheOrientation();
                    }

                }
            }
        }, 50);
    });
    // 请求接口刷新数据
    $.ajax({
        url: "http://www.paipai360.cn:80/paipai360//production/sharegetProductionDetails.action?id=" + protionId,
        method: 'post',
        data: {"id": protionId, "type": 1},
        dataType: "jsonp", // 数据类型为jsonp
        jsonp: "jsonpCallback", // 服务端用于接收callback调用的function名的参数
        success: function (data) {
            if (data.code == 'success') {
                var username = data.data.username;
                var userHeadUrl = data.data.headimgurl;
                var priseNum = data.data.praiseNum;
                var commentNum = data.data.commentNum;
                var howLong = data.data.howLong;

                var content = data.data.title;
                var songName = data.data.songName;

                userNameSpan.text(username);
                userHeadImg.attr("src", userHeadUrl);
                howLongSpan.text(howLong);
                playNumSpan.text(data.data.playNum);
                commentNumSpan.text(commentNum);
                priseNumSpan.text(priseNum);

                bigPic.attr("src", data.data.url);
                if (content !== null && content.length > 14) {
                    contentLineStr = content.substring(0, 14);
                    contentAllStr = content;
                } else if (content !== null) {
                    contentLineStr = content;
                    contentAllStr = content;
                }
                workContent.text(contentLineStr);
            }
        }
    });
    function getImgSize(){
        $("#main_img_work").each(function (i) {
            //这里做下说明，$("<img/>")这里是创建一个临时的img标签，类似js创建一个new Image()对象！
            $("<img/>").attr("src", $(bigPic).attr("src")).load(function () {
                /*
                 如果要获取图片的真实的宽度和高度有三点必须注意
                 1、需要创建一个image对象：如这里的$("<img/>")
                 2、指定图片的src路径
                 3、一定要在图片加载完成后执行如.load()函数里执行
                 */
                var realWidth = this.width;
                var realHeight = this.height;//
                prop=(realWidth/realHeight);//通过真实图片获得宽高比
                var navHeight=screen.height-bodyOfferHei;//浏览器地址栏高度
                var setImgHeight=Math.round(parseFloat(screen.height)-navHeight);//图片高度

                $(".scroll-img-td").css("width",Math.round(setImgHeight*prop));
                $("#marquePic2").css("left",Math.round(setImgHeight*prop));

                marquePic2.innerHTML = marquePic1.innerHTML;
            });
        });
    }
    getImgSize();
</script>
</html>