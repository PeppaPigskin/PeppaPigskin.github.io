<%--
  Created by IntelliJ IDEA.
  User: WuChen
  Date: 2020/09/30
  Time: 13:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <!--进行移动端页面适应设置-->
    <meta name="viewport" content="width=device,initial-scale=1.0">
    <title>${title}</title>
    <!--引入前端框架的semantic的css资源-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.css">
    <!--引入动画样式-尚未起效-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.0.0/animate.min.css"/>
    <!--引入文本排版样式-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/typo.css">
    <!--    <link rel="stylesheet" href="static/css/animate.css">-->
    <!--引入字体高亮的样式-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/lib/prism/prism.css">
    <!--引入目录生成样式----对应的h标签必须要有id属性-->
    <!--    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tocbot/4.11.1/tocbot.css">-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/lib/tocbot/tocbot.css">
    <!--引入自定义样式-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/myStyle.css">
    <!--引入jquery资源-->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.2/dist/jquery.min.js"></script>
    <!--引入前端框架semantic的js资源-->
    <script src="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.js"></script>
    <!--引入目录生成js-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tocbot/4.11.1/tocbot.min.js"></script>
    <!--一引入平滑滚动插件js-->
    <script src="https://cdn.jsdelivr.net/npm/jquery.scrollto@2.1.2/jquery.scrollTo.min.js"></script>
    <!--引入滚动检测js插件-->
    <script src="${pageContext.request.contextPath}/static/lib/waypoint/jquery.waypoints.min.js"></script>
    <!--引入二维码生成js-->
    <script src="${pageContext.request.contextPath}/static/lib/qrcode/qrcode.js"></script>
    <!--引入字体高亮的js-->
    <script src="${pageContext.request.contextPath}/static/lib/prism/prism.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#aboutMenu").addClass("active");
            $("#searchBtn").hide();
        });
        $('#show_hide_icon').click(function () {
            $('.menu-item').toggleClass('m-mobile-hide');
        });

        $('.qq').popup();

        $('.weChat').popup({
            popup: $('.weChat-qr.popup'),
            on: 'hover',
            position: 'bottom center',
        });

    </script>
</head>
<body>
<jsp:include page="template_nav.jsp"></jsp:include>
<div class="m-padded-tb-big m-container">
    <!--container:根据屏幕不同尺寸达到最适应的效果-->
    <div class="ui container">
        <div class="ui grid">
            <!--左侧图片区-->
            <div class="eleven wide column">
                <div class="ui segment">
                    <img src="${pageContext.request.contextPath}/static/images/timg.gif" width="800" alt="" class="ui rounded image">
                </div>
            </div>
            <!--右侧说明和标签部分-->
            <div class="five wide column">
                <div class="ui top attached segment">
                    <div class="ui header">关于我</div>
                </div>
                <!--文字介绍-->
                <div class="ui attached segment">
                    ${applicationScope.bloggerAdmin.profile}
                </div>

                <!--个人标签-->
                <div class="ui attached segment">

                    <div class="ui red basic left pointing label m-margin-tb-tiny">思考人生</div>
                    <div class="ui red basic left pointing label m-margin-tb-tiny">编程</div>
                    <div class="ui red basic left pointing label m-margin-tb-tiny">电影</div>
                    <div class="ui red basic left pointing label m-margin-tb-tiny">健身</div>
                </div>
                <div class="ui attached segment">
                    <div class="ui teal basic left pointing label m-margin-tb-tiny">JAVA</div>
                    <div class="ui teal basic left pointing label m-margin-tb-tiny">SSM</div>
                    <div class="ui teal basic left pointing label m-margin-tb-tiny">SpringBoot</div>
                    <div class="ui teal basic left pointing label m-margin-tb-tiny">MySql</div>
                    <div class="ui teal basic left pointing label m-margin-tb-tiny">JDBC</div>
                    <div class="ui teal basic left pointing label m-margin-tb-tiny">...</div>
                </div>
                <div class="ui bottom attached segment">
                    <a href="https://github.com/PeppaPigskin/PeppaPigskin.github.io" id="gitHub" target="_blank" title="github源码地址" class="ui github circular icon button">
                        <i class="github icon"></i>
                    </a>
                    <a href="#" id="weChatGongZh" class="ui weChat circular icon button">
                        <i class="wechat icon"></i>
                    </a>
                    <a href="#" id="QQ" class="ui qq circular icon button" data-position="bottom center"
                       data-content="2855736274">
                        <i class="qq icon"></i>
                    </a>
                    <a href="#" id="weiBo" class="ui weibo circular icon button">
                        <i class="weibo icon"></i>
                    </a>

                    <!--微信公众号二维码-->
                    <div class="ui weChat-qr flowing popup transition hidden">
                        <img src="${pageContext.request.contextPath}/static/images/weChart.png" title="关注我的微信公众号" alt="我的微信公众号"
                             class="ui rounded bordered  image"
                             style="width: 100px;margin: 0px">
                    </div>

                    <!--QQ二维码-->
                    <div class="ui qq-qr flowing popup transition hidden">
                        <img src="${pageContext.request.contextPath}/static/images/qq.png" alt="QQ联系方式"
                             class="ui rounded bordered  image"
                             style="width: 100px;margin: 0px">
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="template_footer.jsp"></jsp:include>
</body>
<script>
    /*设置赞赏按钮相关触发动作*/
    $('#weChatGongZh').popup({
        popup: $('.weChat-qr.popup'),
        on: 'hover',
        position: 'bottom center',
    });

    $('#QQ').popup({
        popup: $('.qq-qr.popup'),
        on: 'hover',
        position: 'bottom center',
    });
</script>
</html>
