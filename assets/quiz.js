/* ============================================================
   昼 · 课件交互组件
   用法：<script src="../assets/quiz.js"></script>
   HTML 结构：
     <div class="quiz-item" data-correct="1" data-why="解释文字">
       <div class="quiz-q">题干</div>
       <ul class="quiz-options">
         <li>A</li><li>B</li><li>C</li><li>D</li>
       </ul>
       <div class="quiz-feedback"></div>
     </div>
   data-correct 是正确选项的 0 基下标；data-why 是选中后显示的解释。
   答错时：标红所选项，并同时用绿框揭示正确项 —— 立即反馈，不罚站。
   ============================================================ */

(function () {
  "use strict";

  function initQuiz(root) {
    var items = root.querySelectorAll(".quiz-item");
    var answered = 0;
    var correctCount = 0;

    items.forEach(function (item) {
      var correctIdx = parseInt(item.getAttribute("data-correct"), 10);
      var why = item.getAttribute("data-why") || "";
      var options = item.querySelectorAll(".quiz-options li");
      var feedback = item.querySelector(".quiz-feedback");
      var done = false;

      options.forEach(function (li, idx) {
        li.addEventListener("click", function () {
          if (done) return;
          done = true;
          answered++;

          options.forEach(function (o) {
            o.classList.add("locked");
          });

          if (idx === correctIdx) {
            li.classList.add("correct");
            correctCount++;
            if (feedback) {
              feedback.innerHTML =
                "<strong>对。</strong> " + why;
              feedback.classList.add("show");
            }
          } else {
            li.classList.add("wrong");
            options[correctIdx].classList.add("reveal");
            if (feedback) {
              feedback.innerHTML =
                "<strong>不对。</strong> " + why;
              feedback.classList.add("show");
            }
          }

          updateScore();
        });
      });
    });

    function updateScore() {
      var scoreEl = root.querySelector(".quiz-score");
      if (!scoreEl) return;
      if (answered === 0) { scoreEl.style.display = "none"; return; }
      scoreEl.style.display = "block";
      var total = items.length;
      if (answered < total) {
        scoreEl.textContent =
          "已答 " + answered + " / " + total + " 题，答对 " + correctCount + " 题";
      } else {
        if (correctCount === total) {
          scoreEl.textContent =
            "全部答对（" + correctCount + " / " + total + "）。这一课的内容你已经能自己复述了。";
        } else if (correctCount >= total - 1) {
          scoreEl.textContent =
            "答对 " + correctCount + " / " + total + "。把答错那道对应的段落再读一遍就够。";
        } else {
          scoreEl.textContent =
            "答对 " + correctCount + " / " + total + "。别急着往下走，先回看标记了「读完能回答」的那几条。";
        }
      }
    }

    var scoreEl = root.querySelector(".quiz-score");
    if (scoreEl) scoreEl.style.display = "none";
  }

  document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".quiz").forEach(initQuiz);
  });
})();
