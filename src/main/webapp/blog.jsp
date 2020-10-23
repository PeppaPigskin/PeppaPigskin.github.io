<%@ page import="java.awt.*" %><%--
  Created by IntelliJ IDEA.
  User: WuChen
  Date: 2020/10/09
  Time: 14:17
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

    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/js/jquery-3.4.1.min.js"></script>

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


    <%--引入ueditor相关资源--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/editor/css/editormd.css"/>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/editor/editormd.min.js"></script>

    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/editor/lib/marked.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/editor/lib/prettify.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/editor/lib/raphael.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/editor/lib/underscore.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/editor/lib/sequence-diagram.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/editor/lib/flowchart.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/editor/lib/jquery.flowchart.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/editor/editormd.js"></script>


    <script type="text/javascript">
        $(function () {
            $(function () {
                editormd.markdownToHTML("editorView", {
                    htmlDecode: "style,script,iframe",  // you can filter tags decode
                    emoji: true,
                    taskList: true,
                    tex: true,  // 默认不解析
                    flowChart: true,  // 默认不解析
                    sequenceDiagram: true,  // 默认不解析
                });
            });
            $("#archivesMenu").addClass("active");
        });

        //显示所有评论
        function showAllComment() {
            $(".otherComment").show();
            $("#showAllButton").hide();
        }

        //发表评论
        function publishComment() {

            var content = $("#commentContent").val();
            var imageCode = $("#imageCode").val();
            if (content == null || content == '') {
                alert("系统提示, 请输入评论内容...");
                return;
            }
            if (imageCode == null || imageCode == '') {
                alert("系统提示, 请输入验证码...");
                return;
            }
            $.post(
                "${pageContext.request.contextPath}/comment/save.do",
                {'content': content, 'imageCode': imageCode, 'blog.id': '${blog.id}'},
                function (result) {
                    if (result.success) {
                        alert("评论已提交，需等待审核通过后显示！");
                        $("#imageCode").val("");
                        $("#commentContent").val("");
                        loadImage();
                        window.location.reload();
                    } else {
                        alert(result.errInfo);
                        $("#imageCode").val("");
                        loadImage();
                    }
                },
                "json"
            );
        }

        //重新加载验证码
        function loadImage() {
            document.getElementById("randImage").src = "${pageContext.request.contextPath}/image.jsp?" + Math.random();
        }
    </script>
</head>
<body>
<!--设置中间内容部分-->
<div id="content_main" class="m-padded-tb-big m-container-small animate__fadeIn">
    <div class="ui container">

        <!--头部区域-->
        <div class="ui top attached segment">
            <div class="ui horizontal link list">
                <!--设置图标-->
                <div class="item">
                    <img src="https://picsum.photos/id/1025/100/100" alt=""
                         class="ui avatar image">
                    <div class="content">
                        <a class="header">武晨晨</a>
                    </div>
                </div>

                <!--设置发布日期-->
                <div class="item">
                    <i class="calendar icon"></i>
                    <fmt:formatDate value="${blog.releaseDate}" pattern="yyyy年MM月dd日"></fmt:formatDate>
                </div>

                <!--设置浏览次数-->
                <div class="item">
                    <i class="eye icon"></i>${blog.clickHit}
                </div>

                <%--TODO:分享功能-使用第三方插件>--%>
                <div style="padding-left: 500px;padding-top: 10px;padding-bottom: 20px;float: right">
                    <div class="bshare-custom">
                        <a title="分享到QQ空间" class="bshare-qzone"></a>
                        <a title="分享到新浪微博" class="bshare-sinaminiblog"></a>
                        <a title="更多平台" class="bshare-more bshare-more-icon"></a>
                        <script type="text/javascript" charset="UTF-8"
                                src="http://static.bshare.cn/b/buttonLite.js#stytle=-1&amp;uuid=$amp;pophcol=1$amp;lang=zh"></script>
                        <script type="text/javascript" charset="UTF-8"
                                src="http://static.bshare.cn/b/bshareC0.js"></script>
                    </div>
                </div>

            </div>
        </div>

        <!--图片区-->
        <%--<div class="ui attached segment">
            <img src="${pageContext.request.contextPath}/static/blogImage/${blog.blogImage}" width="800" height="400"
                 alt="" class="ui fluid image rounded">
        </div>--%>

        <!--内容区-->
        <div class="ui attached padded segment">
            <div class="ui right aligned basic segment">
                <div class="ui label basic yellow">${blog.blogType.typeName}</div>
            </div>
            <h2 class="ui center aligned header">${blog.title}</h2>
            <br>
            <!--js-toc-content:设置生成目录的文章区-->
            <div id="editorView"
                 class="js-toc-content m-padded-lr-responsive m-padded-tb-large  typo typo-selection">
                <textarea style="display:none;">${blog.content}</textarea>
            </div>

            <!--标签-->
            <div class="m-padded-lr-responsive">
                <c:forEach items="${blogKeyWords}" var="keyWord">
                    <c:if test="${!''.equals(keyWord.trim())}">
                        <a>
                            <div class="ui basic teal left pointing label"><strong>${keyWord}</strong></div>
                        </a>
                    </c:if>
                </c:forEach>
            </div>

            <!--赞赏-->
            <div class="ui segment basic center aligned">
                <button id="payButton" class="ui basic yellow button circular">赞赏</button>
            </div>

            <!--点击赞赏要显示的内容-->
            <div class="ui payQR flowing popup transition hidden">
                <div class="ui orange basic label">
                    <div class="ui images" style="font-size: inherit !important;">
                        <div class="image">
                            <img src="${pageContext.request.contextPath}/static/images/wxsq.png" alt=""
                                 class="ui rounded bordered image"
                                 style="width: 120px">
                            <div>微信</div>
                        </div>
                        <%--<div class="image">
                            <img src="${pageContext.request.contextPath}/static/images/zfbsq.jpg" alt=""
                                 class="ui rounded bordered  image"
                                 style="width: 120px">
                            <div>支付宝</div>
                        </div>--%>
                    </div>
                </div>
            </div>
        </div>

        <!--博客信息-->
        <div class="ui attached positive message">
            <div class="ui middle aligned grid">
                <div class="eleven wide column">
                    <ul class="list">
                        <li>作者：${blog.blogger.nickName}</li>
                        <li>发表时间：<fmt:formatDate value="${blog.releaseDate}"
                                                 pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></li>
                        <li>版权声明：自由转载-非商业用途-非衍生-保持署名</li>
                        <li>公众号转载：请在文末添加作者公众号二维码</li>
                    </ul>
                </div>
                <div class="five wide column">
                    <img src="${pageContext.request.contextPath}/static/images/gongzhonghao.png" title="博主公众号"
                         alt="博主公众号"
                         class="ui right floated rounded bordered image"
                         style="width: 110px">
                </div>
            </div>
        </div>
        <div class="ui footer attached segment">
            ${pageCode}
        </div>
        <!-- 留言区域-->
        <div id="comment-container" class="ui bottom attached segment">
            <!--使用该前端框架的评论组件-->
            <!--留言区域列表-->
            <div class="ui teal segment">
                <div class="ui comments">
                    <h3 class="ui dividing header">评论区（${commentList.size()}）</h3>
                    <c:choose>
                        <c:when test="${commentList.size()==0}">
                            <div class="content" style="text-align: center">暂无评论</div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${commentList}" var="comment" varStatus="status">
                                <c:choose>
                                    <c:when test="${status.index<5}">
                                        <div class="comment">
                                                <%--<a class="avatar">
                                                    <img src="https://picsum.photos/id/1025/10/10">
                                                </a>--%>
                                            <div class="content">
                                                <span>${status.index+1}楼：</span>
                                                <a class="author">${comment.userIp}</a>
                                                <div class="metadata">
                                                    <span class="date">
                                                        <fmt:formatDate value="${comment.commentDate}"
                                                                        pattern="yyyy年MM月dd日 HH:mm:ss"></fmt:formatDate>
                                                    </span>
                                                        <%-- <div class="actions" style="float: right">
                                                             <a class="reply">回复</a>
                                                         </div>--%>
                                                </div>
                                                <div class="text"
                                                     style="padding-top: 10px;padding-bottom: 10px;padding-left: 50px">
                                                        ${comment.content}
                                                </div>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="comment otherComment" style="display: none">
                                                <%--<a class="avatar">
                                                    <img src="https://picsum.photos/id/1025/10/10">
                                                </a>--%>
                                            <div class="content">
                                                <span>${status.index+1}楼：</span>
                                                <a class="author">${comment.userIp}</a>
                                                <div class="metadata">
                                                    <span class="date">
                                                        <fmt:formatDate value="${comment.commentDate}"
                                                                        pattern="yyyy年MM月dd日 HH:mm:ss"></fmt:formatDate>
                                                    </span>
                                                        <%--<div class="actions" style="float: right">
                                                            <a class="reply">回复</a>
                                                        </div>--%>
                                                </div>
                                                <div class="text"
                                                     style="padding-top: 10px;padding-bottom: 10px;padding-left: 50px">
                                                        ${comment.content}
                                                </div>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    <c:if test="${commentList.size()>5}">
                        <a id="showAllButton" href="javascript:showAllComment()" style="padding-bottom: 20px">显示所有评论</a>
                    </c:if>
                    <%--
                    <div class="comment">
                         <a class="avatar">
                             <img src="https://picsum.photos/id/1025/10/10">
                         </a>
                        <div class="content">
                            <a class="author">Matt</a>
                            <div class="metadata">
                                <span class="date">Today at 5:42PM</span>
                            </div>
                            <div class="text">
                                How artistic!
                            </div>
                            <div class="actions">
                                <a class="reply">回复</a>
                            </div>
                        </div>
                    </div>
                    <div class="comment">
                          <a class="avatar">
                              <img src="https://picsum.photos/id/1025/10/10">
                          </a>
                        <div class="content">
                            <a class="author">Elliot Fu</a>
                            <div class="metadata">
                                <span class="date">Yesterday at 12:30AM</span>
                            </div>
                            <div class="text">
                                <p>This has been very useful for my research. Thanks as well!</p>
                            </div>
                            <div class="actions">
                                <a class="reply">回复</a>
                            </div>
                        </div>
                        <div class="comments">
                            <div class="comment">
                                <a class="avatar">
                                    <img src="https://picsum.photos/id/1025/10/10">
                                </a>
                                <div class="content">
                                    <a class="author">Jenny Hess</a>
                                    <div class="metadata">
                                        <span class="date">Just now</span>
                                    </div>
                                    <div class="text">
                                        Elliot you are always so right :)
                                    </div>
                                    <div class="actions">
                                        <a class="reply">回复</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="comment">
                        <a class="avatar">
                            <img src="https://picsum.photos/id/1025/10/10">
                        </a>
                        <div class="content">
                            <a class="author">Joe Henderson</a>
                            <div class="metadata">
                                <span class="date">5 days ago</span>
                            </div>
                            <div class="text">
                                Dude, this is awesome. Thanks so much
                            </div>
                            <div class="actions">
                                <a class="reply">回复</a>
                            </div>
                        </div>
                    </div>
                --%>
                </div>
            </div>
            <!--发表留言表单区-->
            <div class="ui form">
                <!--评论输入框-->
                <div class="field">
                    <textarea id="commentContent" name="commentContent" placeholder="输入您的意见或建议(200字以内)..." id=""
                              cols="30"
                              rows="10" maxlength="200"></textarea>
                </div>
                <!--评论者信息输入框-->
                <div class="fields">
                    <%-- <div class="field m-mobile-wide m-margin-bottom-small">
                         <div class="ui left icon input">
                             <i class="user icon"></i>
                             <input type="text" id="commentUserName" name="commentUserName" placeholder="姓名">
                         </div>
                     </div>
                     <div class="field m-mobile-wide m-margin-bottom-small">
                         <div class="ui left icon input">
                             <i class="envelope outline icon"></i>
                             <input type="text" id="commentUserEmail" name="commentUserEmail" placeholder="邮箱">
                         </div>
                     </div>
                     <div class="field m-mobile-wide m-margin-bottom-small">
                         <div class="ui left icon input">
                             <i class="phone icon"></i>
                             <input type="text" id="commentUserPhone" name="commentUserPhone" placeholder="电话">
                         </div>
                     </div>--%>
                    <div class="field m-mobile-wide m-margin-bottom-small">
                        <div class="ui left icon input" style="padding-right: 50px">

                            <input type="text" id="imageCode" name="imageCode" placeholder="请输入验证码"
                                   onkeydown="if(event.keyCode==13) publishComment()">
                            &nbsp;&nbsp;
                            <img src="${pageContext.request.contextPath}/image.jsp" name="randImage" id="randImage"
                                 title="换一张试试" onclick="javascript:loadImage()" border="1px"
                                 align="absmiddle">
                        </div>
                    </div>
                    <div class="field m-margin-bottom-small m-mobile-wide" style="float: right">
                        <button class="ui m-mobile-wide teal button" onclick="javascript:publishComment()">
                            <i class="edit icon"></i>
                            发表评论
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!--设置小工具条-----style="display: none":设置其默认隐藏-->
<div id="toolbar" class="m-fixed m-right-bottom m-padded-large" style="display: none">
    <div class="ui vertical icon buttons">
        <button id="mlButton" type="button" class="ui teal button">目录</button>
        <a href="#comment-container" type="button" class="ui teal button">留言</a>
        <button id="text_content_ma" class="ui icon button"><i class="weixin icon"></i></button>
        <div id="toTop_button" class="ui icon button"><i class="chevron up icon"></i></div>
    </div>


    <!--目录显示的内容-->
    <div id="ml-content" class="ui ml-content flowing popup transition hidden" style="width: 250px">
        <!--设置目录生成的位置-->
        <ol class="js-toc"></ol>
    </div>

    <!--文章对应微信二维码-->
    <div id="qr_code_img" class="ui textContent flowing popup transition hidden m-padded"
         style="width: 120px!important;">
    </div>

</div>
<!--自定义js-->
<script>
    /*初始化目录生成*/
    tocbot.init({
        // Where to render the table of contents.
        tocSelector: '.js-toc',
        // Where to grab the headings to build the table of contents.
        contentSelector: '.js-toc-content',
        // Which headings to grab inside of the contentSelector element.
        headingSelector: 'h1, h2, h3',
        // For headings inside relative or absolute positioned containers within content.
        hasInnerContainers: true,
    });
    /*设置菜单按钮的显示与隐藏*/
    $('#show_hide_icon').click(function () {
        $('.menu-item').toggleClass('m-mobile-hide');
    });
    /*设置赞赏按钮相关触发动作*/
    $('#payButton').popup({
        popup: $('.payQR.popup'),
        on: 'hover',
        position: 'bottom center',
    });
    /*设置目录的生成按钮*/
    $('#mlButton').popup({
        popup: $('.ml-content.popup'),
        on: 'click',
        position: 'left center',
    });
    /*设置鼠标离开时隐藏目录*/
    /* $("#mlButton").mouseout(function () {
         $("#ml-content").toggleClass('hidden');
     });*/
    /*设置文章对应二维码弹出js*/
    $('#text_content_ma').popup({
        popup: $('.textContent.popup'),
        on: 'hover',
        position: 'left center',
    });
    /*生成二维码js*/
    var qrcode = new QRCode("qr_code_img", {
        text: window.location.href,
        width: 110,
        height: 110,
        colorDark: "#CE93D8",
        colorLight: "#ffffff",
        position: 'left center',
        correctLevel: QRCode.CorrectLevel.H
    });
    /*平滑滚动js*/
    $('#toTop_button').click(function () {
        /*点击时从底部滚动到顶部*/
        /*参数1控制位置，参数2控制间隔时间*/
        $(window).scrollTo(0, 1000);
    });
    /*滚动检测js*/
    var waypoint = new Waypoint({
        /*指定检测元素通过元素id获取*/
        element: document.getElementById('content_main'),
        handler: function (direction) {
            if (direction === 'down') {
                $('#toolbar').show(500);
            } else {
                $('#toolbar').hide(500);
            }
        }
    })

</script>
</body>
</html>