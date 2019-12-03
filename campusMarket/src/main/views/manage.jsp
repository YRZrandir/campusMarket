<%@ page 
	language="java" 
	contentType="text/html; charset=utf-8"
	import="java.util.*,java.net.*,model.product.Product,model.user.User"
    pageEncoding="utf-8"%>
<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>我的小拍</title>
    <link rel="stylesheet" type="text/css" href="res/static/css/main.css">
    <link rel="stylesheet" type="text/css" href="res/layui/css/layui.css">
    <script type="text/javascript" src="res/layui/layui.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
    <%!ArrayList<Product> products;User me;String iconPath;%>
    <%
    	products = (ArrayList<Product>)session.getAttribute("products");
    	me = (User)session.getAttribute("me");
    	iconPath = me.getIconPath();
    	if(iconPath == null || iconPath.isEmpty()) {
    		iconPath = "Image/default.jpg";
    	} else {
    		iconPath = "Image/" + iconPath;
    	}
    %>
</head>

<body>
<div class="layui-layout-admin">
    <!--头部-->
    <div class="header" >
        <div class="headerLayout w1200">
            <div class="headerCon">
                <h1 class="mallLogo">
                    <a href="index" title="校园小拍">
                        <img src="res/static/img/logo.png">
                    </a>
                </h1>
            </div>
            <div class="layui-container">
                <div class=" layui-layout-right">
                    <a href=""><img src=<%=iconPath %> class="layui-nav-img"><%=me.getName() %></a>
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
                <li></li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
	                <form id="updateForm" class="layui-form" action="">
		                <div class="layui-form-item">
							<div class="layui-input-block"  style="margin: 10px">
								<label  class="layui-form-label"><%=me.getId() %></label>
								<input placeholder="userid" type="text" readonly name="id"
								 lay-verify="required" autocomplete="off" class="layui-input">
							</div>
		
							<div class="layui-input-block"  style="margin: 10px">
								<label class="layui-form-label"><%=me.getName() %></label>
								<input placeholder="name" type="text" name="name" 
								value="" lay-verify="required" autocomplete="off" class="layui-input">
							</div>
		
							<div class="layui-input-block"  style="margin: 10px">
								<label class="layui-form-label"><%=me.getPassword() %></label>
								<input placeholder="password" type="password" name="password" 
								lay-verify="required" autocomplete="off" class="layui-input">
							</div>
		
							<div class="layui-input-block"  style="margin: 10px">
								<label class="layui-form-label"><%=me.getGender() %></label>
								<div class="layui-form">
									<select name="gender" id="gender" lay-filter="myselect">
										<option value="female">女</option>
										<option value="male">男</option>
									</select>
								</div>
							</div>
		
							<div class="layui-input-block"  style="margin: 10px">
								<label class="layui-form-label"><%=me.getSchool() %></label>
								<input placeholder="school" type="text" name="school" 
								lay-verify="required" autocomplete="off" class="layui-input">
							</div>
		
							<div class="layui-input-block"  style="margin: 10px">
								<label class="layui-form-label" ><%=me.getCampus() %></label>
								<input type="text" placeholder="campus" name="campus" 
								value="" lay-verify="required" autocomplete="off" class="layui-input">
							</div>
		
							<div class="layui-input-block" style="margin: 10px">
								<label class="layui-form-label"><%=me.getTelephone() %></label>
								<input type="text" placeholder="telephone" name="telephone" 
								value="" lay-verify="required" autocomplete="off" class="layui-input">
							</div>
							<div class="image">
								<img src=<%out.print("Image/" + me.getIconPath()); %> style="width:280px">
							</div>
		
							<div class="layui-input-block" style="margin: 10px">
								<label class="layui-form-label">头像</label>
								<input type="file" name="file" lay-verify="required" autocomplete="off" class="layui-input">
							</div>
						</div>
						<div class="layui-form-item"  align="left">
							<button class="layui-btn" style="margin:10px" id="updateButton"
							 value=""  lay-submit="" lay-filter="updateButton" >更新用户信息</button>
						</div>
					</form>
				</div>
                
                <div class="layui-tab-item">
					<%
						for(Product product : products) {
							String url = "detail?id=" + product.getId();
							String iconPath = product.getIconPath();
							if(!iconPath.isEmpty()) {
								iconPath = iconPath.split("#")[1];
								iconPath = "ProductImage/" + iconPath;
							} else {
								iconPath = "ProductImage/default.jpg"; //default img
							}
							
							out.println(
									"<div class=\"item\">"
									
						               + "<div class=\"img\">"
						        			+"<a href=\"" + url + "\"><img src=\"" + iconPath +"\" style=\"width:280px\"></a>"
						      			+"</div>"
						      			
									      +"<div class=\"text\">"
									      
									        +"<p class=\"title\">"+product.getName()+"</p>"
									        
									        +"<p class=\"price\">"
									        
									         +"<span class=\"pri\">￥"+product.getPrice()+"</span>" 
									         
									        +"</p>"
									        
									      +"</div>"
									      
					    			+"</div>");
						}
						
					%>
				</div>

            </div>
        </div>
    </div>

<script>
	layui.use(['form', 'jquery', 'layer'], function() {
		var form = layui.form;
		var $ = layui.jquery;
		form.on('submit(updateButton)', function() {
			$.ajax({
				url:"/campusMarket/updateUser",
				type:"POST",
				data:new FormData(document.getElementById("updateForm")),
				processData:false,
				contentType:false,
				success: function(ret) {
					if(ret != "fail") {
						window.location.href = "managePage";
					} else {
						alert("更新失败");
					}
				},
				error: function(ret) {
					alert("更新失败");
				}
			});
			return false;
		});
	});
</script>

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