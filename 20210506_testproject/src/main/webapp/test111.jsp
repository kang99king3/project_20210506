<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>






   .rating .rate_radio + label {
       position: relative;
       display: inline-block;
       margin-left: -4px;
       z-index: 10;
       width: 60px;
       height: 60px;
       background-image: url('resources/img/starrate.png');
       background-repeat: no-repeat;
       background-size: 60px 60px;
       cursor: pointer;
       background-color: #f0f0f0;
   }
   .rating .rate_radio:checked + label {
       background-color: red;
   }
   
   
   /* 레이아웃 외곽 너비 400px 제한*/
   .wrap{
       max-width: 480px;
       margin: 0 auto; /* 화면 가운데로 */
       background-color: #fff;
       height: 100%;
       padding: 20px;
       box-sizing: border-box;
   
   }
   .reviewform textarea{
       width: 100%;
       padding: 10px;
       box-sizing: border-box;
   }
   .rating .rate_radio {
       position: relative;
       display: inline-block;
       z-index: 0;
       opacity: 1;
       width: 60px;
       height: 60px;
       background-color: red;
       cursor: pointer;
       vertical-align: top;
/*        display: none; */
   }
   .rating .rate_radio + label {
       position: relative;
       display: inline-block;
       margin-left: -4px;
       z-index: 10;
       width: 60px;
       height: 60px;
       background-image: url('resources/img/starrate.png');
       background-repeat: no-repeat;
       background-size: 60px 60px;
       cursor: pointer;
       background-color: #f0f0f0;
   }
   .rating .rate_radio:checked + label {
       background-color: red;
   }
   
   .warning_msg {
       display: none;
       position: relative;
       text-align: center;
       background: #ffffff;
       line-height: 26px;
       width: 100%;
       color: red;
       padding: 10px;
       box-sizing: border-box;
       border: 1px solid #e0e0e0;
   }
   
   
   #searching input {
    width: 50px;
    height: 50px;
    padding: 20px;
    box-sizing: border-box;
    border-radius: 25px;
    border: 0;
    background: #eee;
    font-size: 17px;
    transition: all 0.5s;
}

#searching input:hover {
    background: #ccc;
}

#searching input:focus {
    outline: none;
}



</style>

<body>


<div class="star-box">
  <span class="star star_left"></span>
  <span class="star star_right"></span>

  <span class="star star_left"></span>
  <span class="star star_right"></span>

  <span class="star star_left"></span>
  <span class="star star_right"></span>

 <span class="star star_left"></span>
 <span class="star star_right"></span>

 <span class="star star_left"></span>
 <span class="star star_right"></span>
</div>
   
   
   <div class="wrap">
    <h1>리뷰 쓰기</h1>
    <form method="get" action="insertrboard.do" onsubmit="return test()" >
    <table>
    
       <tr>
         <th>제목</th>
         <td><input type="text" name="rtitle" required="required"
         placeholder="제목을 입력하세요" onfocus="this.placeholder=''" 
         onblur="this.placeholder='제목을 입력하세요'" name="search"></td><br><br>
      </tr>
      <tr>
         <th>내용</th>
         <td><textarea rows="5" name="rcontent" class="review_textarea" placeholder="10자 이상  100자 이하" onfocus="this.placeholder=''"    onblur="this.placeholder='10자 이상 100자 이하'"></textarea></td>
      </tr><br><br>
       <tr>
         <th>사진 첨부하기</th>
         <td><input type="file" name="imgname"></td>
      </tr><br><br>
   </table>

        <input type="hidden" name="rate" id="rate" value="5"/>
        <div class="review_rating">
            <div class="rating">
                <!-- 해당 별점을 클릭하면 해당 별과 그 왼쪽의 모든 별의 체크박스에 checked 적용 -->
                <input type="checkbox" name="starrank" id="rating1" value="1" class="rate_radio" title="1점">
                <label for="rating1"></label>
                <input type="checkbox" name="starrank" id="rating2" value="2" class="rate_radio" title="2점">
                <label for="rating2"></label>
                <input type="checkbox" name="starrank" id="rating3" value="3" class="rate_radio" title="3점" >
                <label for="rating3"></label>
                <input type="checkbox" name="starrank" id="rating4" value="4" class="rate_radio" title="4점">
                <label for="rating4"></label>
                <input type="checkbox" name="starrank" id="rating5" value="5" class="rate_radio" title="5점">
                <label for="rating5"></label>
            </div>
        </div>
        <br><br>
        <div class="cmd">
            <input type="submit" value="등록">
            <input type="button" value="뒤로 가기" onclick="history.back(-1);">
        </div>
        
    </form>
   </div>
   
   

   
<script>
//별점 마킹 모듈 프로토타입으로 생성
function Rating(){
Rating.prototype.rate = 0;
Rating.prototype.setRate = function(newrate){
    //별점 마킹 - 클릭한 별 이하 모든 별 체크 처리
    this.rate = newrate;
    let items = document.querySelectorAll('.rate_radio');
    items.forEach(function(item, idx){
        if(idx < newrate){
            item.checked = true;
        }else{
            item.checked = false;
        }
    });   
}}


let rating = new Rating();//별점 인스턴스 생성

document.addEventListener('DOMContentLoaded', function(){
    //별점선택 이벤트 리스너
    document.querySelector('.rating').addEventListener('click',function(e){
        let elem = e.target;
        if(elem.classList.contains('rate_radio')){
            rating.setRate(parseInt(elem.value));
        }
    })
});


//상품평 작성 글자수 초과 체크 이벤트 리스너
document.querySelector('.review_textarea').addEventListener('keydown',function(){
    //리뷰 100자 초과 안되게 자동 자름
    let review = document.querySelector('.review_textarea');
    let lengthCheckEx = /^.{100,}$/;
    if(lengthCheckEx.test(review.value)){
        //100자 초과 컷
        review.value = review.value.substr(0,100);
    }
});

//저장 전송전 필드 체크 이벤트 리스너
document.querySelector('#save').addEventListener('click', function(e){
    //별점 선택 안했으면 메시지 표시
    if(rating.rate == 0){
        rating.showMessage('rate');
        return false;
    }
    //리뷰 10자 미만이면 메시지 표시
    if(document.querySelector('.review_textarea').value.length < 10){
        rating.showMessage('review');
        return false;
    }
    //폼 서밋
});

function test(){
	if(document.querySelector('.review_textarea').value.length < 10){
//         rating.showMessage('review');
		alert("kkk")
        return false;
    }
}



</script>
</body>
</html>