<!DOCTYPE html>
<html>
<head>
<%@ page 
language="java" 
pageEncoding="UTF-8"
import="java.util.*,java.net.*,model.product.Product,model.user.User"
%>
<meta charset="UTF-8">
<title>上架商品</title>
<script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
<%!User me%>
<%
	me = session.getAttribute("me");
	if(me != null)
		out.println("<div class=\"login\"><a href=\"managePage\">我的小拍</a></div>");
	else {
		out.println("<script>window.location.href=\"index\" </script>");
	}
%>
<div>
	<form id="addProductForm">
		name:<input type="text" name="name">
		price:<input type="text" name="price">
		description:<input type="text" name="description">
		directory:<input type="text" name="directory">
		image1:<input type="file" name="file">
		image2:<input type="file" name="file">
		image3:<input type="file" name="file">
		<input type="button" id="addProductButton" value="AddProduct"> 
	</form>
</div>
<script>
$("#addProductButton").click(function() {
	var form = new FormData(document.getElementById("addProductForm"));
	var userId = <%=me.getId()%>; <!--get userId -->
	var time = new Date().toUTCString(); <!--get current time -->
	console.log(time);
	form.append("userId", userId);
	form.append("time", time);
	$.ajax({
		url:"/campusMarket/addProduct",
		type:"post",
		data:form,
		processData:false,
		contentType:false,
		success: function(ret) {
			console.log("ok");
		},
		error: function(ret) {
			console.log("bad");
		}
	})
})
</script>
</body>
</html>