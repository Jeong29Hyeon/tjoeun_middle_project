<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-05-03
  Time: 오전 11:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<script>
  $(document).ready(function (){
    $('#test').on('click',function (){
      $.ajax({
        type:'post',
        url:'https://www.megabox.co.kr/on/oh/ohc/Brch/schedulePage.do',
        data:{
          "masterType": "brch",
          "detailType": "area",
          "brchNo": "1372",
          "firstAt": "Y",
          "brchNo1": "1372",
          "playDe": "20230503"
        },
        success:function (result){
          const str = JSON.stringify(result);
          const obj = JSON.parse(str);
          console.log(obj);
          const movieList = obj.megaMap.movieFormList;
          console.log(movieList);
          $.each(movieList,function (key,value){
            if(value.movieNm.trim() ==="가디언즈 오브 갤럭시: Volume 3".trim()){
              console.log(value.playStartTime);
              console.log(value.playEndTime);
              console.log(value.theabExpoNm);
            }
          })
        }
      });
    });
  });
</script>
</body>
</html>
