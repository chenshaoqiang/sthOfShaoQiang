<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0"/>
    <title>${title}</title>
    <!-- jQuery文件 -->
    <script src="http://libs.baidu.com/jquery/1.10.2/jquery.min.js"></script>
    <!--样式表文件-->
    <link rel="stylesheet" href="css/index.css">
</head>
<body>
<div class="wrap" id="wrap" style="height: auto;padding-bottom: 0.5rem;">
    <!--用户信息-->
    <div class="user_info">
        <div class="user_head">
            <img id="img_user_head" src="${headimgurl}">
        </div>
        <div class="user_name">
            <span id="user_name_span">${username}</span>
            <span id="creat_time_span">${createtime}</span>
        </div>
    </div>
    <!--全景图-->
    <div class="scroll-img2" id="scroll-img2">
        <img name="pic"
             id="main_img_work"
             src="${imgpath}">
    </div>
    <!--描述-->
    <div class="describe">
        <span class="describe_span">${say}</span>
        <!--评论按钮-->
        <div class="comment_div" id="comment_div">
            <img id="comment" src="img/comment_w.png">
        </div>
    </div>
    <!--评论、点赞-->
    <div class="icon_box">
        <img class="comment_icon fl" src="./img/comment_icon_black.png" alt=""/>
        <span class="icon_span fl">${commentCount}</span>
        <img class="comment_icon fl" src="./img/parise_icon_black.png" alt=""/>
        <span class="icon_span fl">${praiseCount}</span>
    </div>
</div>
</body>
<script type="text/javascript"  charset="utf-8">

    var protionId = $("#protionId").val(),
            userHeadImg = $("div.user_head img"),                  // 用户头像
            userNameSpan = $("#user_name_span"),                   // 用户姓名
            creatTimeSpan= $("#creat_time_span"),                  // 时间
            comment,                                                //储存弹幕内容
            imgWidth,
            imgHeight,
            showBarrage = false,                                   //是否显示弹幕
            bigPic = $(".scroll-img2 img");

    function getImgSize(){
        /*
         * 如果要获取图片的真实的宽度和高度有三点必须注意
         * 1、需要创建一个image对象：如这里的$("<img/>")
         * 2、指定图片的src路径
         * 3、一定要在图片加载完成后执行如.load()函数里执行
         * */
        $("#main_img_work").each(function (i) {
            //这里做下说明，$("<img/>")这里是创建一个临时的img标签，类似js创建一个new Image()对象！
            $("<img/>").attr("src", $(bigPic).attr("src")).load(function () {

                var realWidth = this.width;
                var realHeight = this.height;
                prop = (realWidth / realHeight);
                imgWidth = Math.round(parseInt($("#wrap").css("width")));
                imgHeight = parseInt(imgWidth / prop);

                /*
                 * 生成弹幕
                 * */
                $(".littleComment").remove();
                if(comment && comment.length > 0){

                    for(var i = 0;i < comment.length; i++){

                        if(comment[i].userIcon == '' || comment[i].userIcon == null || comment[i].userIcon == undefined){

                            comment[i].userIcon = "./img/default_head.png";

                        }
                        var posX = parseInt((comment[i].x / realWidth) *  Math.round(imgWidth));
                        var posY = parseInt((comment[i].y / realHeight) *  Math.round(imgHeight));

                        var str = "<div class='littleComment' style='left:" + posX + "px;top:" + posY + "px ' >";
                        str += "<img src=" + comment[i].userIcon + " alt='comment'/>";
                        str += "<span class='littleComment_span'>" + comment[i].text + "</span>";
                        str += "</div>";

                        $(".scroll-img2").append(str);

                    }

                }

                showBarrage ? ($(".littleComment").show(),$("#comment").attr("src", "img/comment_y.png"))
                        : ($(".littleComment").hide(),$("#comment").attr("src", "img/comment_w.png"));

            });
        });
    }
    (function() {
        function getScale(){

            if(window.orientation == 0 || window.orientation == 180){

                //设置压缩比
                deviceWidth = document.documentElement.clientWidth > 1300 ? 1300 : document.documentElement.clientWidth;
                document.documentElement.style.fontSize = (deviceWidth / 7.5) + 'px';

            }else if(window.orientation == 90 || window.orientation == -90){

                //横屏的时候为避免元素被放大，依然采用竖屏的压缩比
                deviceWidth = window.screen.height > 1300 ? 1300 : window.screen.height;
                document.documentElement.style.fontSize = (deviceWidth / 7.5) + 'px';

            }
        }

        getScale();        //这是页面加载的时候第一次获取压缩比重绘

        window.onresize = function(){

            getScale();    //窗口变化的时候重置压缩比，比如自动横屏的时候
            getImgSize();
        };

    })();
    /*
     * 弹幕点击事件
     * */
    $("#comment_div").on("click",function(){

        showBarrage = !showBarrage;
        showBarrage ? ($(".littleComment").show(),$("#comment").attr("src", "img/comment_y.png"))
                : ($(".littleComment").hide(),$("#comment").attr("src", "img/comment_w.png"));

    });
    //模拟评论数据
    comment  = ${comment};
    //    comment = [
    //        {"x":120,"y":50,"text":"太美了","userIcon":"./img/user1.jpg"},{"x":700,"y":90,"text":"这是哪儿","userIcon":"./img/user2.jpg"},
    //        {"x":300,"y":450,"text":"真的好漂亮啊！！","userIcon":"./img/user3.jpg"},{"x":630,"y":250,"text":"一起去玩吧！","userIcon":""},
    //        {"x":150,"y":250,"text":"风景不错","userIcon":"./img/user1.jpg"},{"x":580,"y":550,"text":"拍的真好啊","userIcon":"./img/user1.jpg"}
    //    ];
    getImgSize();

    /*
     * 时间格式化
     * @param {Number} input 时间戳
     * */
    function dateFormat(input){

        if (input == null || input == "" || typeof(input) == "undefined") {
            return "";
        }

        var _date = new Date(input);
        var year = _date.getFullYear();
        var month = _date.getMonth() + 1 > 9 ? _date.getMonth() + 1 : "0" + (_date.getMonth() + 1);
        var day = _date.getDate() > 9 ? _date.getDate() : "0" + _date.getDate();
        var hour = _date.getHours() + 1 > 9 ? _date.getHours() : "0" + _date.getHours();
        var minutes = _date.getMinutes() + 1 > 9 ? _date.getMinutes() : "0" + _date.getMinutes();
        var seconds = _date.getSeconds() + 1 > 9 ? _date.getSeconds() : "0" + _date.getSeconds();

        return year + "-" + month + "-" + day + " " + hour + ":" + minutes + ":" + seconds;

    }

</script>
</html>