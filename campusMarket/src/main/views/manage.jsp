<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" type="text/css" href="res/static/css/main.css">
    <link rel="stylesheet" type="text/css" href="res/layui/css/layui.css">
    <script type="text/javascript" src="res/layui/layui.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>

<body>
<div class="layui-layout-admin">
    <!--头部-->
    <div class="header" >
        <div class="headerLayout w1200">
            <div class="headerCon">
                <h1 class="mallLogo">
                    <a href="#" title="校园小拍">
                        <img src="res/static/img/logo.png">
                    </a>
                </h1>
            </div>
            <div class="layui-container">
                <div class=" layui-layout-right">
                    <a href=""><img src="res/static/img/banner1.jpg" class="layui-nav-img">hhh</a>
                </div>
            </div>
        </div>
    </div>


    <!--中间主体-->
    <div class="layui-container">
        <div class="layui-tab">
            <ul class="layui-tab-title">
                <li class="layui-this">个人资料</li>
                <li>商品管理</li>
                <li>安全设置</li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    1. 高度默认自适应，也可以随意固宽。
                    <br>2. Tab进行了响应式处理，所以无需担心数量多少。
                </div>
                <div class="layui-tab-item">内容2</div>
                <div class="layui-tab-item">内容3</div>
                <div class="layui-tab-item">内容4</div>
                <div class="layui-tab-item">内容5</div>
            </div>
        </div>
    </div>



</div>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;
        element.on('nav(hbkNavbar)',function(elem){
            /*使用DOM操作获取超链接的自定义data属性值*/
            var options = eval('('+elem.context.children[0].dataset.options+')');
            var url = options.url;
            var title = options.title;
            element.tabAdd('tabs',{
                title : title,
                content : '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>',
                id : '111'
            });
        });
        /*使用下面的方式需要引用jquery*/
        /* $('.layui-nav-child a').click(function () {
             var options = eval('('+$(this).data('options')+')');
             var url = options.url;
             var title = options.title;
             element.tabAdd('tabs',{
                 title : title,
                 content : '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>'
             });
         });*/
    });
</script>
</body>
</html>