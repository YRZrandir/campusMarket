<%@ page language="java" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>校园小拍 登录</title>
  <link rel="stylesheet" type="text/css" href="res/static/css/main.css">
  <link rel="stylesheet" type="text/css" href="res/layui/css/layui.css">
  <script type="text/javascript" src="res/layui/layui.js"></script>
  <script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>
<body>

  <div class="site-nav-bg">
    <div class="site-nav w1200">
      <p class="sn-back-home">
        <i class="layui-icon layui-icon-home"></i>
        <a href="#">首页</a>
      </p>
      <div class="sn-quick-menu">
        <div class="login"><a href="loginPage">登录</a></div>
        <div class="login"><a href="registerPage">注册</a></div>
      </div>
    </div>
  </div>



  <div class="header">
    <div class="headerLayout w1200">
      <div class="headerCon">
        <h1 class="mallLogo">
          <a href="#" title="校园小拍">
            <img src="res/static/img/logo.png">
          </a>
        </h1>
      </div>
    </div>
  </div>


  <div class="content content-nav-base  login-content">
    <div class="main-nav">
      <div class="inner-cont0">
        <div class="inner-cont1 w1200">
          <div class="inner-cont2">
            <a href="commodityPage" >所有商品</a>
            <a href="http://www.sc.sdu.edu.cn/">校园资讯</a>
            <a href="aboutPage">关于我们</a>
          </div>
        </div>
      </div>
    </div>
    <div class="login-bg">
      <div class="login-cont w1200">
        <div class="form-box">
          <form class="layui-form" id="loginForm" method="post">
            <legend>登录</legend>
            <div class="layui-form-item">
              <div class="layui-inline iphone">
                <div class="layui-input-inline">
                  <i class="layui-icon layui-icon-cellphone iphone-icon"></i>
                  <input type="text" name="id" id="id" lay-verify="required|number" 
                  placeholder="请输入ID" autocomplete="off" class="layui-input">
                </div>
              </div>

              <div class="layui-inline iphone">
                <div class="layui-input-inline">
                  <i class="layui-icon layui-icon-password iphone-icon"></i>
                  <input type="password" name="password" id="password" lay-verify="required" 
                  placeholder="请输入密码" autocomplete="off" class="layui-input">
                </div>
              </div>

            </div>
            <div class="layui-form-item login-btn">
              <div class="layui-input-block">
                <button id="loginButton" class="layui-btn" lay-submit="" lay-filter="loginButton">登录</button>
              </div>
            </div>
            <script>
            	layui.use(['form', 'jquery', 'layer'], function() {
            		var form = layui.form;
            		var $ = layui.jquery;
                	form.on('submit(loginButton)', function() {
                		$.ajax({
                			url:"/campusMarket/login",
                			type:"POST",
                			data:new FormData(document.getElementById("loginForm")),
                			processData:false,
                			contentType:false,
                			success: function(ret) {
                				window.location.href = "index";
                			},
                			error: function(ret) {
                				alert("用户名或密码错误");
                			}
                		});
                		return false;
                	});
            	})
            </script>
          </form>
        </div>
      </div>
    </div>
  </div>

  <div class="footer">
    <div class="ng-promise-box">
      <div class="ng-promise w1200">

      </div>
    </div>
    <div class="mod_help w1200">                                     
      <p>
        <a href="javascript:;">关于我们</a>
        <span>|</span>
        <a href="javascript:;">帮助中心</a>
        <span>|</span>
        <a href="javascript:;">售后服务</a>
        <span>|</span>
        <a href="javascript:;">校园资讯</a>
        <span>|</span>
        <a href="javascript:;">关于货源</a>
      </p>
      <p class="coty">校园小拍版权所有 &copy; 2012-2020</p>
    </div>
  </div>
  <script type="text/javascript">
   layui.config({
      base: 'res/static/js/util' //你存放新模块的目录，注意，不是layui的模块目录
    }).use(['jquery','form','layer'],function(){
          var $ = layui.$,layer=layui.layer,form = layui.form;
    })
  </script>

</body>
</html>