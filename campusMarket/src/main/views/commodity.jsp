<%@ page 
	language="java"
	import="java.util.*,java.net.*,model.product.Product,model.user.User"
	contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>校园小拍 商品</title>
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
        <a href="index">首页</a>
      </p>
      <div class="sn-quick-menu">
      <%
      		if(request.getAttribute("me")!=null)
      			out.println("<div class=\"login\"><a href=\"managePage\">我的小拍</a></div>");
      		else
      			out.println("<div class=\"login\"><a href=\"loginPage\">登录</a></div>" 
      			 + "<div class=\"login\"><a href=\"registerPage\">注册</a></div>");
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


  <div class="content content-nav-base commodity-content">
    <div class="main-nav">
      <div class="inner-cont0">
        <div class="inner-cont1 w1200">
          <div class="inner-cont2">
            <a href="commodityPage" class="active">所有商品</a>
            <a href="http://www.sc.sdu.edu.cn/">校园资讯</a>
            <a href="aboutPage">关于我们</a>
          </div>
        </div>
      </div>
    </div>
    <div class="commod-cont-wrap">
      <div class="commod-cont w1200 layui-clear">
        <div class="left-nav">
          <div class="title">所有分类</div>
          <div class="list-box">

            <dl>
             <dd><a href="javascript:;">进口奶粉</a></dd>

            </dl>

          </div>
        </div>
        <div class="right-cont-wrap">
          <div class="right-cont">
            <div class="sort layui-clear">
              <a href="javascript:;" event = 'price'>价格</a>
              <a href="javascript:;" event = 'newprod'>新品</a>
            </div>

            <div class="cont-list layui-clear" id="list-cont">
<%! int pn=0;%>
<%
	
	ArrayList<Product> p = (ArrayList<Product>)request.getAttribute("product");
	pn=p.size();
	for(int i=0;i<p.size();i++)
	{
		String id = p.get(i).getId();
		String name = p.get(i).getName();
		String price = p.get(i).getPrice();
		String iconPath = p.get(i).getIconPath();
		if(!iconPath.isEmpty()) {
			iconPath = iconPath.split("#")[1];
			iconPath = "ProductImage/" + iconPath;
		} else {
			iconPath = "res/static/img/paging_img1.jpg"; //default img
		}
		String url = "detail?id=" + id;
		out.println(
				"<div class=\"item\">"
				
	               + "<div class=\"img\">"
	        			+"<a href=\"" + url + "\"><img src=\"" + iconPath +"\" style=\"width:280px\"></a>"
	      			+"</div>"
	      			
				      +"<div class=\"text\">"
				      
				        +"<p class=\"title\">"+p.get(i).getName()+"</p>"
				        
				        +"<p class=\"price\">"
				        
				         +"<span class=\"pri\">￥"+p.get(i).getPrice()+"</span>" 
				         
				        +"</p>"
				        
				      +"</div>"
				      
    			+"</div>");
	}

%>
            </div>
            <!-- 模版引擎导入 -->
            <!-- <script type="text/html" id="demo">
              {{# layui.each(d.menu.milk.content,function(index,item){}}    
                <div class="item">
                  <div class="img">
                    <a href="javascript:;"><img src="{{item.img}}"></a>
                  </div>
                  <div class="text">
                    <p class="title"></p>
                    <p class="price">
                      <span class="pri">{{item.pri}}</span>
                      <span class="nub">{{item.nub}}</span>
                    </p>
                  </div>
                </div>
              {{# }); }}
            </script> -->
            <div id="demo0" style="text-align: center;"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
<script>

  layui.config({
    base: 'res/static/js/util/' //你存放新模块的目录，注意，不是layui的模块目录
  }).use(['mm','laypage','jquery'],function(){
      var laypage = layui.laypage,$ = layui.$,
     mm = layui.mm;
       laypage.render({
        elem: 'demo0'
        ,count: <%=pn%> //数据总数
      });


    // 模版引擎导入
    //  var html = demo.innerHTML;
    //  var listCont = document.getElementById('list-cont');
    //  // console.log(layui.router("#/about.html"))
    // mm.request({
    //     url: 'json/commodity.json',
    //     success : function(res){
    //       console.log(res)
    //       listCont.innerHTML = mm.renderHtml(html,res)
    //     },
    //     error: function(res){
    //       console.log(res);
    //     }
    //   })

    $('.sort a').on('click',function(){
      $(this).addClass('active').siblings().removeClass('active');
    })
    $('.list-box dt').on('click',function(){
      if($(this).attr('off')){
        $(this).removeClass('active').siblings('dd').show()
        $(this).attr('off','')
      }else{
        $(this).addClass('active').siblings('dd').hide()
        $(this).attr('off',true)
      }
    })

});
</script>


</body>
</html>