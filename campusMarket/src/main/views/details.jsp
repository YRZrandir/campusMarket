<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
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

  <div class="site-nav-bg">
    <div class="site-nav w1200">
      <p class="sn-back-home">
        <i class="layui-icon layui-icon-home"></i>
        <a href="#">首页</a>
      </p>
      <div class="sn-quick-menu">
      <%
      		if(session.getAttribute("id")!=null)
      			out.println("<div class=\"login\"><a href=\"managePage\">我的小拍</a></div>");
      		else
      			out.println("        <div class=\"login\"><a href=\"loginPage\">登录</a></div><div class=\"login\"><a href=\"registerPage\">注册</a></div>");
      %>
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
        <div class="mallSearch">
          <form action="" class="layui-form" novalidate>
            <input type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input" placeholder="请输入需要的商品">
            <button class="layui-btn" lay-submit lay-filter="formDemo">
                <i class="layui-icon layui-icon-search"></i>
            </button>
            <input type="hidden" name="" value="">
          </form>
        </div>
      </div>
    </div>
  </div>


  <div class="content content-nav-base datails-content">
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
    <div class="data-cont-wrap w1200">
      <div class="crumb">
        <a href="javascript:;">首页</a>
        <span>></span>
        <a href="javascript:;">所有商品</a>
        <span>></span>
        <a href="javascript:;">产品详情</a>
      </div>
      <div class="product-intro layui-clear">
        <div class="preview-wrap">
          <a href="javascript:;"><img src="res/static/img/details_img1.jpg"></a>
        </div>
        <div class="itemInfo-wrap">
          <div class="itemInfo">
            <div class="title">
              <h4>男女宝宝秋冬装套装0一1岁婴儿衣服潮加厚连体衣保暖冬季外出抱衣 </h4>
            </div>

            <div class="summary">
              <p class="reference"><span>参考价</span> <del>￥280.00</del></p>
              <p class="activity"><span>卖家价格</span><strong class="price"><i>￥</i>99.00</strong></p>
            </div>

            <div class="title">
              <h6><textarea class="layui-textarea" readonly>这里放描述</textarea></h6>
            </div>

            <div class="choose-btns">
              <button class="layui-btn layui-btn-primary purchase-btn">联系卖家</button>
            </div>
          </div>
        </div>
      </div>
      <div class="layui-clear">
          <h2>图片详情</h2>
          <div class="item">
            <img src="res/static/img/details_imgbig.jpg">
          </div>
        </div>
      </div>
    </div>
  </div>
<script type="text/javascript">
  layui.config({
    base: 'res/static/js/util/' //你存放新模块的目录，注意，不是layui的模块目录
  }).use(['mm','jquery'],function(){
      var mm = layui.mm,$ = layui.$;
      var cur = $('.number-cont input').val();
      $('.number-cont .btn').on('click',function(){
        if($(this).hasClass('add')){
          cur++;
         
        }else{
          if(cur > 1){
            cur--;
          }  
        }
        $('.number-cont input').val(cur)
      })
      
  });
</script>


</body>
</html>