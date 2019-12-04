<!DOCTYPE html>
<html lang="en">
<head>
  <%@ page language="java" import="java.util.*, model.user.User, model.product.Product" pageEncoding="UTF-8"%>
  <meta charset="UTF-8">
  <title>校园小拍</title>
  <link rel="stylesheet" type="text/css" href="res/static/css/main.css">
  <link rel="stylesheet" type="text/css" href="res/layui/css/layui.css">
  <script type="text/javascript" src="res/layui/layui.js"></script>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>
<%!User me;String iconPath;ArrayList<Product> products; %>
<%
	me = (User)request.getAttribute("me");
	products = (ArrayList<Product>)request.getAttribute("products");
%>
<body id="list-cont">
  <div class="site-nav-bg">
    <div class="site-nav w1200">
      <p class="sn-back-home">
        <i class="layui-icon layui-icon-home"></i>
        <a href="index">首页</a>
      </p>
      <div class="sn-quick-menu">
      	<div class="layui-container">
                <div class=" layui-layout-right">
      <%
      		me = (User)request.getAttribute("me");
      		if(me != null){
      			iconPath = "Image/" + me.getIconPath();
      			out.println(String.format("<div class=\"login\"><a href=\"managePage\"><img class='layui-nav-img' src=\"%s\">%s</a></div>",
      					iconPath, me.getName()));
      			out.println(String.format("<div class='login'><a href='#' id='exit'>注销</a></div>"));
      		} else {
      			out.println("<div class=\"login\"><a href=\"loginPage\">登录</a></div>" 
      	      			 + "<div class=\"login\"><a href=\"registerPage\">注册</a></div>");
      		}
      %>
      		</div>
      	</div>
      </div>
    </div>
  </div>
  <script>
  document.getElementById("exit").onclick = function() {
	  document.cookie = "id=;expires=Thu, 01 Jan 1970 00:00:00 GMT;path=/";
	  window.location.href = "index";
  }
  </script>
  <div class="header">
    <div class="headerLayout w1200">
      <div class="headerCon">
        <h1 class="mallLogo">
          <a href="#" title="校园小拍">
            <img src="res/static/img/logo.png">
          </a>
        </h1>
        <div class="mallSearch">
          <form action="commodityPage" method="get" class="layui-form" novalidate>
            <input type="text" name="keyword" required  lay-verify="required"
             autocomplete="off" class="layui-input" placeholder="请输入需要的商品">
            <button class="layui-btn" lay-submit lay-filter="formDemo">
                <i class="layui-icon layui-icon-search"></i>
            </button>
            <input type="hidden" name="" value="">
          </form>
        </div>
      </div>
    </div>
  </div>


  <div class="content">
    <div class="main-nav">
      <div class="inner-cont0">
        <div class="inner-cont1 w1200">
          <div class="inner-cont2">
            <a href="commodityPage?keyword=" >所有商品</a>
            <a href="http://www.sc.sdu.edu.cn/">校园资讯</a>
            <a href="aboutPage">关于我们</a>
          </div>
        </div>
      </div>
    </div>
    <div class="category-con">
      <div class="category-inner-con w1200">

        <div class="category-tab-content">
          <div class="nav-con">

          </div>
        </div>
      </div>
      <div class="category-banner">
        <div class="w1200">
          <img src="res/static/img/banner1.jpg">
        </div>
      </div>
    </div>
    <div class="floors">
      <div class="sk">
        <div class="sk_inner w1200">
          <div class="sk_hd">
            <a href="javascript:;">
              <img src="res/static/img/s_img1.jpg">
            </a>
          </div>
          <div class="sk_bd">
            <div class="layui-carousel" id="test1">
              <div carousel-item>
                <div class="item-box">
					<%
						int size = products.size();
						for(int i = 0;i < size && i < 4;i++) {
							Product product = products.get(0);
							String href = "/detail?id=" + product.getId();
							String iconPath = "ProductImage/" + product.getIconPath();
							if(iconPath != null && !iconPath.isEmpty()) {
								String[] paths = iconPath.split("#");
								iconPath = "ProductImage/" + paths[1];
							} else {
								iconPath = "ProductImage/default.jpg";
							}
							String name = product.getName();
							String price = product.getPrice();
							String html = String.format(
									"<div class='item'>" + 
									"<a href='%s'><img src='%s'></a>" + 
									"<div class='title'>%s</div>" + 
									"<div class='price'>" + 
									"<span>￥%s</span>" + 
									"</div></div>",
									href, iconPath, name, price);
							out.println(html);
							products.remove(0);
						}
					%>
                </div>
                <div class="item-box">
                  	<%
						size = products.size();
						for(int i = 0;i < size && i < 4;i++) {
							Product product = products.get(0);
							String href = "/detail?id=" + product.getId();
							String iconPath = "ProductImage/" + product.getIconPath();
							String name = product.getName();
							String price = product.getPrice();
							String html = String.format(
									"<div class='item'>" + 
									"<a href='%s'><img src='%s'></a>" + 
									"<div class='title'>%s</div>" + 
									"<div class='price'>" + 
									"<span>￥%s</span>" + 
									"</div></div>",
									href, iconPath, name, price);
							out.println(html);
							products.remove(0);
						}
					%>

                </div>
              </div>
            </div>
          </div>
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
        <a href="javascript:;">校园资讯</a>
      </p>
    </div>
  </div>
  <script type="text/javascript">

  layui.config({
	    base: 'res/static/js/util/' //你存放新模块的目录，注意，不是layui的模块目录
	  }).use(['mm','carousel'],function(){
	      var carousel = layui.carousel,
	     mm = layui.mm;
	     var option = {
	        elem: '#test1'
	        ,width: '100%' //设置容器宽度
	        ,arrow: 'always'
	        ,height:'298' 
	        ,indicator:'none'
	      }
	      carousel.render(option);
	      // 模版引擎导入
	     // var ins = carousel.render(option);
	     // var html = demo.innerHTML;
	     // var listCont = document.getElementById('list-cont');
	     // // console.log(layui.router("#/about.html"))
	     //  mm.request({
	     //    url: 'json/index.json',
	     //    success : function(res){
	     //      console.log(res)
	     //      listCont.innerHTML = mm.renderHtml(html,res)
	     //      ins.reload(option);
	     //    },
	     //    error: function(res){
	     //      console.log(res);
	     //    }
	     //  })
	    

	});
  </script>
</body>
</html>