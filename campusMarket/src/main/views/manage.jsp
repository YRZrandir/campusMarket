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
    	products = (ArrayList<Product>)request.getAttribute("products");
    	me = (User)request.getAttribute("me");
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
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
	                <form id="updateForm" class="layui-form" action="">
		                <div class="layui-form-item">
							<div class="layui-input-block"  style="margin: 10px">
								<label  class="layui-form-label">账号</label>
								<input placeholder="userid" type="text" readonly name="id"
								 lay-verify="required" autocomplete="off" class="layui-input" value=<%=me.getId() %>>
							</div>
		
							<div class="layui-input-block"  style="margin: 10px">
								<label class="layui-form-label">姓名</label>
								<input placeholder="name" type="text" name="name" 
								lay-verify="required" autocomplete="off" class="layui-input" 
								value=<%=String.format("\"%s\"", me.getName()) %>>
							</div>
		
							<div class="layui-input-block"  style="margin: 10px">
								<label class="layui-form-label">密码</label>
								<input placeholder="password" type="password" name="password" 
								lay-verify="required" autocomplete="off" class="layui-input" value=<%=me.getPassword() %>>
							</div>
		
							<div class="layui-input-block"  style="margin: 10px">
								<label class="layui-form-label">性别</label>
								<div class="layui-form">
									<select name="gender" id="gender" lay-filter="myselect">
										<%
											String gender = me.getGender();
											if(gender.equals("male")) {
												out.println("<option value=male>男</option>");
												out.println("<option value=female>女</option>");
											} else {
												out.println("<option value=female>女</option>");
												out.println("<option value=male>男</option>");
											}
										%>
									</select>
								</div>
							</div>
		
							<div class="layui-input-block"  style="margin: 10px">
								<label class="layui-form-label">学校</label>
								<input placeholder="school" type="text" name="school" 
								lay-verify="required" autocomplete="off" class="layui-input" 
								value=<%=String.format("\"%s\"", me.getSchool()) %>>
							</div>
		
							<div class="layui-input-block"  style="margin: 10px">
								<label class="layui-form-label" >校区</label>
								<input type="text" placeholder="campus" name="campus" 
								lay-verify="required" autocomplete="off" class="layui-input" 
								value=<%=String.format("\"%s\"", me.getCampus()) %>>
							</div>
		
							<div class="layui-input-block" style="margin: 10px">
								<label class="layui-form-label">电话</label>
								<input type="text" placeholder="telephone" name="telephone" 
								lay-verify="required" autocomplete="off" class="layui-input" 
								value=<%=me.getTelephone() %>>
							</div>
							<div class="image" align="left">
								<img src=<%=String.format("\"Image/%s\"", me.getIconPath()) %> style="width:400px">
							</div>
		
							<div class="layui-input-block" style="margin: 10px">
								<label class="layui-form-label">头像</label>
								<input type="file" name="file" autocomplete="off" class="layui-input">
							</div>
						</div>
						<div class="layui-form-item"  align="left">
							<button class="layui-btn" style="margin:10px" id="updateButton"
							 value=""  lay-submit="" lay-filter="updateButton" >更新用户信息</button>
						</div>
					</form>
				</div>
                
                <div class="layui-tab-item">
                	 <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md3">
                                <ul class="layui-nav layui-nav-tree" lay-filter="test">
                                    <li class="layui-nav-item layui-nav-itemed">
                                        <a href="manage.html">我的商品</a>
                                    </li>
                                    <li class="layui-nav-item">
                                        <a href="addProductPage">商品上新</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="layui-col-md9">
                                <div class="content content-nav-base commodity-content">

                                    <div class="commod-cont-wrap">
                                        <div class="commod-cont w1200 layui-clear">
                                            <div class="cont-wrap">
                                                <div class="right-cont" >
                                                    <div class="cont-list layui-clear" id="list-cont">
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
                                                    <div id="demo0" style="text-align: center;"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
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
						alert("更新成功！");
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