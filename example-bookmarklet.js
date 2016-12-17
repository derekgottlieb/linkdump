javascript: (function() {
  var el = '
    <div id="bookmarklet" style="
      position:fixed;
      background: #FFF;
      border: 1px #000 solid;
      right:50px;
      top:50px;
      z-index:1000;
      width:250px;
    ">
    Tag: <input type="text" id="tag-input">
    <button id="add-tag">Submit</button></div>';
  document.body.innerHTML += el;
  document.getElementById('add-tag').addEventListener("click", function () {
    xhr = new XMLHttpRequest();

    xhr.open("POST", encodeURI("http://username:password@localhost:9292/api/links"));
    xhr.withCredentials = true;

    xhr.send(JSON.stringify({
      url: document.location.href,
      tags: document.getElementById('tag-input').value
    }));
    document.getElementById('bookmarklet').remove();
  });
}());